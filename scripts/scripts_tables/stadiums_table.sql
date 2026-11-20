--
-- PostgreSQL database dump
--

\restrict zPeAvH0RYUJ5mILp8EapeO0M9eyIVScfq6bZfahiGzDHkGpQQ2OY0rIeoMUU0NB

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-11-17 15:57:31

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
-- TOC entry 222 (class 1259 OID 52909)
-- Name: stadiums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stadiums (
    stadium text,
    city text,
    country text,
    stadium_source text,
    capacity integer,
    capacity_source text,
    total_shows integer,
    city_pop_2025 integer,
    population_source text,
    stadium_id integer,
    total_attendance numeric,
    global_attendance_pct numeric,
    tickets_per_capita_pct numeric,
    lat numeric,
    lon numeric,
    geom public.geometry(Point,4326),
    hispanic_main text,
    city_size character varying(50),
    per_capita_class character varying(50)
);


ALTER TABLE public.stadiums OWNER TO postgres;

--
-- TOC entry 5980 (class 0 OID 52909)
-- Dependencies: 222
-- Data for Name: stadiums; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stadiums (stadium, city, country, stadium_source, capacity, capacity_source, total_shows, city_pop_2025, population_source, stadium_id, total_attendance, global_attendance_pct, tickets_per_capita_pct, lat, lon, geom, hispanic_main, city_size, per_capita_class) FROM stdin;
Allianz Parque	São Paulo	Brazil	https://depuertoricopalmundo.com/	55000	https://en.wikipedia.org/wiki/Nubank_Parque	2	18949790	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/	8	110000	3.30	0.58	-23.5506507	-46.6333824	0101000020E610000056EEAAAC125147C0FE04BC71F78C37C0	non-hispanic	megacity	low
Orange Vélodrome	Marseille	France	https://depuertoricopalmundo.com/	67394	https://en.wikipedia.org/wiki/Stade_V%C3%A9lodrome	1	895713	https://worldpopulationreview.com/cities/france/marseille	17	67394	2.02	7.52	43.2963986	5.3777888	0101000020E61000002B2E3311DB82154044CAAA63F0A54540	non-hispanic	medium	medium
Tipstar Dome Chiba	Tokyo	Japan	https://es.wikipedia.org/wiki/Deb%C3%AD_Tirar_M%C3%A1s_Fotos_World_Tour	3600	https://grokipedia.com/page/chiba_velodrome	1	33412512	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/	10	3600	0.11	0.01	35.6768601	139.7638947	0101000020E6100000CF424CD371786140D0BB0C5AA3D64140	non-hispanic	megacity	low
Estadio GNP Seguros	Mexico City	Mexico	https://depuertoricopalmundo.com/	65000	https://es.wikipedia.org/wiki/Estadio_GNP_Seguros	8	17734212	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/	3	520000	15.61	2.93	19.3207722	-99.1514677	0101000020E61000009F7994A5B1C958C04A777C201E523340	hispanic	megacity	low
River Plate Stadium	Buenos Aires	Argentina	https://depuertoricopalmundo.com/	85018	https://es.wikipedia.org/wiki/Estadio_Monumental_(River_Plate)	3	14017736	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/	7	255054	7.66	1.82	-34.6095579	-58.3887904	0101000020E6100000D77F42E2C3314DC05CC246FE054E41C0	hispanic	megacity	low
National Stadium of Peru	Lima	Peru	https://depuertoricopalmundo.com/	50000	https://es.wikipedia.org/wiki/Estadio_Nacional_del_Per%C3%BA	2	10580241	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/	5	100000	3.00	0.95	-12.0459808	-77.0305912	0101000020E6100000E8E2CA34F54153C0E37CA0CB8A1728C0	hispanic	megacity	low
Tottenham Hotspur Stadium	London	United Kingdom	https://depuertoricopalmundo.com/	62850	https://es.wikipedia.org/wiki/Tottenham_Hotspur_Stadium	2	10416420	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/	16	125700	3.77	1.21	51.5074456	-0.1277653	0101000020E6100000FD2488049D5AC0BFE23F38FAF3C04940	non-hispanic	megacity	low
Plenitude Arena	Paris	France	https://depuertoricopalmundo.com/	45000	https://es.wikipedia.org/wiki/Plenitude_Arena	2	9381921	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/	18	90000	2.70	0.96	48.8534951	2.3483915	0101000020E610000094A2957B81C90240ECE5D2533F6D4840	non-hispanic	very large	low
Julio Martínez Prádanos National Stadium	Santiago	Chile	https://depuertoricopalmundo.com/	46190	https://es.wikipedia.org/wiki/Estadio_Nacional_Julio_Mart%C3%ADnez_Pr%C3%A1danos	3	6726045	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/	4	138570	4.16	2.06	9.8694792	-83.7980749	0101000020E6100000894160E5D0AA51C0D34D621058B940C0	hispanic	very large	low
PGE Narodowy	Warsaw	Poland	https://depuertoricopalmundo.com/	58580	https://es.wikipedia.org/wiki/Estadio_Nacional_de_Varsovia#:~:text=El%20estadio%20tiene%20una%20capacidad%20de%2058.500%20espectadores%2C,%28incluyendo%20106%20sitios%20para%20las%20personas%20con%20discapacidad%29.	1	1866729	https://www.citypopulation.de/en/poland/warsaw/	20	58580	1.76	3.14	52.2333742	21.0711489	0101000020E610000079A576D036123540765DAE34DF1D4A40	non-hispanic	large	low
Hiram Bithorn Stadium	San Juan	Puerto Rico	https://depuertoricopalmundo.com/	35000	https://es.wikipedia.org/wiki/Estadio_Hiram_Bithorn	2	291890	https://worldpopulationreview.com/cities/puerto-rico/san-juan	23	70000	2.10	23.98	18.384239	-66.05344	0101000020E610000016139B8F6B8350C006D9B27C5D623240	hispanic	small	very high
Merkur Spiel-Arena	Düsseldorf	Germany	https://depuertoricopalmundo.com/	60000	https://es.wikipedia.org/wiki/Merkur_Spiel-Arena	2	619444	https://www.citypopulation.de/en/germany/nordrheinwestfalen/d%C3%BCsseldorf/05111000__d%C3%BCsseldorf/	14	120000	3.60	19.37	51.2254018	6.7763137	0101000020E61000003DBF83FAF11A1B40D2BA57F7D99C4940	non-hispanic	medium	very high
Estádio da Luz	Lisbon	Portugal	https://depuertoricopalmundo.com/	68100	https://es.wikipedia.org/wiki/Est%C3%A1dio_da_Luz	2	596426	https://es.city-facts.com/lisbon/population	12	136200	4.09	22.84	38.7077507	-9.1365919	0101000020E610000009CC9E5FEF4522C04D1C2F93975A4340	non-hispanic	medium	very high
Félix Sánchez Olympic Stadium	Santo Domingo	Dominican Republic	https://depuertoricopalmundo.com/	50000	https://es.wikipedia.org/wiki/Estadio_Ol%C3%ADmpico_F%C3%A9lix_S%C3%A1nchez	2	4600064	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/	1	100000	3.00	2.17	18.4713858	-69.8918436	0101000020E610000067C92DF7137951C07ECC62BDAC783240	hispanic	large	low
Strawberry Arena	Stockholm	Sweden	https://depuertoricopalmundo.com/	67000	https://es.wikipedia.org/wiki/Nacional_Arena	2	981263	https://bdeex.com/es/naselenie/sweden/stockholm/	19	134000	4.02	13.66	59.3251172	18.0710935	0101000020E61000004B75012F33123240FDAEBE709DA94D40	non-hispanic	medium	high
King Baudouin Stadium	Brussels	Belgium	https://depuertoricopalmundo.com/	50093	https://en.wikipedia.org/wiki/King_Baudouin_Stadium	1	1264392	https://worldpopulationreview.com/cities/belgium/brussels	22	50093	1.50	3.96	50.8467372	4.352493	0101000020E61000009546CCECF36811403F2773E2616C4940	non-hispanic	large	low
ENGIE Stadium	Sydney	Australia	https://depuertoricopalmundo.com/	23500	https://en.wikipedia.org/wiki/Sydney_Showground_Stadium	2	4150917	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/	9	47000	1.41	1.13	-33.8698439	151.2082848	0101000020E61000002088E244AAE6624003907F0B57EF40C0	non-hispanic	large	low
Lluís Companys Olympic Stadium	Barcelona	Spain	https://depuertoricopalmundo.com/	55926	https://en.wikipedia.org/wiki/Estadi_Ol%C3%ADmpic_Llu%C3%ADs_Companys	2	3982704	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/	11	111852	3.36	2.81	41.3825802	2.177073	0101000020E61000007009C03FA56A01406F8C5363F8B04440	hispanic	large	low
Atanasio Girardot Stadium	Medellín	Colombia	https://depuertoricopalmundo.com/	44826	https://es.wikipedia.org/wiki/Estadio_Atanasio_Girardot	3	3350384	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/	6	134478	4.04	4.01	6.2697324	-75.6025597	0101000020E6100000CE588F5690E652C0B5AFF2BA34141940	hispanic	large	low
Riyadh Air Metropolitano	Madrid	Spain	https://depuertoricopalmundo.com/	70813	https://de.wikipedia.org/wiki/Estadio_Metropolitano_(Madrid)	10	5583601	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/	13	708130	21.26	12.68	40.416782	-3.703507	0101000020E61000007C0E2C47C8A00DC0DEC7D11C59354440	hispanic	very large	high
National Stadium of Costa Rica	San José	Costa Rica	https://depuertoricopalmundo.com/	25000	https://es.wikipedia.org/wiki/Estadio_Nacional_de_Costa_Rica_(1924)	2	364062	https://worldpopulationreview.com/cities/costa-rica/san-jose	2	50000	1.50	13.73	9.9327373	-84.0796683	0101000020E6100000C9C11149190555C0C8844EBE8FDD2340	hispanic	small	high
GelreDome	Arnhem	Netherlands	https://depuertoricopalmundo.com/	20000	https://es.wikipedia.org/wiki/Gelredome	2	180884	https://www.aznations.com/population/nl/cities/arnhem	15	40000	1.20	22.11	51.984257	5.9108573	0101000020E61000009C4AABC6B7A41740F6ED2422FCFD4940	non-hispanic	small	very high
Ippodromo Snai La Maura	Milan	Italy	https://depuertoricopalmundo.com/	80000	https://it.wikipedia.org/wiki/Ippodromo_La_Maura	2	2599022	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/	21	160000	4.80	6.16	45.4641943	9.1896346	0101000020E61000004D614AC917612240ACBE04B86ABB4640	non-hispanic	large	medium
\.


-- Completed on 2026-11-17 15:57:32

--
-- PostgreSQL database dump complete
--

\unrestrict zPeAvH0RYUJ5mILp8EapeO0M9eyIVScfq6bZfahiGzDHkGpQQ2OY0rIeoMUU0NB