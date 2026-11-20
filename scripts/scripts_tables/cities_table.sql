--
-- PostgreSQL database dump
--

\restrict RPb9vuyhB8zjr8juoZt6yu2awjMCmZTOVxre9LzdwiCWfd3MVFjeVgdOiEhqSH7

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-11-17 15:56:14

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
-- TOC entry 223 (class 1259 OID 52914)
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    city text,
    country text,
    population_2025 integer,
    source text
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- TOC entry 5980 (class 0 OID 52914)
-- Dependencies: 223
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cities (city, country, population_2025, source) FROM stdin;
Jakarta	Indonesia	41913860	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Dhaka	Bangladesh	36585479	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Tokyo	Japan	33412512	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
New Delhi	India	30222405	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Shanghai	China	29558908	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Guangzhou	China	27563372	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Cairo	Egypt	25566102	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Manila	Philippines	24735305	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Kolkata	India	22549738	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Seoul	South Korea	22490482	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Karachi	Pakistan	21422590	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Mumbai	India	20203056	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
São Paulo	Brazil	18949790	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Bangkok	Thailand	18180280	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Mexico City	Mexico	17734212	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Beijing	China	17013303	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Lahore	Pakistan	15156430	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Istanbul	Turkey	15014763	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Moscow	Russia	14524753	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Ho Chi Minh City	Vietnam	14052713	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Buenos Aires	Argentina	14017736	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
New York	United States	13920148	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Shenzhen	China	13878396	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Bengaluru	India	13187098	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Osaka	Japan	12964145	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Lagos	Nigeria	12791699	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Los Angeles	United States	12740420	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Luanda	Angola	11370127	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Chennai	India	11153205	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Kinshasa	DR Congo	10943641	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Bogotá	Colombia	10624315	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Lima	Peru	10580241	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
London	United Kingdom	10416420	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Hajipur	India	9941510	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Rio de Janeiro	Brazil	9500336	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Paris	France	9381921	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Hyderabad	India	9190795	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Tehran	Iran	9174964	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Taipei	Taiwan	9136792	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Bandung	Indonesia	8909104	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Kuala Lumpur	Malaysia	8443731	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Dar es Salaam	Tanzania	7795114	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Suzhou	China	7731101	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Ahmedabad	India	7632408	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Hangzhou	China	7500208	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Wuhan	China	7363548	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Tianjin	China	7285342	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Alexandria	Egypt	7266957	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Nagoya	Japan	7146160	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Johannesburg	South Africa	7077175	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Chongqing	China	7071073	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Riyadh	Saudi Arabia	6916417	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Surat	India	6908925	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Surabaya	Indonesia	6843503	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Pune	India	6817951	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Khartoum	Sudan	6809355	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Nanjing	China	6800676	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Santiago	Chile	6726045	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Addis Ababa	Ethiopia	6705705	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Abidjan	Ivory Coast	6621711	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Chaozhou	China	6407770	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Amman	Jordan	6403666	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Baghdad	Iraq	6390735	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Chengdu	China	6139874	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Nairobi	Kenya	6134334	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Kozhikode	India	6123872	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Shenyang	China	5702638	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Kabul	Afghanistan	5635737	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Onitsha	Nigeria	5627706	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Yangon	Myanmar	5618303	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Accra	Ghana	5592780	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Madrid	Spain	5583601	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Faisalabad	Pakistan	5566382	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Toronto	Canada	5494431	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Mashhad	Iran	5398248	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Dubai	UAE	5283789	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Xi’an	China	5231053	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Colombo	Sri Lanka	5223838	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Yaoundé	Cameroon	5106087	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Kochi	India	5077670	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Hanoi	Vietnam	5068414	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Lucknow	India	5052444	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Chattogram	Bangladesh	4983553	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Singapore	Singapore	4963998	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Kampala	Uganda	4880943	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Zhengzhou	China	4878035	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Hefei	China	4867000	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Islamabad	Pakistan	4860084	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Kano	Nigeria	4840280	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Hong Kong	China	4749543	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Saint Petersburg	Russia	4736499	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Santo Domingo	Dominican Republic	4600064	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Cape Town	South Africa	4508921	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Casablanca	Morocco	4457471	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Mogadishu	Somalia	4399430	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Harbin	China	4376259	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Kanpur	India	4329973	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Kumasi	Ghana	4297984	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Damascus	Syria	4287746	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Jeddah	Saudi Arabia	4284080	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Kuwait City	Kuwait	4265132	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Medan	Indonesia	4245895	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Bamako	Mali	4244881	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Luxor	Egypt	4188023	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Belo Horizonte	Brazil	4162814	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Wenzhou	China	4158195	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Sydney	Australia	4150917	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Guadalajara	Mexico	4135440	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Douala	Cameroon	4104516	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Jaipur	India	4071754	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Sanaa	Yemen	4018856	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Taiyuan	China	4005816	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Puning	China	3989322	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Barcelona	Spain	3982704	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Houston	United States	3955046	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Monterrey	Mexico	3938015	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Tashkent	Uzbekistan	3935793	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Antananarivo	Madagascar	3916219	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Varanasi	India	3858863	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Dakar	Senegal	3852475	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Owerri	Nigeria	3833343	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Ürümqi	China	3755144	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Ibadan	Nigeria	3720721	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Recife	Brazil	3691196	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Chicago	United States	3683385	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Brazzaville	Republic of the Congo	3656322	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Melbourne	Australia	3639893	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Qingdao	China	3616657	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Ankara	Turkey	3612251	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Kasaï-Oriental	DR Congo	3605738	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Karaj	Iran	3598661	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Berlin	Germany	3560908	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Savar	Bangladesh	3557381	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Peshawar	Pakistan	3554423	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Lusaka	Zambia	3510723	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Indore	India	3476423	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Jinan	China	3472980	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Changsha	China	3457508	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Medellín	Colombia	3350384	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Changchun	China	3349934	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Patna	India	3309383	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Nanchang	China	3299773	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Nanning	China	3288636	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Quanzhou	China	3286129	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Washington, D.C.	United States	3270018	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Busan	South Korea	3263221	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Nagpur	India	3257841	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Algiers	Algeria	3246400	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Fortaleza	Brazil	3244260	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Kathmandu	Nepal	3231516	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Kunming	China	3228117	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Ouagadougou	Burkina Faso	3206222	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Durban	South Africa	3177927	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Maputo	Mozambique	3166328	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
San Francisco	United States	3163486	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Kalyan-Dombivli	India	3163424	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Guayaquil	Ecuador	3157825	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Salvador	Brazil	3135157	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Gujranwala	Pakistan	3121271	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Athens	Greece	3101979	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Ningbo	China	3094833	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Kollam	India	3074562	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Cebu	Philippines	3044564	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Shijiazhuang	China	2990397	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Multan	Pakistan	2956642	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Thiruvananthapuram	India	2946119	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Asansol	India	2924741	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Aleppo	Syria	2922277	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Brahmanbaria	Bangladesh	2914727	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Miami	United States	2912486	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Fuzhou	China	2910985	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Pyongyang	North Korea	2901588	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Tamluk	India	2894484	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Hyderabad	Pakistan	2863633	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Guatemala City	Guatemala	2837708	https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/
Lubumbashi