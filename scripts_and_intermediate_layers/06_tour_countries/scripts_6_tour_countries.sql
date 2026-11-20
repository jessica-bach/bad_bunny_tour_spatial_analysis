--------------------------------------------------------------------------------
-- PROJECT: Spatial and Logistical Analysis of the "Debí tirar más fotos Tour" (Bad Bunny)
-- DATABASE MANAGEMENT SYSTEM: PostgreSQL / PostGIS
-- DESCRIPTION: End-to-end processing, enrichment, and spatial analysis script
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- SECTION 6: MARKET SEGMENTATION ("PAISES_TOUR")
--------------------------------------------------------------------------------

-- 6.1. Creation of derived spatial subsets
DROP TABLE IF EXISTS paises_tour;
CREATE TABLE paises_tour AS
SELECT *
FROM paises_mundo
WHERE tour = 'sí';

-- 6.2. Layer enrichment

-- 6.2.1. Aggregated sum of tickets sold at the national level (Absolute values)
ALTER TABLE paises_tour
ADD COLUMN asist_total_pais numeric;

UPDATE paises_tour pm
SET asist_total_pais = s.total
FROM (
    SELECT pais, SUM(asist_total) AS total
    FROM estadios
    GROUP BY pais
) s
WHERE pm.pais = s.pais;


-- 6.2.2. Aggregation of national market share percentage (Relative values)
ALTER TABLE paises_tour
ADD COLUMN IF NOT EXISTS porcentaje_asist_pais numeric;

UPDATE paises_tour pt
SET porcentaje_asist_pais = sub.total_porcentaje
FROM (
    SELECT pais, SUM(porcentaje_asist_