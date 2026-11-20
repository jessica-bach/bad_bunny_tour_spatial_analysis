--------------------------------------------------------------------------------
-- PROJECT: Spatial and Logistics Analysis of the "Debí tirar más fotos Tour" (Bad Bunny)
-- DATABASE MANAGEMENT SYSTEM: PostgreSQL / PostGIS
-- DESCRIPTION: Comprehensive script for processing, enriching, and spatial analysis
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- SECTION 2: CREATION AND ENRICHMENT OF THE "STADIUMS" TABLE
--------------------------------------------------------------------------------

-- 2.1. Extraction of unique venues
-- Isolate unique stadiums and cities from concert events using SELECT DISTINCT
-- to remove duplicates caused by multiple dates at the same venue.
DROP TABLE IF EXISTS estadios;

CREATE TABLE estadios (
    estadio text,
    ciudad  text,
    pais    text
);

INSERT INTO estadios (estadio, ciudad, pais)
SELECT DISTINCT estadio, ciudad, pais
FROM conciertos;


-- 2.2. Restructuring and addition of capacities and metadata
-- Replace the previous table with a more robust schema that includes each venue's
-- theoretical maximum capacity and its reference sources.
DROP TABLE estadios;

CREATE TABLE estadios (
    estadio          text,
    ciudad           text,
    pais             text,
    fuente_estadio   text,
    capacidad        integer,
    fuente_capacidad text
);

-- Manual insertion of verified capacities for live music events.
INSERT INTO estadios (estadio, ciudad, pais, fuente_estadio, capacidad, fuente_capacidad) VALUES
('King Baudouin Stadium','Bruselas','Bélgica','https://depuertoricopalmundo.com/',50093,'https://en.wikipedia.org/wiki/King_Baudouin_Stadium'),
('Tipstar Dome Chiba','Tokio','Japón','https://es.wikipedia.org/wiki/Deb%C3%AD_Tirar_M%C3%A1s_Fotos_World_Tour',3600,'https://grokipedia.com/page/chiba_velodrome'),
('PGE Narodowy','Varsovia','Polonia','https://depuertoricopalmundo.com/',58580,'https://es.wikipedia.org/wiki/Estadio_Nacional_de_Varsovia'),
('Estadi Olímpic Lluís Companys','Barcelona','España','https://depuertoricopalmundo.com/',55926,'https://en.wikipedia.org/wiki/Estadi_Ol%C3%ADmpic_Llu%C3%ADs_Companys'),
('Estadio Nacional Julio Martínez Prádanos','Santiago','Chile','https://depuertoricopalmundo.com/',46190,'https://es.wikipedia.org/wiki/Estadio_Nacional_Julio_Mart%C3%ADnez_Pr%C3%A1danos'),
('Riyadh Air Metropolitano','Madrid','España','https://depuertoricopalmundo.com/',70813,'https://de.wikipedia.org/wiki/Estadio_Metropolitano_(Madrid)'),
('Estadio Hiram Bithorn','San Juan','Puerto Rico','https://depuertoricopalmundo.com/',35000,'https://es.wikipedia.org/wiki/Estadio_Hiram_Bithorn'),
('Merkur Spiel-Arena','Düsseldorf','Alemania','https://depuertoricopalmundo.com/',60000,'https://es.wikipedia.org/wiki/Merkur_Spiel-Arena'),
('Estadio da Luz','Lisboa','Portugal','https://depuertoricopalmundo.com/',68100,'https://es.wikipedia.org/wiki/Est%C3%A1dio_da_Luz'),
('Estadio River Plate','Buenos Aires','Argentina','https://depuertoricopalmundo.com/',85018,'https://es.wikipedia.org/wiki/Estadio_Monumental_(River_Plate)'),
('Strawberry Arena','Estocolmo','Suecia','https://depuertoricopalmundo.com/',67000,'https://es.wikipedia.org/wiki/Nacional_Arena'),
('Tottenham Hotspur Stadium','Londres','Reino Unido','https://depuertoricopalmundo.com/',62850,'https://es.wikipedia.org/wiki/Tottenham_Hotspur_Stadium'),
('Estadio Atanasio Girardot','Medellín','Colombia','https://depuertoricopalmundo.com/',44826,'https://es.wikipedia.org/wiki/Estadio_Atanasio_Girardot'),
('Estadio GNP Seguros','Ciudad de México','México','https://depuertoricopalmundo.com/',65000,'https://es.wikipedia.org/wiki/Estadio_GNP_Seguros'),
('Estadio Nacional de Costa Rica','San José','Costa Rica','https://depuertoricopalmundo.com/',25000,'https://es.wikipedia.org/wiki/Estadio_Nacional_de_Costa_Rica_(1924)'),
('Estadio Olímpico Félix Sánchez','Santo Domingo','República Dominicana','https://depuertoricopalmundo.com/',50000,'https://es.wikipedia.org/wiki/Estadio_Ol%C3%ADmpico_F%C3%A9lix_S%C3%A1nchez'),
('Plenitude Arena','París','Francia','https://depuertoricopalmundo.com/',45000,'https://es.wikipedia.org/wiki/Plenitude_Arena'),
('Estadio Nacional del Perú','Lima','Perú','https://depuertoricopalmundo.com/',50000,'https://es.wikipedia.org/wiki/Estadio_Nacional_del_Per%C3%BA'),
('GelreDome','Arnhem','Países Bajos','https://depuertoricopalmundo.com/',20000,'https://es.wikipedia.org/wiki/Gelredome'),
('ENGIE Stadium','Sídney','Australia','https://depuertoricopalmundo.com/',23500,'https://en.wikipedia.org/wiki/Sydney_Showground_Stadium'),
('Allianz Parque','San Pablo','Brasil','https://depuertoricopalmundo.com/',55000,'https://en.wikipedia.org/wiki/Nubank_Parque'),
('Ippodromo Snai La Maura','Milán','Italia','https://depuertoricopalmundo.com/',80000,'https://it.wikipedia.org/wiki/Ippodromo_La_Maura'),
('Orange Vélodrome','Marsella','Francia','https://depuertoricopalmundo.com/',67394,'https://en.wikipedia.org/wiki/Stade_V%C3%A9lodrome');


-- 2.2.2. Calculation of show frequency per stadium
-- Add the total_shows column and calculate it by grouping records from the concerts table.
ALTER TABLE estadios
ADD COLUMN total_shows integer;

UPDATE estadios e
SET total_shows = sub.cantidad
FROM (
    SELECT ciudad, COUNT(*) AS cantidad
    FROM conciertos
    GROUP BY ciudad
) sub
WHERE e.ciudad = sub.ciudad;


-- 2.2.3. Integration of demographic data (2025 Population)
-- Create an auxiliary table with the global urban population report (Worldometer).
DROP TABLE IF EXISTS ciudades;

CREATE TABLE ciudades (
    ciudad         text,
    pais           text,
    poblacion_2025 integer,
    fuente         text
);

-- (Note: Insertion of the global dataset of 200 cities provided in the original script...)
-- Insertion of data compiled from Worldometer
INSERT INTO ciudades (ciudad, pais, poblacion_2025, fuente) VALUES
('Yakarta','Indonesia',41913860,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Daca','Bangladés',36585479,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Tokio','Japón',33412512,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Nueva Delhi','India',30222405,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Shanghái','China',29558908,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Cantón','China',27563372,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('El Cairo','Egipto',25566102,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Manila','Filipinas',24735305,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Calcuta','India',22549738,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Seúl','Corea del Sur',22490482,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Karachi','Pakistán',21422590,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Bombay','India',20203056,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('San Pablo','Brasil',18949790,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Bangkok','Tailandia',18180280,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Ciudad de México','México',17734212,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Pekín','China',17013303,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Lahore','Pakistán',15156430,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Estambul','Turquía',15014763,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Moscú','Rusia',14524753,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Ciudad Ho Chi Minh','Vietnam',14052713,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Buenos Aires','Argentina',14017736,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Nueva York','Estados Unidos',13920148,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Shenzhen','China',13878396,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Bangalore','India',13187098,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Osaka','Japón',12964145,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Lagos','Nigeria',12791699,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Los Ángeles','Estados Unidos',12740420,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Luanda','Angola',11370127,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Chennai','India',11153205,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kinsasa','RD Congo',10943641,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Bogotá','Colombia',10624315,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Lima','Perú',10580241,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Londres','Reino Unido',10416420,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Hajipur','India',9941510,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Río de Janeiro','Brasil',9500336,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('París','Francia',9381921,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Hyderabad','India',9190795,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Teherán','Irán',9174964,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Taipéi','Taiwán',9136792,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Bandung','Indonesia',8909104,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kuala Lumpur','Malasia',8443731,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Dar es-Salam','Tanzania',7795114,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Suzhou','China',7731101,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Ahmedabad','India',7632408,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Hangzhou','China',7500208,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Wuhan','China',7363548,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Tianjin','China',7285342,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Alejandría','Egipto',7266957,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Nagoya','Japón',7146160,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Johannesburgo','Sudáfrica',7077175,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Chongqing','China',7071073,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Riad','Arabia Saudita',6916417,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Surat','India',6908925,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Surabaya','Indonesia',6843503,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Pune','India',6817951,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Jartum','Sudán',6809355,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Nankín','China',6800676,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Santiago','Chile',6726045,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Adís Abeba','Etiopía',6705705,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Abiyán','Costa de Marfil',6621711,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Chaozhou','China',6407770,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Amán','Jordania',6403666,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Bagdad','Irak',6390735,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Chengdu','China',6139874,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Nairobi','Kenia',6134334,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kozhikode','India',6123872,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Shenyang','China',5702638,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kabul','Afganistán',5635737,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Onitsha','Nigeria',5627706,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Yangón','Myanmar',5618303,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Acra','Ghana',5592780,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Madrid','España',5583601,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Faisalabad','Pakistán',5566382,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Toronto','Canadá',5494431,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Mashhad','Irán',5398248,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Dubái','EAU',5283789,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Xi’an','China',5231053,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Colombo','Sri Lanka',5223838,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Yaundé','Camerún',5106087,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kochi','India',5077670,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Hanói','Vietnam',5068414,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Lucknow','India',5052444,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Chattogram','Bangladés',4983553,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Singapur','Singapur',4963998,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kampala','Uganda',4880943,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Zhengzhou','China',4878035,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Hefei','China',4867000,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Islamabad','Pakistán',4860084,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kano','Nigeria',4840280,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Hong Kong','China',4749543,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('San Petersburgo','Rusia',4736499,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Santo Domingo','República Dominicana',4600064,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Ciudad del Cabo','Sudáfrica',4508921,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Casablanca','Marruecos',4457471,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Mogadiscio','Somalia',4399430,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Harbin','China',4376259,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kanpur','India',4329973,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kumasi','Ghana',4297984,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Damasco','Siria',4287746,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Yeda','Arabia Saudita',4284080,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kuwait','Kuwait',4265132,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Medan','Indonesia',4245895,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Bamako','Malí',4244881,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Luxor','Egipto',4188023,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Belo Horizonte','Brasil',4162814,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Wenzhou','China',4158195,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Sídney','Australia',4150917,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Guadalajara','México',4135440,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Douala','Camerún',4104516,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Jaipur','India',4071754,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Saná','Yemen',4018856,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Taiyuan','China',4005816,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Puning','China',3989322,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Barcelona','España',3982704,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Houston','Estados Unidos',3955046,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Monterrey','México',3938015,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Taskent','Uzbekistán',3935793,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Antananarivo','Madagascar',3916219,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Varanasi','India',3858863,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Dakar','Senegal',3852475,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Owerri','Nigeria',3833343,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Ürümqi','China',3755144,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Ibadan','Nigeria',3720721,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Recife','Brasil',3691196,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Chicago','Estados Unidos',3683385,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Brazzaville','Congo',3656322,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Melbourne','Australia',3639893,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Qingdao','China',3616657,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Ankara','Turquía',3612251,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kasaï-Oriental','RD Congo',3605738,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Karaj','Irán',3598661,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Berlín','Alemania',3560908,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Savar','Bangladés',3557381,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Peshawar','Pakistán',3554423,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Lusaka','Zambia',3510723,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Indore','India',3476423,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Jinan','China',3472980,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Changsha','China',3457508,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Medellín','Colombia',3350384,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Changchun','China',3349934,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Patna','India',3309383,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Nanchang','China',3299773,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Nanning','China',3288636,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Quanzhou','China',3286129,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Washington D. C.','Estados Unidos',3270018,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Busán','Corea del Sur',3263221,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Nagpur','India',3257841,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Argel','Argelia',3246400,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Fortaleza','Brasil',3244260,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Katmandú','Nepal',3231516,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kunming','China',3228117,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Uagadugú','Burkina Faso',3206222,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Durban','Sudáfrica',3177927,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Maputo','Mozambique',3166328,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('San Francisco','Estados Unidos',3163486,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kalyan-Dombivli','India',3163424,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Guayaquil','Ecuador',3157825,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Salvador','Brasil',3135157,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Gujranwala','Pakistán',3121271,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Atenas','Grecia',3101979,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Ningbo','China',3094833,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kollam','India',3074562,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Cebú','Filipinas',3044564,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Shijiazhuang','China',2990397,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Multán','Pakistán',2956642,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Thiruvananthapuram','India',2946119,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Asansol','India',2924741,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Alepo','Siria',2922277,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Brahmanbaria','Bangladés',2914727,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Miami','Estados Unidos',2912486,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Fuzhou','China',2910985,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Pionyang','Corea del Norte',2901588,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Tamluk','India',2894484,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Hyderabad','Pakistán',2863633,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Ciudad de Guatemala','Guatemala',2837708,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Lubumbashi','RD Congo',2832853,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Tasikmalaya','Indonesia',2827255,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Dalian','China',2796248,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Yogyakarta','Indonesia',2793747,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Agra','India',2786762,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Nápoles','Italia',2767923,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Coyah','Guinea',2727684,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Essen','Alemania',2717087,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Cali','Colombia',2700232,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Guiyang','China',2686949,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Semarang','Indonesia',2679349,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Montreal','Canadá',2668723,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Esmirna','Turquía',2650237,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Changzhou','China',2649836,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Tel Aviv','Israel',2642872,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Birmingham','Reino Unido',2631757,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kiev','Ucrania',2614581,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Wuxi','China',2613100,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Milán','Italia',2599022,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Caracas','Venezuela',2576666,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Manchester','Reino Unido',2535427,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Quito','Ecuador',2534914,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Cotonú','Benín',2506489,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Bhopal','India',2487205,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Curitiba','Brasil',2475352,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/');


-- Automatic population linkage via JOIN
ALTER TABLE estadios
ADD COLUMN pob_ciudad_2025 integer;

UPDATE estadios e
SET pob_ciudad_2025 = c.poblacion_2025
FROM ciudades c
WHERE e.ciudad = c.ciudad
  AND e.pais = c.pais;

-- Add population source metadata for matched records
ALTER TABLE estadios
ADD COLUMN fuente_poblacion text;

UPDATE estadios
SET fuente_poblacion = 'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'
WHERE pob_ciudad_2025 IS NOT NULL;

-- Audit NULL values (tour cities outside Worldometer's global top list)
SELECT *
FROM estadios
WHERE pob_ciudad_2025 IS NULL;

-- Manual, individual population updates for smaller tour cities
UPDATE estadios SET pob_ciudad_2025 = 1264392, fuente_poblacion = 'https://worldpopulationreview.com/cities/belgium/brussels' WHERE ciudad ILIKE 'brusel%' AND pob_ciudad_2025 IS NULL;
UPDATE estadios SET pob_ciudad_2025 = 1866729, fuente_poblacion = 'https://www.citypopulation.de/en/poland/warsaw/' WHERE ciudad ILIKE 'varso%' AND pob_ciudad_2025 IS NULL;
UPDATE estadios SET pob_ciudad_2025 = 291890,  fuente_poblacion = 'https://worldpopulationreview.com/cities/puerto-rico/san-juan' WHERE ciudad ILIKE 'san juan%' AND pob_ciudad_2025 IS NULL;
UPDATE estadios SET pob_ciudad_2025 = 619444,  fuente_poblacion = 'https://www.citypopulation.de/en/germany/nordrheinwestfalen/d%C3%BCsseldorf/05111000__d%C3%BCsseldorf/' WHERE ciudad ILIKE 'd%sseldorf%' AND pob_ciudad_2025 IS NULL;
UPDATE estadios SET pob_ciudad_2025 = 596426,  fuente_poblacion = 'https://es.city-facts.com/lisbon/population' WHERE ciudad ILIKE 'lisbo%' AND pob_ciudad_2025 IS NULL;
UPDATE estadios SET pob_ciudad_2025 = 981263,  fuente_poblacion = 'https://bdeex.com/es/naselenie/sweden/stockholm/' WHERE ciudad ILIKE 'estocol%' AND pob_ciudad_2025 IS NULL;
UPDATE estadios SET pob_ciudad_2025 = 364062,  fuente_poblacion = 'https://worldpopulationreview.com/cities/costa-rica/san-jose' WHERE ciudad ILIKE 'san jos%' AND pob_ciudad_2025 IS NULL;
UPDATE estadios SET pob_ciudad_2025 = 180884,  fuente_poblacion = 'https://www.aznations.com/population/nl/cities/arnhem' WHERE ciudad ILIKE 'arnh%' AND pob_ciudad_2025 IS NULL;
UPDATE estadios SET pob_ciudad_2025 = 895713,  fuente_poblacion = 'https://worldpopulationreview.com/cities/france/marseille' WHERE ciudad ILIKE 'marsell%' AND pob_ciudad_2025 IS NULL;


-- 2.2.4. Classification of cities by size
ALTER TABLE estadios 
ADD COLUMN tamano VARCHAR(50);

UPDATE estadios
SET tamano = CASE 
    WHEN pob_ciudad_2025 < 500000 THEN 'pequeña'
    WHEN pob_ciudad_2025 >= 500000 AND pob_ciudad_2025 < 1000000 THEN 'intermedia'
    WHEN pob_ciudad_2025 >= 1000000 AND pob_ciudad_2025 < 5000000 THEN 'grande'
    WHEN pob_ciudad_2025 >= 5000000 AND pob_ciudad_2025 < 10000000 THEN 'muy grande'
    WHEN pob_ciudad_2025 >= 10000000 THEN 'megaciudad'
    ELSE 'desconocido'
END;

-- 2.2.5. Chronological ID assignment for stadiums (1 to 23)
-- Determine the sequential visit order based on the last concert in each city.
ALTER TABLE estadios
ADD COLUMN id_estadio integer;

WITH ultimos_conciertos AS (
    SELECT DISTINCT ON (ciudad, pais)
           ciudad,
           pais,
           id_concierto
    FROM conciertos
    ORDER BY ciudad, pais, id_concierto DESC
),
orden_ciudades AS (
    SELECT
        ciudad,
        pais,
        ROW_NUMBER() OVER (ORDER BY id_concierto) AS id_estadio
    FROM ultimos_conciertos
)
UPDATE estadios e
SET id_estadio = o.id_estadio
FROM orden_ciudades o
WHERE e.ciudad = o.ciudad
  AND e.pais = o.pais;


-- 2.2.6. Estimated total attendance calculation (Absolute terms)
-- Assume full capacity (sold-out) by multiplying capacity by total number of shows.
ALTER TABLE estadios
ADD COLUMN asist_total numeric;

UPDATE estadios
SET asist_total = total_shows * capacidad;


-- 2.2.7. Relative global attendance share calculation
-- Calculate each city's attendance as a percentage of the tour's global total.
ALTER TABLE estadios
ADD COLUMN porcentaje_asist_global numeric;

UPDATE estadios
SET porcentaje_asist_global = ROUND((asist_total / sub.total) * 100, 2)
FROM (
    SELECT SUM(asist_total) AS total
    FROM estadios
) sub;


-- 2.2.8. Cálculo de penetración per cápita (Cada 100 habitantes)
-- Proporción de asistentes estimados respecto a la población metropolitana local.
ALTER TABLE estadios
ADD COLUMN porcentaje_entradas_percapita numeric;

UPDATE estadios
SET porcentaje_entradas_percapita = ROUND((asist_total::numeric / pob_ciudad_2025::numeric) * 100, 2);

-- 2.2.9. Clasificación de las venta de entradas per cápita en categorías.
ALTER TABLE estadios 
ADD COLUMN clasif_percapita VARCHAR(50);

UPDATE estadios
SET clasif_percapita = CASE 
    WHEN porcentaje_entradas_percapita <= 5 THEN 'baja'
    WHEN porcentaje_entradas_percapita > 5 AND porcentaje_entradas_percapita <= 10 THEN 'media'
    WHEN porcentaje_entradas_percapita > 10 AND porcentaje_entradas_percapita <= 15 THEN 'alta'
    WHEN porcentaje_entradas_percapita > 15 THEN 'muy alta'
    ELSE 'desconocido'
END;

-- 2.2.10. Clasificación por idioma principal de la ciudad
-- Etiquetado condicional (CASE WHEN) para diferenciar mercados hispanohablantes de los demás.
ALTER TABLE estadios
ADD COLUMN IF NOT EXISTS espanol_ppal text;

UPDATE estadios
SET espanol_ppal = CASE
    WHEN pais IN ('Argentina', 'España', 'Puerto Rico', 'Perú', 'Chile', 'México', 'Costa Rica', 'Colombia', 'República Dominicana')
        THEN 'hispana'
    ELSE 'no hispana'
END;