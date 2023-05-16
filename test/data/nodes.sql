--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.22
-- Dumped by pg_dump version 9.6.22

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: nodes; Type: TABLE; Schema: public; Owner: opscode-pgsql
--

CREATE TABLE public.nodes (
    id character(32) NOT NULL,
    authz_id character(32) NOT NULL,
    org_id character(32) NOT NULL,
    name text NOT NULL,
    environment text NOT NULL,
    last_updated_by character(32) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    serialized_object bytea,
    policy_group character varying(255),
    policy_name character varying(255)
);
ALTER TABLE ONLY public.nodes ALTER COLUMN serialized_object SET STORAGE EXTERNAL;


-- ALTER TABLE public.nodes OWNER TO "opscode-pgsql";

--
-- Data for Name: nodes; Type: TABLE DATA; Schema: public; Owner: opscode-pgsql
--

INSERT INTO public.nodes (id, authz_id, org_id, name, environment, last_updated_by, created_at, updated_at, serialized_object, policy_group, policy_name) VALUES ('00000000000000000000000000000000', '11111111111111111111111111111110', '22222222222222222222222222222220', '0.foo.bar.lan', 'env-0', '33333333333333333333333333333333', '2022-07-26 18:53:13', '2023-05-11 14:06:51', '', NULL, NULL);
INSERT INTO public.nodes (id, authz_id, org_id, name, environment, last_updated_by, created_at, updated_at, serialized_object, policy_group, policy_name) VALUES ('00000000000000000000000000000001', '11111111111111111111111111111111', '22222222222222222222222222222221', '1.foo.bar.lan', 'env-0', '33333333333333333333333333333333', '2022-07-27 18:52:08', '2023-05-11 13:23:23', '', NULL, NULL);
INSERT INTO public.nodes (id, authz_id, org_id, name, environment, last_updated_by, created_at, updated_at, serialized_object, policy_group, policy_name) VALUES ('00000000000000000000000000000002', '11111111111111111111111111111112', '22222222222222222222222222222222', '2.foo.bar.lan', 'env-0', '33333333333333333333333333333333', '2021-11-10 02:17:50', '2023-05-11 14:00:51', '', NULL, NULL);
INSERT INTO public.nodes (id, authz_id, org_id, name, environment, last_updated_by, created_at, updated_at, serialized_object, policy_group, policy_name) VALUES ('00000000000000000000000000000003', '11111111111111111111111111111113', '22222222222222222222222222222223', '3.foo.bar.lan', 'env-0', '33333333333333333333333333333333', '2021-10-12 18:44:42', '2023-05-11 13:58:51', '', NULL, NULL);
INSERT INTO public.nodes (id, authz_id, org_id, name, environment, last_updated_by, created_at, updated_at, serialized_object, policy_group, policy_name) VALUES ('00000000000000000000000000000004', '11111111111111111111111111111114', '22222222222222222222222222222224', '4.foo.bar.lan', 'env-0', '33333333333333333333333333333333', '2022-06-03 12:07:11', '2023-05-11 13:27:02', '', NULL, NULL);
INSERT INTO public.nodes (id, authz_id, org_id, name, environment, last_updated_by, created_at, updated_at, serialized_object, policy_group, policy_name) VALUES ('00000000000000000000000000000005', '11111111111111111111111111111115', '22222222222222222222222222222225', '5.foo.bar.lan', 'env-1', '33333333333333333333333333333333', '2022-12-09 17:28:35', '2023-05-11 13:53:40', '', NULL, NULL);
INSERT INTO public.nodes (id, authz_id, org_id, name, environment, last_updated_by, created_at, updated_at, serialized_object, policy_group, policy_name) VALUES ('00000000000000000000000000000006', '11111111111111111111111111111116', '22222222222222222222222222222226', '6.foo.bar.lan', 'env-1', '33333333333333333333333333333333', '2022-05-09 15:14:22', '2023-05-11 13:26:31', '', NULL, NULL);
INSERT INTO public.nodes (id, authz_id, org_id, name, environment, last_updated_by, created_at, updated_at, serialized_object, policy_group, policy_name) VALUES ('00000000000000000000000000000007', '11111111111111111111111111111117', '22222222222222222222222222222227', '7.foo.bar.lan', 'env-1', '33333333333333333333333333333333', '2023-02-02 14:07:41', '2023-05-11 13:57:12', '', NULL, NULL);
INSERT INTO public.nodes (id, authz_id, org_id, name, environment, last_updated_by, created_at, updated_at, serialized_object, policy_group, policy_name) VALUES ('00000000000000000000000000000008', '11111111111111111111111111111118', '22222222222222222222222222222228', '8.foo.bar.lan', 'env-1', '33333333333333333333333333333333', '2023-02-02 18:24:24', '2023-02-02 18:26:41', '', NULL, NULL);
INSERT INTO public.nodes (id, authz_id, org_id, name, environment, last_updated_by, created_at, updated_at, serialized_object, policy_group, policy_name) VALUES ('00000000000000000000000000000009', '11111111111111111111111111111119', '22222222222222222222222222222229', '9.foo.bar.lan', 'env-1', '33333333333333333333333333333333', '2023-02-06 15:15:10', '2023-02-06 15:20:23', '', NULL, NULL);


--
-- Name: nodes nodes_authz_id_key; Type: CONSTRAINT; Schema: public; Owner: opscode-pgsql
--

ALTER TABLE ONLY public.nodes
    ADD CONSTRAINT nodes_authz_id_key UNIQUE (authz_id);


--
-- Name: nodes nodes_org_id_name_key; Type: CONSTRAINT; Schema: public; Owner: opscode-pgsql
--

ALTER TABLE ONLY public.nodes
    ADD CONSTRAINT nodes_org_id_name_key UNIQUE (org_id, name);


--
-- Name: nodes nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: opscode-pgsql
--

ALTER TABLE ONLY public.nodes
    ADD CONSTRAINT nodes_pkey PRIMARY KEY (id);


--
-- Name: nodes_org_id_environment_index; Type: INDEX; Schema: public; Owner: opscode-pgsql
--

CREATE INDEX nodes_org_id_environment_index ON public.nodes USING btree (org_id, environment);


--
-- Name: nodes_policy_group; Type: INDEX; Schema: public; Owner: opscode-pgsql
--

CREATE INDEX nodes_policy_group ON public.nodes USING btree (org_id, policy_group);


--
-- Name: nodes_policy_name; Type: INDEX; Schema: public; Owner: opscode-pgsql
--

CREATE INDEX nodes_policy_name ON public.nodes USING btree (org_id, policy_name);


--
-- Name: TABLE nodes; Type: ACL; Schema: public; Owner: opscode-pgsql
--

-- GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.nodes TO opscode_chef;
-- GRANT SELECT ON TABLE public.nodes TO opscode_chef_ro;


--
-- PostgreSQL database dump complete
--

