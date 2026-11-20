--------------------------------------------------------------------------------
-- PROJECT: Spatial and Logistical Analysis of the "Debí tirar más fotos Tour" (Bad Bunny)
-- DATABASE MANAGEMENT SYSTEM: PostgreSQL / PostGIS
-- DESCRIPTION: End-to-end processing, enrichment, and spatial analysis script
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- SECTION 7: GLOBAL TOUR METRICS QUERIES
--------------------------------------------------------------------------------

-- 7.2. Slide 11. Calculation of the total tour duration (in days)
-- Returns the exact difference between the first and last scheduled concert.
SELECT 
    (MAX(fecha) - MIN(fecha)) AS duracion_dias
FROM conciertos;

-- 7.2. Slide 13. Calculation of ticket sales volume by region
SELECT
region,
SUM(asist_total_pais) 
FROM paises_tour
GROUP BY(region) 
ORDER BY SUM(asist_total_pais) DESC;

-- 7.2. Slide 23. Calculation of average and median CO2 emissions per attendee
