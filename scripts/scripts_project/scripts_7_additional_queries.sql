--------------------------------------------------------------------------------
-- PROJECT: Spatial and Logistics Analysis of the "Debí tirar más fotos Tour" (Bad Bunny)
-- DATABASE MANAGEMENT SYSTEM: PostgreSQL / PostGIS
-- DESCRIPTION: Comprehensive script for processing, enriching, and spatial analysis
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- SECTION 7: GLOBAL TOUR METRICS QUERIES
--------------------------------------------------------------------------------

-- 7.2. Slide 11. Calculate total temporal duration of the tour (in days)
-- Gets the exact difference between the first and last scheduled concert.
SELECT
    (MAX(concert_date) - MIN(concert_date)) AS duration_days
FROM concerts;

-- 7.2. Slide 13. Calculate total tickets sold by region
SELECT
    region,
    SUM(country_total_attendance) AS total_tickets_sold
FROM tour_countries
GROUP BY region
ORDER BY SUM(country_total_attendance) DESC;

-- 7.2. Slide 23. Calculate mean and median CO2 per attendee
SELECT
    AVG(kg_co2_per_attendee) AS mean_kg_co2_per_attendee,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY kg_co2_per_attendee) AS median_kg_co2_per_attendee
FROM tour_lines;