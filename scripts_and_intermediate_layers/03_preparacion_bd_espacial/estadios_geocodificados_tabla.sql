-- 0. Asegurar que PostGIS esté habilitado en la base de datos destino
CREATE EXTENSION IF NOT EXISTS postgis;

-- 1. Crear la tabla si no existe
CREATE TABLE IF NOT EXISTS public.estadios_geocodificados (
    id SERIAL PRIMARY KEY,
    geom public.geometry(Point,4326),
    estadio character varying,
    ciudad character varying,
    pais character varying,
    y double precision,
    x double precision
);

-- Asignar propietario (opcional)
ALTER TABLE public.estadios_geocodificados OWNER TO postgres;

-- 2. Insertar los datos (construyendo el punto 4326 con ST_SetSRID(ST_MakePoint(x, y), 4326))
INSERT INTO public.estadios_geocodificados (
    id, geom, estadio, ciudad, pais, y, x
) VALUES
(1, ST_SetSRID(ST_MakePoint(-46.6333824, -23.5506507), 4326), 'Allianz Parque', 'San Pablo', 'Brasil', -23.5506507, -46.6333824),
(2, ST_SetSRID(ST_MakePoint(5.3777888, 43.2963986), 4326), 'Orange Vélodrome', 'Marsella', 'Francia', 43.2963986, 5.3777888),
(3, ST_SetSRID(ST_MakePoint(139.7638947, 35.6768601), 4326), 'Tipstar Dome Chiba', 'Tokio', 'Japón', 35.6768601, 139.7638947),
(4, ST_SetSRID(ST_MakePoint(-99.1514677, 19.3207722), 4326), 'Estadio GNP Seguros', 'Ciudad de México', 'México', 19.3207722, -99.1514677),
(5, ST_SetSRID(ST_MakePoint(-58.3887904, -34.6095579), 4326), 'Estadio River Plate', 'Buenos Aires', 'Argentina', -34.6095579, -58.3887904),
(6, ST_SetSRID(ST_MakePoint(-77.0305912, -12.0459808), 4326), 'Estadio Nacional del Perú', 'Lima', 'Perú', -12.0459808, -77.0305912),
(7, ST_SetSRID(ST_MakePoint(-0.1277653, 51.5074456), 4326), 'Tottenham Hotspur Stadium', 'Londres', 'Reino Unido', 51.5074456, -0.1277653),
(8, ST_SetSRID(ST_MakePoint(2.3483915, 48.8534951), 4326), 'Plenitude Arena', 'París', 'Francia', 48.8534951, 2.3483915),
(9, ST_SetSRID(ST_MakePoint(50.7980749, 9.8694792), 4326), 'Estadio Nacional Julio Martínez Prádanos', 'Santiago', 'Chile', 9.8694792, 50.7980749),
(10, ST_SetSRID(ST_MakePoint(21.0711489, 52.2333742), 4326), 'PGE Narodowy', 'Varsovia', 'Polonia', 52.2333742, 21.0711489),
(11, ST_SetSRID(ST_MakePoint(-66.05344, 18.384239), 4326), 'Estadio Hiram Bithorn', 'San Juan', 'Puerto Rico', 18.384239, -66.05344),
(12, ST_SetSRID(ST_MakePoint(6.7763137, 51.2254018), 4326), 'Merkur Spiel-Arena', 'Düsseldorf', 'Alemania', 51.2254018, 6.7763137),
(13, ST_SetSRID(ST_MakePoint(-9.1365919, 38.7077507), 4326), 'Estadio da Luz', 'Lisboa', 'Portugal', 38.7077507, -9.1365919),
(14, ST_SetSRID(ST_MakePoint(-69.8918436, 18.4713858), 4326), 'Estadio Olímpico Félix Sánchez', 'Santo Domingo', 'República Dominicana', 18.4713858, -69.8918436),
(15, ST_SetSRID(ST_MakePoint(18.0710935, 59.3251172), 4326), 'Strawberry Arena', 'Estocolmo', 'Suecia', 59.3251172, 18.0710935),
(16, ST_SetSRID(ST_MakePoint(4.352493, 50.8467372), 4326), 'King Baudouin Stadium', 'Bruselas', 'Bélgica', 50.8467372, 4.352493),
(17, ST_SetSRID(ST_MakePoint(151.2082848, -33.8698439), 4326), 'ENGIE Stadium', 'Sídney', 'Australia', -33.8698439, 151.2082848),
(18, ST_SetSRID(ST_MakePoint(2.177073, 41.3825802), 4326), 'Estadi Olímpic Lluís Companys', 'Barcelona', 'España', 41.3825802, 2.177073),
(19, ST_SetSRID(ST_MakePoint(-75.6025597, 6.2697324), 4326), 'Estadio Atanasio Girardot', 'Medellín', 'Colombia', 6.2697324, -75.6025597),
(20, ST_SetSRID(ST_MakePoint(-3.703507, 40.416782), 4326), 'Riyadh Air Metropolitano', 'Madrid', 'España', 40.416782, -3.703507),
(21, ST_SetSRID(ST_MakePoint(-84.0796683, 9.9327373), 4326), 'Estadio Nacional de Costa Rica', 'San José', 'Costa Rica', 9.9327373, -84.0796683),
(22, ST_SetSRID(ST_MakePoint(5.9108573, 51.984257), 4326), 'GelreDome', 'Arnhem', 'Países Bajos', 51.984257, 5.9108573),
(23, ST_SetSRID(ST_MakePoint(9.1896346, 45.4641943), 4326), 'Ippodromo Snai La Maura', 'Milán', 'Italia', 45.4641943, 9.1896346);

-- 3. Sincronizar la secuencia del ID para futuros inserts
SELECT setval(
    pg_get_serial_sequence('public.estadios_geocodificados', 'id'),
    COALESCE((SELECT MAX(id) FROM public.estadios_geocodificados), 1),
    true
);

-- 4. Índice espacial recomendado (opcional)
CREATE INDEX IF NOT EXISTS idx_estadios_geocodificados_geom
    ON public.estadios_geocodificados USING GIST (geom);