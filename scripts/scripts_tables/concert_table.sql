--
-- PostgreSQL database dump
--

\restrict hsU4s7Znc4Lumm5kmBMKh0Lpyi9nf9HohhwKrzd3e89n8O24TQ2GgTDxXWa6AsY

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-11-17 15:56:58

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 52889)
-- Name: concerts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.concerts (
    concert_date date,
    city text,
    country text,
    stadium text,
    source text,
    concert_id integer
);


ALTER TABLE public.concerts OWNER TO postgres;

--
-- TOC entry 5980 (class 0 OID 52889)
-- Dependencies: 221
-- Data for Name: concerts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.concerts (concert_date, city, country, stadium, source, concert_id) FROM stdin;
2025-11-21	Santo Domingo	Dominican Republic	Félix Sánchez Olympic Stadium	https://depuertoricopalmundo.com/	1
2025-11-22	Santo Domingo	Dominican Republic	Félix Sánchez Olympic Stadium	https://depuertoricopalmundo.com/	2
2025-12-05	San José	Costa Rica	National Stadium of Costa Rica	https://depuertoricopalmundo.com/	3
2025-12-06	San José	Costa Rica	National Stadium of Costa Rica	https://depuertoricopalmundo.com/	4
2025-12-10	Mexico City	Mexico	Estadio GNP Seguros	https://depuertoricopalmundo.com/	5
2025-12-11	Mexico City	Mexico	Estadio GNP Seguros	https://depuertoricopalmundo.com/	6
2025-12-12	Mexico City	Mexico	Estadio GNP Seguros	https://depuertoricopalmundo.com/	7
2025-12-15	Mexico City	Mexico	Estadio GNP Seguros	https://depuertoricopalmundo.com/	8
2025-12-16	Mexico City	Mexico	Estadio GNP Seguros	https://depuertoricopalmundo.com/	9
2025-12-19	Mexico City	Mexico	Estadio GNP Seguros	https://depuertoricopalmundo.com/	10
2025-12-20	Mexico City	Mexico	Estadio GNP Seguros	https://depuertoricopalmundo.com/	11
2025-12-21	Mexico City	Mexico	Estadio GNP Seguros	https://depuertoricopalmundo.com/	12
2026-01-09	Santiago	Chile	Julio Martínez Prádanos National Stadium	https://depuertoricopalmundo.com/	13
2026-01-10	Santiago	Chile	Julio Martínez Prádanos National Stadium	https://depuertoricopalmundo.com/	14
2026-01-11	Santiago	Chile	Julio Martínez Prádanos National Stadium	https://depuertoricopalmundo.com/	15
2026-01-16	Lima	Peru	National Stadium of Peru	https://depuertoricopalmundo.com/	16
2026-01-17	Lima	Peru	National Stadium of Peru	https://depuertoricopalmundo.com/	17
2026-01-23	Medellín	Colombia	Atanasio Girardot Stadium	https://depuertoricopalmundo.com/	18
2026-01-24	Medellín	Colombia	Atanasio Girardot Stadium	https://depuertoricopalmundo.com/	19
2026-01-25	Medellín	Colombia	Atanasio Girardot Stadium	https://depuertoricopalmundo.com/	20
2026-02-13	Buenos Aires	Argentina	River Plate Stadium	https://depuertoricopalmundo.com/	21
2026-02-14	Buenos Aires	Argentina	River Plate Stadium	https://depuertoricopalmundo.com/	22
2026-02-15	Buenos Aires	Argentina	River Plate Stadium	https://depuertoricopalmundo.com/	23
2026-02-20	São Paulo	Brazil	Allianz Parque	https://depuertoricopalmundo.com/	24
2026-02-21	São Paulo	Brazil	Allianz Parque	https://depuertoricopalmundo.com/	25
2026-02-28	Sydney	Australia	ENGIE Stadium	https://depuertoricopalmundo.com/	26
2026-03-01	Sydney	Australia	ENGIE Stadium	https://depuertoricopalmundo.com/	27
2026-03-07	Tokyo	Japan	\N	https://depuertoricopalmundo.com/	28
2026-05-22	Barcelona	Spain	Lluís Companys Olympic Stadium	https://depuertoricopalmundo.com/	29
2026-05-23	Barcelona	Spain	Lluís Companys Olympic Stadium	https://depuertoricopalmundo.com/	30
2026-05-26	Lisbon	Portugal	Estádio da Luz	https://depuertoricopalmundo.com/	31
2026-05-27	Lisbon	Portugal	Estádio da Luz	https://depuertoricopalmundo.com/	32
2026-05-30	Madrid	Spain	Riyadh Air Metropolitano	https://depuertoricopalmundo.com/	33
2026-05-31	Madrid	Spain	Riyadh Air Metropolitano	https://depuertoricopalmundo.com/	34
2026-06-02	Madrid	Spain	Riyadh Air Metropolitano	https://depuertoricopalmundo.com/	35
2026-06-03	Madrid	Spain	Riyadh Air Metropolitano	https://depuertoricopalmundo.com/	36
2026-06-06	Madrid	Spain	Riyadh Air Metropolitano	https://depuertoricopalmundo.com/	37
2026-06-07	Madrid	Spain	Riyadh Air Metropolitano	https://depuertoricopalmundo.com/	38
2026-06-10	Madrid	Spain	Riyadh Air Metropolitano	https://depuertoricopalmundo.com/	39
2026-06-11	Madrid	Spain	Riyadh Air Metropolitano	https://depuertoricopalmundo.com/	40
2026-06-14	Madrid	Spain	Riyadh Air Metropolitano	https://depuertoricopalmundo.com/	41
2026-06-15	Madrid	Spain	Riyadh Air Metropolitano	https://depuertoricopalmundo.com/	42
2026-06-20	Düsseldorf	Germany	Merkur Spiel-Arena	https://depuertoricopalmundo.com/	43
2026-06-21	Düsseldorf	Germany	Merkur Spiel-Arena	https://depuertoricopalmundo.com/	44
2026-06-23	Arnhem	Netherlands	GelreDome	https://depuertoricopalmundo.com/	45
2026-06-24	Arnhem	Netherlands	GelreDome	https://depuertoricopalmundo.com/	46
2026-06-27	London	United Kingdom	Tottenham Hotspur Stadium	https://depuertoricopalmundo.com/	47
2026-06-28	London	United Kingdom	Tottenham Hotspur Stadium	https://depuertoricopalmundo.com/	48
2026-07-01	Marseille	France	Orange Vélodrome	https://depuertoricopalmundo.com/	49
2026-07-04	Paris	France	La Défense Arena	https://depuertoricopalmundo.com/	50
2026-07-05	Paris	France	La Défense Arena	https://depuertoricopalmundo.com/	51
2026-07-10	Stockholm	Sweden	Strawberry Arena	https://depuertoricopalmundo.com/	52
2026-07-11	Stockholm	Sweden	Strawberry Arena	https://depuertoricopalmundo.com/	53
2026-07-14	Warsaw	Poland	PGE Narodowy	https://depuertoricopalmundo.com/	54
2026-07-17	Milan	Italy	Ippodromo Snai La Maura	https://depuertoricopalmundo.com/	55
2026-07-18	Milan	Italy	Ippodromo Snai La Maura	https://depuertoricopalmundo.com/	56
2026-07-22	Brussels	Belgium	King Baudouin Stadium	https://depuertoricopalmundo.com/	57
2026-