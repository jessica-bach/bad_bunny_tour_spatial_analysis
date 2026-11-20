--------------------------------------------------------------------------------
-- PROJECT: Spatial and Logistics Analysis of the "Debí tirar más fotos Tour" (Bad Bunny)
-- DATABASE MANAGEMENT SYSTEM: PostgreSQL / PostGIS
-- DESCRIPTION: Comprehensive script for processing, enriching, and spatial analysis
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- SECTION 4: TRAJECTORY CONSTRUCTION AND NETWORK ANALYSIS ("TOUR_LINES")
--------------------------------------------------------------------------------

-- 4.1. Create the sequential flight lines layer
-- Uses the LEAD() window function to connect the current stadium to the next
-- chronological one, building vector line segments with ST_MakeLine().
DROP TABLE IF EXISTS tour_lines;

CREATE TABLE tour_lines AS
SELECT
    stadium_id AS from_id,
    LEAD(stadium_id) OVER (ORDER BY stadium_id) AS to_id,
    city AS from_city,
    LEAD(city) OVER (ORDER BY stadium_id) AS to_city,
    country AS from_country,
    LEAD(country) OVER (ORDER BY stadium_id) AS to_country,
    ST_MakeLine(
        geom,
        LEAD(geom) OVER (ORDER BY stadium_id)
    ) AS geom
FROM stadiums;

-- Remove the NULL record for the final leg (San Juan has no subsequent destination).
DELETE FROM tour_lines
WHERE geom IS NULL;

-- Drop temporary helper identifier columns.
ALTER TABLE tour_lines
DROP COLUMN from_id,
DROP COLUMN to_id;


-- 4.2. Enrich trajectories (Distances and Flight Logistics)

-- 4.2.1. Calculate geodesic (great-circle) distances in kilometers
ALTER TABLE tour_lines
ADD COLUMN distance_km numeric;

UPDATE tour_lines
SET distance_km = ROUND(
    ST_Distance(
        ST_StartPoint(geom)::geography,
        ST_EndPoint(geom)::geography
    ) / 1000
);


-- 4.2.2. Estimate continuous flight time in hours
-- Based on the average cruise speed of a Bombardier Global 7500 private jet (904 km/h).
ALTER TABLE tour_lines
ADD COLUMN flight_hours numeric;

UPDATE tour_lines
SET flight_hours = ROUND(distance_km / 904.0, 2);


-- 4.2.3. Format readable flight duration (Hours and Minutes)
ALTER TABLE tour_lines
ADD COLUMN flight_time text;

UPDATE tour_lines
SET flight_time =
    FLOOR(flight_hours)::text || 'h ' ||
    ROUND((flight_hours - FLOOR(flight_hours)) * 60)::text || '''';


-- 4.2.4. Estimate gross CO2 emissions (Tonnes)
-- Applying an emission factor of 3.8 tonnes of CO2 per flight hour for business jets.
ALTER TABLE tour_lines
ADD COLUMN co2_tonnes numeric;

UPDATE tour_lines
SET co2_tonnes = ROUND(flight_hours * 3.8, 2);


-- 4.2.5. Normalize carbon footprint per attendee at destination
-- Join total attendees from the destination stadium and calculate kg CO2 per spectator.
ALTER TABLE tour_lines
ADD COLUMN destination_attendees integer;

UPDATE tour_lines tl
SET destination_attendees = s.total_attendance
FROM stadiums s
WHERE tl.to_city    = s.city
  AND tl.to_country = s.country;

ALTER TABLE tour_lines
ADD COLUMN kg_co2_per_attendee numeric;

UPDATE tour_lines
SET kg_co2_per_attendee = ROUND(
    (co2_tonnes * 1000.0) / destination_attendees,
    3
)
WHERE destination_attendees > 0;