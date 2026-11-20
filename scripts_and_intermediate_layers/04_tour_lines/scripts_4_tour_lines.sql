--------------------------------------------------------------------------------
-- PROJECT: Spatial and Logistical Analysis of the "Debí tirar más fotos Tour" (Bad Bunny)
-- DATABASE MANAGEMENT SYSTEM: PostgreSQL / PostGIS
-- DESCRIPTION: End-to-end processing, enrichment, and spatial analysis script
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- SECTION 4: ROUTE CONSTRUCTION AND NETWORK ANALYSIS ("TOUR_LINEAS")
--------------------------------------------------------------------------------

-- 4.1. Creation of sequential flight route layer
-- Uses the LEAD() window function to connect each venue with the next one in chronological order,
-- building vector arcs using ST_MakeLine().
DROP TABLE IF EXISTS tour_lineas;

CREATE TABLE tour_lineas AS
SELECT 
    id_estadio AS desde_id,
    LEAD(id_estadio) OVER (ORDER BY id_estadio) AS hasta_id,
    ciudad AS desde_ciudad,
    LEAD(ciudad) OVER (ORDER BY id_estadio) AS hasta_ciudad,
    pais AS desde_pais,
    LEAD(pais) OVER (ORDER BY id_estadio) AS hasta_pais,
    ST_MakeLine(
        geom,
        LEAD(geom) OVER (ORDER BY id_estadio)
    ) AS geom
FROM estadios;

-- Removal of the null record corresponding to the final segment
-- (San Juan has no subsequent destination).
DELETE FROM tour_lineas
WHERE geom IS NULL;

-- Cleanup of temporary auxiliary identifiers.
ALTER TABLE tour_lineas
DROP COLUMN desde_id,
DROP COLUMN hasta_id;


-- 4.2. Route Enrichment (Distances and Flight Logistics)

-- 4.2.1. Calculation of geodesic (great-circle) distances in kilometers
ALTER TABLE tour_lineas
ADD COLUMN distancia_km numeric;

UPDATE tour_lineas
SET distancia_km = ROUND(
    ST_Distance(
        ST_StartPoint(geom)::geography,
        ST_EndPoint(geom)::geography
    ) / 1000
);


-- 4.2.2. Estimation of flight time in continuous hours
