--------------------------------------------------------------------------------
-- PROYECTO: Análisis Espacial y Logístico del "Debí tirar más fotos Tour" (Bad Bunny)
-- GESTOR DE BASE DE DATOS: PostgreSQL / PostGIS
-- DESCRIPCIÓN: Script integral de procesamiento, enriquecimiento y análisis espacial
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- SECCIÓN 3: TRANSFORMACIÓN ESPACIAL Y GEOCODIFICACIÓN (POSTGIS)
--------------------------------------------------------------------------------

-- 3.1. Activación de la extensión espacial PostGIS en la base de datos
CREATE EXTENSION postgis;


-- 3.3.1. Incorporación de geometrías y coordenadas geográficas
-- Se añaden columnas para almacenar latitud, longitud y objetos espaciales tipo Point (SRID 4326).
ALTER TABLE estadios ADD COLUMN lat numeric;
ALTER TABLE estadios ADD COLUMN lon numeric;
ALTER TABLE estadios ADD COLUMN geom geometry(Point, 4326);

-- Actualización espacial cruzando con la capa geocodificada en QGIS ('estadios_geocodificados').
UPDATE estadios AS e
SET lat = g.y,
    lon = g.x,
    geom = g.geom
FROM estadios_geocodificados AS g
WHERE e.ciudad = g.ciudad
  AND e.pais = g.pais;


-- 3.4. Control de calidad espacial y correcciones topológicas
 

-- Corrección manual de la geometría para Santiago de Chile tras la auditoría.
UPDATE estadios
SET geom = ST_SetSRID(
    ST_MakePoint(-70.669, -33.448),
    4326
)
WHERE ciudad = 'Santiago'
  AND pais = 'Chile';
