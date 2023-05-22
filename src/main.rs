use std::net::{IpAddr, SocketAddr};
use std::sync::Arc;
use std::time::{SystemTime, UNIX_EPOCH};
use std::{env, time::Duration};

use axum::extract::State;
use axum::routing::get;
use axum::Router;
use axum_prometheus::metrics_exporter_prometheus::PrometheusHandle;
use axum_prometheus::PrometheusMetricLayer;
use color_eyre::eyre::Result;
use lazy_static::lazy_static;
use prometheus::{opts, register_gauge, register_gauge_vec, Encoder, Gauge, GaugeVec};
use tokio::{task, time};
use tokio_postgres::{Client, NoTls};

/// This contains the handler to the Prometheus metrics that are generated for axum
struct SharedState {
    metric_handle: PrometheusHandle,
}

/// Represents our CINC Node object
#[derive(Debug)]
struct Node {
    _id: String,
    name: String,
    environment: String,
    _created_at: chrono::NaiveDateTime,
    updated_at: chrono::NaiveDateTime,
}

lazy_static! {
    static ref LAST_CACHE_UPDATE: Gauge = register_gauge!(opts!(
        "cinc_server_exporter_last_updated",
        "last time the cinc_server_exporter cache was updated"
    ))
    .unwrap();
    static ref LAST_UPDATED: GaugeVec = register_gauge_vec!(
        opts!(
            "cinc_server_node_last_updated",
            "last time the node was updated"
        ),
        &["node_name", "environment"]
    )
    .unwrap();
    static ref NODE_COUNT: Gauge = register_gauge!(opts!(
        "cinc_server_node_count",
        "count of the nodes registered to the cinc server"
    ))
    .unwrap();
}

/// Main entrypoint...
#[tokio::main]
async fn main() -> Result<()> {
    color_eyre::install()?;

    let (prometheus_layer, metric_handle) = PrometheusMetricLayer::pair();
    let shared_state = Arc::new(SharedState {
        metric_handle: metric_handle,
    });

    let app = Router::new()
        .route("/", get(root))
        .route("/metrics", get(metrics))
        .with_state(shared_state)
        .layer(prometheus_layer);

    let listen_addr: String =
        env::var("CINC_SERVER_EXPORTER_LISTEN_ADDR").unwrap_or("0.0.0.0".to_string());

    let listen_port: u16 = env::var("CINC_SERVER_EXPORTER_LISTEN_PORT")
        .unwrap_or("9164".to_string())
        .parse::<u16>()?;

    let connection_string: String = env::var("CINC_SERVER_EXPORTER_CONN_STRING")
        .unwrap_or("host=localhost user=opscode-pgsql dbname=opscode_chef".to_string());

    let interval: u64 = env::var("CINC_SERVER_EXPORTER_INTERVAL")
        .unwrap_or("15".to_string())
        .parse::<u64>()?;

    let (client, connection) = tokio_postgres::connect(&connection_string.as_str(), NoTls).await?;
    tokio::spawn(async move {
        if let Err(e) = connection.await {
            eprintln!("connection error: {}", e);
        }
    });

    let forever = task::spawn(async move {
        let _detached = task::spawn(async move {
            let mut interval = time::interval(Duration::from_secs(interval));

            loop {
                interval.tick().await;

                // Handle Node Updates
                let nodes = gather_node_data(&client).await.unwrap();
                for node in nodes {
                    LAST_UPDATED
                        .with_label_values(&[node.name.as_str(), node.environment.as_str()])
                        .set(node.updated_at.timestamp() as f64);
                }

                // Handle Node Count
                let count = gather_node_count(&client).await.unwrap();
                NODE_COUNT.set(count as f64);

                // Set cache update to current timestamp
                let Ok(ts) = SystemTime::now().duration_since(UNIX_EPOCH) else {
                    panic!("SystemTime before UNIX EPOCH!");
                };
                LAST_CACHE_UPDATE.set(ts.as_secs_f64());
            }
        });
    });

    forever.await?;

    let addr = SocketAddr::new(listen_addr.parse::<IpAddr>()?, listen_port);
    axum::Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .unwrap();

    Ok(())
}

/// Queries the database and returns a Vec of Node objects
async fn gather_node_data(client: &Client) -> Result<Vec<Node>> {
    let mut nodes: Vec<Node> = vec![];

    for row in client
        .query(
            "select id, name, environment, created_at, updated_at from nodes;",
            &[],
        )
        .await?
    {
        nodes.push(Node {
            _id: row.get(0),
            name: row.get(1),
            environment: row.get(2),
            _created_at: row.get(3),
            updated_at: row.get(4),
        });
    }

    Ok(nodes)
}

/// Queries the database and returns the node count of the server
async fn gather_node_count(client: &Client) -> Result<i64> {
    let rows = &client.query("select count(*) from nodes;", &[]).await?[0];
    let count: i64 = rows.get("count");

    Ok(count)
}

/// http / handler
async fn root() -> &'static str {
    "Check out /metrics bud..."
}

/// http /metrics handler
async fn metrics(State(state): State<Arc<SharedState>>) -> String {
    // Pull all our cinc metrics from prometheus
    let mut buffer = Vec::new();
    let encoder = prometheus::TextEncoder::new();
    let metric_families = prometheus::gather();
    encoder.encode(&metric_families, &mut buffer).unwrap();
    let cinc_metrics: String = String::from_utf8(buffer.clone()).unwrap();

    // Pull app metrics from our shared state
    let app_metrics = state.metric_handle.render();

    format!("{}\n{}", cinc_metrics, app_metrics)
}
