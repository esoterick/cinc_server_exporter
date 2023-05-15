<a name="readme-top"></a>

[![Crates][crates-io]][crates-io-url]
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <h3 align="center">CINC-Server Exporter</h3>

  <p align="center">
    A prometheus exporter for <a href="https://cinc.sh/">CINC Server</a> and CINC compatible configuration management solutions.
    <br />
    <a href="https://github.com/esoterick/cinc_server_exporter"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/esoterick/cinc_server_exporter/issues">Report Bug</a>
    ·
    <a href="https://github.com/esoterick/cinc_server_exporter/issues">Request Feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#development-setup">Development Setup</a>
            <ul>
                <li><a href="#recommended-prerequesites">Recommended prerequesites</a></li>
                <li><a href="#building-and-running">Building and running</a></li>
            </ul>
        </li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## About The Project

While working at my current gig I found we were lacking some metrics to gain a deeper visibility in to our infrastructure. I built this exporter to fill some of those gaps.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->

## Getting Started

This project assumes you have cinc-server installed with the default database settings.

### Installation

1. Switch to the database user
   ```sh
   sudo su - opscode-pgsql
   ```
2. pull latest release
   ```sh
   wget # automated builds/releases coming soon
   ```
3. run the service
   ```sh
   ./cinc_server_exporter
   ```
4. test
   ```sh
   curl http://localhost:9165/metrics
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Development Setup

#### Recommended prerequesites

- nix
- devenv.sh
- direnv

#### Building and running

1. Pull latest code
   ```sh
   git clone https://github.com/esoterick/cinc_server_exporter.git
   ```
2. Enter project directory
   ```sh
   cd cinc_server_exporter
   ```
3. Allow direnv and let nix to do it's thing
   ```sh
   direnv allow .
   ```
4. Run test database
   ```
   devenv up
   ```
5. Import Test Data
   ```sh
   # coming soon :(
   ```
6. Run exporter
   ```sh
   cargo run
   ```
7. Scrape
   ```sh
   curl http://localhost:9165/metrics
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->

## Usage

There are a handful of options to configure the exporter which is done via the following environment variables.

- CINC_SERVER_EXPORTER_CONN_STRING - Postgres connection string to the CINC database
- CINC_SERVER_EXPORTER_INTERVAL - Interval to scrape the database in seconds

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ROADMAP -->

## Roadmap

- [ ] Add changelog
- [ ] Add test data
- [ ] Add tests
- [ ] Document configuration options
- [ ] Add automated builds
- [ ] Add release url to docs

See the [open issues](https://github.com/esoterick/cinc_server_exporter/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## Contributing

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->

## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->

## Contact

Robert J. Lambert III - robert.j.lambert@pm.me
Project Link: [https://github.com/esoterick/cinc_server_exporter](https://github.com/esoterick/cinc_server_exporter)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->

## Acknowledgments

- [Rust](https://www.rust-lang.org/)
- [CINC](https://cinc.sh/)
- [Nix](https://nixos.org/)
- [devenv](https://devenv.sh/)
- [Best-README-Template](https://github.com/othneildrew/Best-README-Template)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->

[contributors-shield]: https://img.shields.io/github/contributors/esoterick/cinc_server_exporter.svg?style=for-the-badge
[contributors-url]: https://github.com/esoterick/cinc_server_exporter/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/esoterick/cinc_server_exporter.svg?style=for-the-badge
[forks-url]: https://github.com/esoterick/cinc_server_exporter/network/members
[stars-shield]: https://img.shields.io/github/stars/esoterick/cinc_server_exporter.svg?style=for-the-badge
[stars-url]: https://github.com/esoterick/cinc_server_exporter/stargazers
[issues-shield]: https://img.shields.io/github/issues/esoterick/cinc_server_exporter.svg?style=for-the-badge
[issues-url]: https://github.com/esoterick/cinc_server_exporter/issues
[license-shield]: https://img.shields.io/github/license/esoterick/cinc_server_exporter.svg?style=for-the-badge
[license-url]: https://github.com/esoterick/cinc_server_exporter/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/rlambert
[crates-io]: https://img.shields.io/crates/dv/cinc_server_exporter/0.1.0?style=for-the-badge
[crates-io-url]: https://crates.io/crates/cinc_server_exporter
