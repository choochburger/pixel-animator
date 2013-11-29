--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.1
-- Dumped by pg_dump version 9.3.1
-- Started on 2013-11-29 13:23:41 EST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 2231 (class 1262 OID 16394)
-- Name: pixel_animator; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE pixel_animator WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


\connect pixel_animator

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 176 (class 3079 OID 12018)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2234 (class 0 OID 0)
-- Dependencies: 176
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 172 (class 1259 OID 16428)
-- Name: user_accounts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_accounts (
    user_id integer NOT NULL,
    id integer NOT NULL,
    avatar text,
    first_name text,
    last_name text,
    service text
);


--
-- TOC entry 173 (class 1259 OID 16431)
-- Name: user_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2235 (class 0 OID 0)
-- Dependencies: 173
-- Name: user_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_accounts_id_seq OWNED BY user_accounts.id;


--
-- TOC entry 174 (class 1259 OID 16443)
-- Name: user_animations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_animations (
    id integer NOT NULL,
    user_id integer,
    data text
);


--
-- TOC entry 175 (class 1259 OID 16446)
-- Name: user_animations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_animations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2236 (class 0 OID 0)
-- Dependencies: 175
-- Name: user_animations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_animations_id_seq OWNED BY user_animations.id;


--
-- TOC entry 170 (class 1259 OID 16397)
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    created date DEFAULT now() NOT NULL,
    id integer NOT NULL,
    name text
);


--
-- TOC entry 2237 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN users.name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN users.name IS 'This will default to first name + last name from whatever the user signs in with first';


--
-- TOC entry 171 (class 1259 OID 16419)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2238 (class 0 OID 0)
-- Dependencies: 171
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 2106 (class 2604 OID 16433)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_accounts ALTER COLUMN id SET DEFAULT nextval('user_accounts_id_seq'::regclass);


--
-- TOC entry 2107 (class 2604 OID 16448)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_animations ALTER COLUMN id SET DEFAULT nextval('user_animations_id_seq'::regclass);


--
-- TOC entry 2105 (class 2604 OID 16421)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- TOC entry 2223 (class 0 OID 16428)
-- Dependencies: 172
-- Data for Name: user_accounts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_accounts (user_id, id, avatar, first_name, last_name, service) FROM stdin;
\.


--
-- TOC entry 2239 (class 0 OID 0)
-- Dependencies: 173
-- Name: user_accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_accounts_id_seq', 1, false);


--
-- TOC entry 2225 (class 0 OID 16443)
-- Dependencies: 174
-- Data for Name: user_animations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_animations (id, user_id, data) FROM stdin;
\.


--
-- TOC entry 2240 (class 0 OID 0)
-- Dependencies: 175
-- Name: user_animations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_animations_id_seq', 1, false);


--
-- TOC entry 2221 (class 0 OID 16397)
-- Dependencies: 170
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY users (created, id, name) FROM stdin;
\.


--
-- TOC entry 2241 (class 0 OID 0)
-- Dependencies: 171
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


--
-- TOC entry 2111 (class 2606 OID 16435)
-- Name: user_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_accounts
    ADD CONSTRAINT user_accounts_pkey PRIMARY KEY (id);


--
-- TOC entry 2113 (class 2606 OID 16450)
-- Name: user_animations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_animations
    ADD CONSTRAINT user_animations_pkey PRIMARY KEY (id);


--
-- TOC entry 2109 (class 2606 OID 16423)
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2233 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM chrislyons;
GRANT ALL ON SCHEMA public TO chrislyons;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-11-29 13:23:41 EST

--
-- PostgreSQL database dump complete
--

