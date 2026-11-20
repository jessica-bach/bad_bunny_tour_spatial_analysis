--------------------------------------------------------------------------------
-- PROJECT: Spatial and Logistics Analysis of the "Debí tirar más fotos Tour" (Bad Bunny)
-- DATABASE MANAGEMENT SYSTEM: PostgreSQL / PostGIS
-- DESCRIPTION: Comprehensive script for processing, enriching, and spatial analysis
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- SECTION 3: SPATIAL TRANSFORMATION AND GEOCODING (POSTGIS)
--------------------------------------------------------------------------------

-- 3.1. Enable the PostGIS spatial extension in the database
CREATE EXTENSION IF NOT EXISTS postgis;


-- 3.3.1. Add geographic coordinates and geometries
-- Add columns to store latitude, longitude, and Point spatial objects (SRID 4326).
ALTER TABLE stadiums ADD COLUMN lat numeric;
ALTER TABLE stadiums ADD COLUMN lon numeric;
ALTER TABLE stadiums ADD COLUMN geom geometry(Point, 4326);

-- Spatial update by joining with the layer geocoded in QGIS ('geocoded_stadiums').
UPDATE stadiums AS s
SET lat  = g.y,
    lon  = g.x,
    geom = g.geom
FROM geocoded_stadiums AS g
WHERE s.city    = g.city
  AND s.country = g.country;


-- 3.4. Spatial quality control and topological corrections
-- Cross-validation query: uses ST_Intersects to check whether point geometries
-- fall within the polygon boundaries of the country assigned in attributes.
SELECT
    s.stadium,
    s.city,
    s.country AS stadium_country,
    w.country AS polygon_country
FROM stadiums AS s
LEFT JOIN world_countries AS w
    ON ST_Intersects(s.geom, w.geom)
WHERE s.country != w.country
   OR w.country IS NULL;

-- Manual geometry correction for Santiago, Chile following the spatial audit.
-- Also syncs lon and lat to match the corrected coordinates.
UPDATE stadiums
SET lon  = -70.669,
    lat  = -33.448,
    geom = ST_SetSRID(
        ST_MakePoint(-70.669, -33.448),
        4326
    )
WHERE city    = 'Santiago'
  AND country = 'Chile';