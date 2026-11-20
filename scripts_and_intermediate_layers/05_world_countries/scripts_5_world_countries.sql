--------------------------------------------------------------------------------
-- PROJECT: Spatial and Logistical Analysis of the "Debí tirar más fotos Tour" (Bad Bunny)
-- DATABASE MANAGEMENT SYSTEM: PostgreSQL / PostGIS
-- DESCRIPTION: End-to-end processing, enrichment, and spatial analysis script
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- SECTION 5: PROCESSING OF GLOBAL BASE LAYERS ("PAISES_MUNDO")
--------------------------------------------------------------------------------

-- Standardization of the global countries vector layer
ALTER TABLE paises_mundo
RENAME COLUMN "PAÍS" TO pais;

-- Exclusion of Antarctica to optimize the global cartographic extent.
DELETE FROM paises_mundo 
WHERE pais = 'Antártida'; 

-- Creation of a tour participation indicator field ('yes' / 'no').
ALTER TABLE paises_mundo
ADD COLUMN tour text;
