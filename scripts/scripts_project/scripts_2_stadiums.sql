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
DROP TABLE IF EXISTS stadiums;

CREATE TABLE stadiums (
    stadium text,
    city    text,
    country text
);

INSERT INTO stadiums (stadium, city, country)
SELECT DISTINCT stadium, city, country
FROM concerts;


-- 2.2. Restructuring and addition of capacities and metadata
-- Replace the previous table with a more robust schema that includes each venue's
-- theoretical maximum capacity and its reference sources.
DROP TABLE stadiums;

CREATE TABLE stadiums (
    stadium         text,
    city            text,
    country         text,
    stadium_source  text,
    capacity        integer,
    capacity_source text
);

-- Manual insertion of verified capacities for live music events.
INSERT INTO stadiums (stadium, city, country, stadium_source, capacity, capacity_source) VALUES
('King Baudouin Stadium','Brussels','Belgium','https://depuertoricopalmundo.com/',50093,'https://en.wikipedia.org/wiki/King_Baudouin_Stadium'),
('Tipstar Dome Chiba','Tokyo','Japan','https://es.wikipedia.org/wiki/Deb%C3%AD_Tirar_M%C3%A1s_Fotos_World_Tour',3600,'https://grokipedia.com/page/chiba_velodrome'),
('PGE Narodowy','Warsaw','Poland','https://depuertoricopalmundo.com/',58580,'https://es.wikipedia.org/wiki/Estadio_Nacional_de_Varsovia'),
('Lluís Companys Olympic Stadium','Barcelona','Spain','https://depuertoricopalmundo.com/',55926,'https://en.wikipedia.org/wiki/Estadi_Ol%C3%ADmpic_Llu%C3%ADs_Companys'),
('Julio Martínez Prádanos National Stadium','Santiago','Chile','https://depuertoricopalmundo.com/',46190,'https://es.wikipedia.org/wiki/Estadio_Nacional_Julio_Mart%C3%ADnez_Pr%C3%A1danos'),
('Riyadh Air Metropolitano','Madrid','Spain','https://depuertoricopalmundo.com/',70813,'https://de.wikipedia.org/wiki/Estadio_Metropolitano_(Madrid)'),
('Hiram Bithorn Stadium','San Juan','Puerto Rico','https://depuertoricopalmundo.com/',35000,'https://es.wikipedia.org/wiki/Estadio_Hiram_Bithorn'),
('Merkur Spiel-Arena','Düsseldorf','Germany','https://depuertoricopalmundo.com/',60000,'https://es.wikipedia.org/wiki/Merkur_Spiel-Arena'),
('Estádio da Luz','Lisbon','Portugal','https://depuertoricopalmundo.com/',68100,'https://es.wikipedia.org/wiki/Est%C3%A1dio_da_Luz'),
('River Plate Stadium','Buenos Aires','Argentina','https://depuertoricopalmundo.com/',85018,'https://es.wikipedia.org/wiki/Estadio_Monumental_(River_Plate)'),
('Strawberry Arena','Stockholm','Sweden','https://depuertoricopalmundo.com/',67000,'https://es.wikipedia.org/wiki/Nacional_Arena'),
('Tottenham Hotspur Stadium','London','United Kingdom','https://depuertoricopalmundo.com/',62850,'https://es.wikipedia.org/wiki/Tottenham_Hotspur_Stadium'),
('Atanasio Girardot Stadium','Medellín','Colombia','https://depuertoricopalmundo.com/',44826,'https://es.wikipedia.org/wiki/Estadio_Atanasio_Girardot'),
('Estadio GNP Seguros','Mexico City','Mexico','https://depuertoricopalmundo.com/',65000,'https://es.wikipedia.org/wiki/Estadio_GNP_Seguros'),
('National Stadium of Costa Rica','San José','Costa Rica','https://depuertoricopalmundo.com/',25000,'https://es.wikipedia.org/wiki/Estadio_Nacional_de_Costa_Rica_(1924)'),
('Félix Sánchez Olympic Stadium','Santo Domingo','Dominican Republic','https://depuertoricopalmundo.com/',50000,'https://es.wikipedia.org/wiki/Estadio_Ol%C3%ADmpico_F%C3%A9lix_S%C3%A1nchez'),
('Plenitude Arena','Paris','France','https://depuertoricopalmundo.com/',45000,'https://es.wikipedia.org/wiki/Plenitude_Arena'),
('National Stadium of Peru','Lima','Peru','https://depuertoricopalmundo.com/',50000,'https://es.wikipedia.org/wiki/Estadio_Nacional_del_Per%C3%BA'),
('GelreDome','Arnhem','Netherlands','https://depuertoricopalmundo.com/',20000,'https://es.wikipedia.org/wiki/Gelredome'),
('ENGIE Stadium','Sydney','Australia','https://depuertoricopalmundo.com/',23500,'https://en.wikipedia.org/wiki/Sydney_Showground_Stadium'),
('Allianz Parque','São Paulo','Brazil','https://depuertoricopalmundo.com/',55000,'https://en.wikipedia.org/wiki/Nubank_Parque'),
('Ippodromo Snai La Maura','Milan','Italy','https://depuertoricopalmundo.com/',80000,'https://it.wikipedia.org/wiki/Ippodromo_La_Maura'),
('Orange Vélodrome','Marseille','France','https://depuertoricopalmundo.com/',67394,'https://en.wikipedia.org/wiki/Stade_V%C3%A9lodrome');


-- 2.2.2. Calculation of show frequency per stadium
-- Add the total_shows column and calculate it by grouping records from the concerts table.
ALTER TABLE stadiums
ADD COLUMN total_shows integer;

UPDATE stadiums s
SET total_shows = sub.show_count
FROM (
    SELECT city, COUNT(*) AS show_count
    FROM concerts
    GROUP BY city
) sub
WHERE s.city = sub.city;


-- 2.2.3. Integration of demographic data (2025 Population)
-- Create an auxiliary table with the global urban population report (Worldometer).
DROP TABLE IF EXISTS cities;

CREATE TABLE cities (
    city            text,
    country         text,
    population_2025 integer,
    source          text
);

-- (Note: Insertion of the global dataset of 200 cities provided in the original script...)
-- Insertion of data compiled from Worldometer
INSERT INTO cities (city, country, population_2025, source) VALUES
('Jakarta','Indonesia',41913860,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Dhaka','Bangladesh',36585479,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Tokyo','Japan',33412512,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('New Delhi','India',30222405,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Shanghai','China',29558908,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Guangzhou','China',27563372,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Cairo','Egypt',25566102,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Manila','Philippines',24735305,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kolkata','India',22549738,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Seoul','South Korea',22490482,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Karachi','Pakistan',21422590,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Mumbai','India',20203056,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('São Paulo','Brazil',18949790,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Bangkok','Thailand',18180280,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Mexico City','Mexico',17734212,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Beijing','China',17013303,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Lahore','Pakistan',15156430,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Istanbul','Turkey',15014763,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Moscow','Russia',14524753,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Ho Chi Minh City','Vietnam',14052713,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Buenos Aires','Argentina',14017736,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('New York','United States',13920148,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Shenzhen','China',13878396,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Bengaluru','India',13187098,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Osaka','Japan',12964145,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Lagos','Nigeria',12791699,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Los Angeles','United States',12740420,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Luanda','Angola',11370127,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Chennai','India',11153205,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kinshasa','DR Congo',10943641,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Bogotá','Colombia',10624315,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Lima','Peru',10580241,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('London','United Kingdom',10416420,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Hajipur','India',9941510,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Rio de Janeiro','Brazil',9500336,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Paris','France',9381921,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Hyderabad','India',9190795,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Tehran','Iran',9174964,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Taipei','Taiwan',9136792,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Bandung','Indonesia',8909104,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kuala Lumpur','Malaysia',8443731,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Dar es Salaam','Tanzania',7795114,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Suzhou','China',7731101,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Ahmedabad','India',7632408,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Hangzhou','China',7500208,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Wuhan','China',7363548,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Tianjin','China',7285342,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Alexandria','Egypt',7266957,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Nagoya','Japan',7146160,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Johannesburg','South Africa',7077175,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Chongqing','China',7071073,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Riyadh','Saudi Arabia',6916417,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Surat','India',6908925,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Surabaya','Indonesia',6843503,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Pune','India',6817951,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Khartoum','Sudan',6809355,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Nanjing','China',6800676,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Santiago','Chile',6726045,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Addis Ababa','Ethiopia',6705705,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Abidjan','Ivory Coast',6621711,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Chaozhou','China',6407770,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Amman','Jordan',6403666,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Baghdad','Iraq',6390735,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Chengdu','China',6139874,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Nairobi','Kenya',6134334,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kozhikode','India',6123872,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Shenyang','China',5702638,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kabul','Afghanistan',5635737,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Onitsha','Nigeria',5627706,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Yangon','Myanmar',5618303,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Accra','Ghana',5592780,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Madrid','Spain',5583601,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Faisalabad','Pakistan',5566382,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Toronto','Canada',5494431,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Mashhad','Iran',5398248,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Dubai','UAE',5283789,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Xi’an','China',5231053,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Colombo','Sri Lanka',5223838,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Yaoundé','Cameroon',5106087,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kochi','India',5077670,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Hanoi','Vietnam',5068414,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Lucknow','India',5052444,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Chattogram','Bangladesh',4983553,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Singapore','Singapore',4963998,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kampala','Uganda',4880943,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Zhengzhou','China',4878035,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Hefei','China',4867000,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Islamabad','Pakistan',4860084,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kano','Nigeria',4840280,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Hong Kong','China',4749543,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Saint Petersburg','Russia',4736499,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Santo Domingo','Dominican Republic',4600064,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Cape Town','South Africa',4508921,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Casablanca','Morocco',4457471,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Mogadishu','Somalia',4399430,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Harbin','China',4376259,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kanpur','India',4329973,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kumasi','Ghana',4297984,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Damascus','Syria',4287746,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Jeddah','Saudi Arabia',4284080,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kuwait City','Kuwait',4265132,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Medan','Indonesia',4245895,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Bamako','Mali',4244881,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Luxor','Egypt',4188023,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Belo Horizonte','Brazil',4162814,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Wenzhou','China',4158195,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Sydney','Australia',4150917,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Guadalajara','Mexico',4135440,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Douala','Cameroon',4104516,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Jaipur','India',4071754,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Sanaa','Yemen',4018856,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Taiyuan','China',4005816,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Puning','China',3989322,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Barcelona','Spain',3982704,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Houston','United States',3955046,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Monterrey','Mexico',3938015,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Tashkent','Uzbekistan',3935793,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Antananarivo','Madagascar',3916219,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Varanasi','India',3858863,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Dakar','Senegal',3852475,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Owerri','Nigeria',3833343,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Ürümqi','China',3755144,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Ibadan','Nigeria',3720721,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Recife','Brazil',3691196,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Chicago','United States',3683385,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Brazzaville','Republic of the Congo',3656322,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Melbourne','Australia',3639893,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Qingdao','China',3616657,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Ankara','Turkey',3612251,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kasaï-Oriental','DR Congo',3605738,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Karaj','Iran',3598661,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Berlin','Germany',3560908,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Savar','Bangladesh',3557381,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Peshawar','Pakistan',3554423,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
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
('Washington, D.C.','United States',3270018,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Busan','South Korea',3263221,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Nagpur','India',3257841,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Algiers','Algeria',3246400,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Fortaleza','Brazil',3244260,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kathmandu','Nepal',3231516,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kunming','China',3228117,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Ouagadougou','Burkina Faso',3206222,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Durban','South Africa',3177927,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Maputo','Mozambique',3166328,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('San Francisco','United States',3163486,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kalyan-Dombivli','India',3163424,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Guayaquil','Ecuador',3157825,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Salvador','Brazil',3135157,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Gujranwala','Pakistan',3121271,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Athens','Greece',3101979,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Ningbo','China',3094833,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kollam','India',3074562,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Cebu','Philippines',3044564,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Shijiazhuang','China',2990397,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Multan','Pakistan',2956642,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Thiruvananthapuram','India',2946119,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Asansol','India',2924741,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Aleppo','Syria',2922277,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Brahmanbaria','Bangladesh',2914727,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Miami','United States',2912486,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Fuzhou','China',2910985,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Pyongyang','North Korea',2901588,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Tamluk','India',2894484,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Hyderabad','Pakistan',2863633,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Guatemala City','Guatemala',2837708,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Lubumbashi','DR Congo',2832853,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Tasikmalaya','Indonesia',2827255,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Dalian','China',2796248,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Yogyakarta','Indonesia',2793747,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Agra','India',2786762,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Naples','Italy',2767923,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Coyah','Guinea',2727684,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Essen','Germany',2717087,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Cali','Colombia',2700232,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Guiyang','China',2686949,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Semarang','Indonesia',2679349,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Montreal','Canada',2668723,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('İzmir','Turkey',2650237,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Changzhou','China',2649836,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Tel Aviv','Israel',2642872,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Birmingham','United Kingdom',2631757,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Kyiv','Ukraine',2614581,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Wuxi','China',2613100,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Milan','Italy',2599022,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Caracas','Venezuela',2576666,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Manchester','United Kingdom',2535427,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Quito','Ecuador',2534914,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Cotonou','Benin',2506489,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Bhopal','India',2487205,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'),
('Curitiba','Brazil',2475352,'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/');


-- Automatic population linkage via JOIN
ALTER TABLE stadiums
ADD COLUMN city_pop_2025 integer;

UPDATE stadiums s
SET city_pop_2025 = c.population_2025
FROM cities c
WHERE s.city = c.city
  AND s.country = c.country;

-- Add population source metadata for matched records
ALTER TABLE stadiums
ADD COLUMN population_source text;

UPDATE stadiums
SET population_source = 'https://www.worldometers.info/es/poblacion/ciudades-mas-grandes-del-mundo/'
WHERE city_pop_2025 IS NOT NULL;

-- Audit NULL values (tour cities outside Worldometer's global top list)
SELECT *
FROM stadiums
WHERE city_pop_2025 IS NULL;

-- Manual, individual population updates for smaller tour cities
UPDATE stadiums SET city_pop_2025 = 1264392, population_source = 'https://worldpopulationreview.com/cities/belgium/brussels' WHERE city ILIKE 'brussel%' AND city_pop_2025 IS NULL;
UPDATE stadiums SET city_pop_2025 = 1866729, population_source = 'https://www.citypopulation.de/en/poland/warsaw/' WHERE city ILIKE 'wars%' AND city_pop_2025 IS NULL;
UPDATE stadiums SET city_pop_2025 = 291890,  population_source = 'https://worldpopulationreview.com/cities/puerto-rico/san-juan' WHERE city ILIKE 'san juan%' AND city_pop_2025 IS NULL;
UPDATE stadiums SET city_pop_2025 = 619444,  population_source = 'https://www.citypopulation.de/en/germany/nordrheinwestfalen/d%C3%BCsseldorf/05111000__d%C3%BCsseldorf/' WHERE city ILIKE 'd%sseldorf%' AND city_pop_2025 IS NULL;
UPDATE stadiums SET city_pop_2025 = 596426,  population_source = 'https://es.city-facts.com/lisbon/population' WHERE city ILIKE 'lisb%' AND city_pop_2025 IS NULL;
UPDATE stadiums SET city_pop_2025 = 981263,  population_source = 'https://bdeex.com/es/naselenie/sweden/stockholm/' WHERE city ILIKE 'stockh%' AND city_pop_2025 IS NULL;
UPDATE stadiums SET city_pop_2025 = 364062,  population_source = 'https://worldpopulationreview.com/cities/costa-rica/san-jose' WHERE city ILIKE 'san jos%' AND city_pop_2025 IS NULL;
UPDATE stadiums SET city_pop_2025 = 180884,  population_source = 'https://www.aznations.com/population/nl/cities/arnhem' WHERE city ILIKE 'arnh%' AND city_pop_2025 IS NULL;
UPDATE stadiums SET city_pop_2025 = 895713,  population_source = 'https://worldpopulationreview.com/cities/france/marseille' WHERE city ILIKE 'marseill%' AND city_pop_2025 IS NULL;


-- 2.2.4. Classification of cities by size
ALTER TABLE stadiums
ADD COLUMN city_size VARCHAR(50);

UPDATE stadiums
SET city_size = CASE
    WHEN city_pop_2025 < 500000 THEN 'small'
    WHEN city_pop_2025 >= 500000 AND city_pop_2025 < 1000000 THEN 'medium'
    WHEN city_pop_2025 >= 1000000 AND city_pop_2025 < 5000000 THEN 'large'
    WHEN city_pop_2025 >= 5000000 AND city_pop_2025 < 10000000 THEN 'very large'
    WHEN city_pop_2025 >= 10000000 THEN 'megacity'
    ELSE 'unknown'
END;

-- 2.2.5. Chronological ID assignment for stadiums (1 to 23)
-- Determine the sequential visit order based on the last concert in each city.
ALTER TABLE stadiums
ADD COLUMN stadium_id integer;

WITH last_concerts AS (
    SELECT DISTINCT ON (city, country)
           city,
           country,
           concert_id
    FROM concerts
    ORDER BY city, country, concert_id DESC
),
city_order AS (
    SELECT
        city,
        country,
        ROW_NUMBER() OVER (ORDER BY concert_id) AS seq_stadium_id
    FROM last_concerts
)
UPDATE stadiums s
SET stadium_id = co.seq_stadium_id
FROM city_order co
WHERE s.city = co.city
  AND s.country = co.country;


-- 2.2.6. Estimated total attendance calculation (Absolute terms)
-- Assume full capacity (sold-out) by multiplying capacity by total number of shows.
ALTER TABLE stadiums
ADD COLUMN total_attendance numeric;

UPDATE stadiums
SET total_attendance = total_shows * capacity;


-- 2.2.7. Relative global attendance share calculation
-- Calculate each city's attendance as a percentage of the tour's global total.
ALTER TABLE stadiums
ADD COLUMN global_attendance_pct numeric;

UPDATE stadiums
SET global_attendance_pct = ROUND((total_attendance / sub.total) * 100, 2)
FROM (
    SELECT SUM(total_attendance) AS total
    FROM stadiums
) sub;