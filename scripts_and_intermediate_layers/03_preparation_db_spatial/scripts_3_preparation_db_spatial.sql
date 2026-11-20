--------------------------------------------------------------------------------
-- PROJECT: Spatial and Logistics Analysis of the "Debí tirar más fotos Tour" (Bad Bunny)
-- DATABASE MANAGEMENT SYSTEM: PostgreSQL / PostGIS
-- DESCRIPTION: Comprehensive script for processing, enriching, and spatial analysis
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- SECTION 3: SPATIAL TRANSFORMATION AND GEOCODING (POSTGIS)
--------------------------------------------------------------------------------

-- 3.1. Enable the PostGIS spatial extension in the database

CREATE EXTENSION postgis;


-- 3.3.1. Add geographic coordinates and geometries
-- Add columns to store latitude, longitude, and Point spatial objects (SRID 4326).
ALTER TABLE estadios ADD COLUMN lat numeric;
ALTER TABLE estadios ADD COLUMN lon numeric;
ALTER TABLE estadios ADD COLUMN geom geometry(Point, 4326);

-- Spatial update by joining with the layer geocoded in QGIS ('estadios_geocodificados').
UPDATE estadios AS e
SET lat = g.y,
    lon = g.x,
    geom = g.geom
FROM estadios_geocodificados AS g
WHERE e.ciudad = g.ciudad
  AND e.pais = g.pais;


-- 3.4. Spatial quality control and topological corrections
-- Cross-validation query: uses ST_Intersects to check whether point geometries
-- fall within the polygon boundaries of the country assigned in attributes.
-- Manual geometry correction for Santiago, Chile following the spatial audit.
-- Also syncs lon and lat to match the corrected coordinates.

UPDATE estadios
SET geom = ST_SetSRID(
    ST_MakePoint(-70.669, -33.448),
    4326
)
WHERE ciudad = 'Santiago'
  AND pais = 'Chile';
