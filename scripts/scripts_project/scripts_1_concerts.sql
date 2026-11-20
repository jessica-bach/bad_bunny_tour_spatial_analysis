--------------------------------------------------------------------------------
-- PROJECT: Spatial and Logistics Analysis of the "Debí tirar más fotos Tour" (Bad Bunny)
-- DATABASE MANAGEMENT SYSTEM: PostgreSQL / PostGIS
-- DESCRIPTION: Comprehensive script for processing, enriching, and spatial analysis
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- SECTION 1: CREATION AND STRUCTURING OF THE "CONCERTS" TABLE
--------------------------------------------------------------------------------

-- 1.1. Cleanup and creation of the base concerts table
-- Drop the table if it already exists to ensure idempotent execution.
-- Define a simple tabular structure storing the official dates,
-- locations, and source URL of the tour data.
DROP TABLE IF EXISTS concerts;

CREATE TABLE concerts (
    concert_date date,
    city         text,
    country      text,
    stadium      text,
    source       text
);

-- Insert the official live performance schedule for the tour.
INSERT INTO concerts (concert_date, city, country, stadium, source) VALUES
('2025-11-21','Santo Domingo','Dominican Republic','Félix Sánchez Olympic Stadium','https://depuertoricopalmundo.com/'),
('2025-11-22','Santo Domingo','Dominican Republic','Félix Sánchez Olympic Stadium','https://depuertoricopalmundo.com/'),
('2025-12-05','San José','Costa Rica','National Stadium of Costa Rica','https://depuertoricopalmundo.com/'),
('2025-12-06','San José','Costa Rica','National Stadium of Costa Rica','https://depuertoricopalmundo.com/'),
('2025-12-10','Mexico City','Mexico','Estadio GNP Seguros','https://depuertoricopalmundo.com/'),
('2025-12-11','Mexico City','Mexico','Estadio GNP Seguros','https://depuertoricopalmundo.com/'),
('2025-12-12','Mexico City','Mexico','Estadio GNP Seguros','https://depuertoricopalmundo.com/'),
('2025-12-15','Mexico City','Mexico','Estadio GNP Seguros','https://depuertoricopalmundo.com/'),
('2025-12-16','Mexico City','Mexico','Estadio GNP Seguros','https://depuertoricopalmundo.com/'),
('2025-12-19','Mexico City','Mexico','Estadio GNP Seguros','https://depuertoricopalmundo.com/'),
('2025-12-20','Mexico City','Mexico','Estadio GNP Seguros','https://depuertoricopalmundo.com/'),
('2025-12-21','Mexico City','Mexico','Estadio GNP Seguros','https://depuertoricopalmundo.com/'),
('2026-01-09','Santiago','Chile','Julio Martínez Prádanos National Stadium','https://depuertoricopalmundo.com/'),
('2026-01-10','Santiago','Chile','Julio Martínez Prádanos National Stadium','https://depuertoricopalmundo.com/'),
('2026-01-11','Santiago','Chile','Julio Martínez Prádanos National Stadium','https://depuertoricopalmundo.com/'),
('2026-01-16','Lima','Peru','National Stadium of Peru','https://depuertoricopalmundo.com/'),
('2026-01-17','Lima','Peru','National Stadium of Peru','https://depuertoricopalmundo.com/'),
('2026-01-23','Medellín','Colombia','Atanasio Girardot Stadium','https://depuertoricopalmundo.com/'),
('2026-01-24','Medellín','Colombia','Atanasio Girardot Stadium','https://depuertoricopalmundo.com/'),
('2026-01-25','Medellín','Colombia','Atanasio Girardot Stadium','https://depuertoricopalmundo.com/'),
('2026-02-13','Buenos Aires','Argentina','River Plate Stadium','https://depuertoricopalmundo.com/'),
('2026-02-14','Buenos Aires','Argentina','River Plate Stadium','https://depuertoricopalmundo.com/'),
('2026-02-15','Buenos Aires','Argentina','River Plate Stadium','https://depuertoricopalmundo.com/'),
('2026-02-20','São Paulo','Brazil','Allianz Parque','https://depuertoricopalmundo.com/'),
('2026-02-21','São Paulo','Brazil','Allianz Parque','https://depuertoricopalmundo.com/'),
('2026-02-28','Sydney','Australia','ENGIE Stadium','https://depuertoricopalmundo.com/'),
('2026-03-01','Sydney','Australia','ENGIE Stadium','https://depuertoricopalmundo.com/'),
('2026-03-07','Tokyo','Japan',NULL,'https://depuertoricopalmundo.com/'),
('2026-05-22','Barcelona','Spain','Lluís Companys Olympic Stadium','https://depuertoricopalmundo.com/'),
('2026-05-23','Barcelona','Spain','Lluís Companys Olympic Stadium','https://depuertoricopalmundo.com/'),
('2026-05-26','Lisbon','Portugal','Estádio da Luz','https://depuertoricopalmundo.com/'),
('2026-05-27','Lisbon','Portugal','Estádio da Luz','https://depuertoricopalmundo.com/'),
('2026-05-30','Madrid','Spain','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-05-31','Madrid','Spain','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-02','Madrid','Spain','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-03','Madrid','Spain','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-06','Madrid','Spain','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-07','Madrid','Spain','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-10','Madrid','Spain','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-11','Madrid','Spain','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-14','Madrid','Spain','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-15','Madrid','Spain','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-20','Düsseldorf','Germany','Merkur Spiel-Arena','https://depuertoricopalmundo.com/'),
('2026-06-21','Düsseldorf','Germany','Merkur Spiel-Arena','https://depuertoricopalmundo.com/'),
('2026-06-23','Arnhem','Netherlands','GelreDome','https://depuertoricopalmundo.com/'),
('2026-06-24','Arnhem','Netherlands','GelreDome','https://depuertoricopalmundo.com/'),
('2026-06-27','London','United Kingdom','Tottenham Hotspur Stadium','https://depuertoricopalmundo.com/'),
('2026-06-28','London','United Kingdom','Tottenham Hotspur Stadium','https://depuertoricopalmundo.com/'),
('2026-07-01','Marseille','France','Orange Vélodrome','https://depuertoricopalmundo.com/'),
('2026-07-04','Paris','France','La Défense Arena','https://depuertoricopalmundo.com/'),
('2026-07-05','Paris','France','La Défense Arena','https://depuertoricopalmundo.com/'),
('2026-07-10','Stockholm','Sweden','Strawberry Arena','https://depuertoricopalmundo.com/'),
('2026-07-11','Stockholm','Sweden','Strawberry Arena','https://depuertoricopalmundo.com/'),
('2026-07-14','Warsaw','Poland','PGE Narodowy','https://depuertoricopalmundo.com/'),
('2026-07-17','Milan','Italy','Ippodromo Snai La Maura','https://depuertoricopalmundo.com/'),
('2026-07-18','Milan','Italy','Ippodromo Snai La Maura','https://depuertoricopalmundo.com/'),
('2026-07-22','Brussels','Belgium','King Baudouin Stadium','https://depuertoricopalmundo.com/'),
('2026-08-22','San Juan','Puerto Rico','Hiram Bithorn Stadium','https://depuertoricopalmundo.com/'),
('2026-08-23','San Juan','Puerto Rico','Hiram Bithorn Stadium','https://depuertoricopalmundo.com/');


-- 1.2. Chronological sequential indexing of concerts
-- Add the concert_id column to number each show from 1 to 59.
ALTER TABLE concerts
ADD COLUMN concert_id integer;

-- Use the ROW_NUMBER() window function ordered by date and system tuple ID (ctid)
-- to assign a unique chronological identifier as a baseline for tracing the tour route.
WITH numbered_concerts AS (
    SELECT ctid,
           ROW_NUMBER() OVER (ORDER BY concert_date, ctid) AS seq_id
    FROM concerts
)
UPDATE concerts c
SET concert_id = nc.seq_id
FROM numbered_concerts nc
WHERE c.ctid = nc.ctid;