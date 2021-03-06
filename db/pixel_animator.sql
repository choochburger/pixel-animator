--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.1
-- Dumped by pg_dump version 9.3.1
-- Started on 2013-12-21 17:47:03 EST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 174 (class 3079 OID 12018)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2217 (class 0 OID 0)
-- Dependencies: 174
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 170 (class 1259 OID 16464)
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    avatar text,
    first_name text,
    last_name text,
    service text,
    service_user_id text
);


--
-- TOC entry 171 (class 1259 OID 16470)
-- Name: user_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2218 (class 0 OID 0)
-- Dependencies: 171
-- Name: user_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_accounts_id_seq OWNED BY users.id;


--
-- TOC entry 172 (class 1259 OID 16472)
-- Name: user_animations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_animations (
    id integer NOT NULL,
    user_id integer,
    title text,
    data text
);


--
-- TOC entry 173 (class 1259 OID 16478)
-- Name: user_animations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_animations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2219 (class 0 OID 0)
-- Dependencies: 173
-- Name: user_animations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_animations_id_seq OWNED BY user_animations.id;


--
-- TOC entry 2098 (class 2604 OID 16490)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_animations ALTER COLUMN id SET DEFAULT nextval('user_animations_id_seq'::regclass);


--
-- TOC entry 2097 (class 2604 OID 16489)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('user_accounts_id_seq'::regclass);


--
-- TOC entry 2100 (class 2606 OID 16493)
-- Name: user_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT user_accounts_pkey PRIMARY KEY (id);


--
-- TOC entry 2102 (class 2606 OID 16495)
-- Name: user_animations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_animations
    ADD CONSTRAINT user_animations_pkey PRIMARY KEY (id);


--
-- TOC entry 2216 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM chrislyons;
GRANT ALL ON SCHEMA public TO chrislyons;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-12-21 17:47:03 EST

--
-- PostgreSQL database dump complete
--

