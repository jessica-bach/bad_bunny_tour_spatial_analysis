--------------------------------------------------------------------------------
-- PROJECT: Spatial and Logistics Analysis of the "Debí tirar más fotos Tour" (Bad Bunny)
-- DATABASE MANAGEMENT SYSTEM: PostgreSQL / PostGIS
-- DESCRIPTION: Comprehensive script for processing, enriching, and spatial analysis
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- SECTION 6: MARKET SEGMENTATION ("TOUR_COUNTRIES")
--------------------------------------------------------------------------------

-- 6.1. Create derived spatial subsets
DROP TABLE IF EXISTS tour_countries;
CREATE TABLE tour_countries AS
SELECT *
FROM world_countries
WHERE tour = 'yes';

-- 6.2. Enrich the layer

-- 6.2.1. Aggregate sum of tickets sold at the national scale (Absolute terms)
ALTER TABLE tour_countries
ADD COLUMN IF NOT EXISTS country_total_attendance numeric;

UPDATE tour_countries tc
SET country_total_attendance = s.total
FROM (
    SELECT country, SUM(total_attendance) AS total
    FROM stadiums
    GROUP BY country
) s
WHERE tc.country = s.country;


-- 6.2.2. Aggregation of market share percentage by country (Relative terms)
ALTER TABLE tour_countries
ADD COLUMN IF NOT EXISTS country_attendance_pct numeric;

UPDATE tour_countries tc
SET country_attendance_pct = sub.total_pct
FROM (
    SELECT country, SUM(global_attendance_pct) AS total_pct
    FROM stadiums
    GROUP BY country
) sub
WHERE tc.country = sub.country;

-- 6.2.3. Segmentation of countries by region
ALTER TABLE tour_countries
ADD COLUMN IF NOT EXISTS region VARCHAR(50);

UPDATE tour_countries
SET region = CASE
    WHEN country IN (
        'Mexico', 'Puerto Rico', 'Dominican Republic', 'Chile',
        'Costa Rica', 'Colombia', 'Peru', 'Argentina', 'Brazil'
    ) THEN 'Americas'
    WHEN country IN (
        'Netherlands', 'Belgium', 'United Kingdom', 'Portugal',
        'Spain', 'France', 'Italy', 'Germany', 'Poland', 'Sweden'
    ) THEN 'Europe'
    WHEN country = 'Japan' THEN 'Asia'
    WHEN country = 'Australia' THEN 'Oceania'
    ELSE 'Other' -- Fallback for any unmapped country
END;