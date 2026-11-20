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
DROP TABLE IF EXISTS conciertos;

CREATE TABLE conciertos (
    fecha   date,
    ciudad  text,
    pais    text,
    estadio text,
    fuente  text
);

-- Insert the official live performance schedule for the tour.
INSERT INTO conciertos (fecha, ciudad, pais, estadio, fuente) VALUES
('2025-11-21','Santo Domingo','República Dominicana','Estadio Olímpico','https://depuertoricopalmundo.com/'),
('2025-11-22','Santo Domingo','República Dominicana','Estadio Olímpico','https://depuertoricopalmundo.com/'),
('2025-12-05','San José','Costa Rica','Estadio Nacional','https://depuertoricopalmundo.com/'),
('2025-12-06','San José','Costa Rica','Estadio Nacional','https://depuertoricopalmundo.com/'),
('2025-12-10','Ciudad de México','México','Estadio GNP Seguros','https://depuertoricopalmundo.com/'),
('2025-12-11','Ciudad de México','México','Estadio GNP Seguros','https://depuertoricopalmundo.com/'),
('2025-12-12','Ciudad de México','México','Estadio GNP Seguros','https://depuertoricopalmundo.com/'),
('2025-12-15','Ciudad de México','México','Estadio GNP Seguros','https://depuertoricopalmundo.com/'),
('2025-12-16','Ciudad de México','México','Estadio GNP Seguros','https://depuertoricopalmundo.com/'),
('2025-12-19','Ciudad de México','México','Estadio GNP Seguros','https://depuertoricopalmundo.com/'),
('2025-12-20','Ciudad de México','México','Estadio GNP Seguros','https://depuertoricopalmundo.com/'),
('2025-12-21','Ciudad de México','México','Estadio GNP Seguros','https://depuertoricopalmundo.com/'),
('2026-01-09','Santiago','Chile','Estadio Nacional Julio Martínez Prádanos','https://depuertoricopalmundo.com/'),
('2026-01-10','Santiago','Chile','Estadio Nacional Julio Martínez Prádanos','https://depuertoricopalmundo.com/'),
('2026-01-11','Santiago','Chile','Estadio Nacional Julio Martínez Prádanos','https://depuertoricopalmundo.com/'),
('2026-01-16','Lima','Perú','Estadio Nacional','https://depuertoricopalmundo.com/'),
('2026-01-17','Lima','Perú','Estadio Nacional','https://depuertoricopalmundo.com/'),
('2026-01-23','Medellín','Colombia','Estadio Atanasio Girardot','https://depuertoricopalmundo.com/'),
('2026-01-24','Medellín','Colombia','Estadio Atanasio Girardot','https://depuertoricopalmundo.com/'),
('2026-01-25','Medellín','Colombia','Estadio Atanasio Girardot','https://depuertoricopalmundo.com/'),
('2026-02-13','Buenos Aires','Argentina','Estadio River Plate','https://depuertoricopalmundo.com/'),
('2026-02-14','Buenos Aires','Argentina','Estadio River Plate','https://depuertoricopalmundo.com/'),
('2026-02-15','Buenos Aires','Argentina','Estadio River Plate','https://depuertoricopalmundo.com/'),
('2026-02-20','San Pablo','Brasil','Allianz Parque','https://depuertoricopalmundo.com/'),
('2026-02-21','San Pablo','Brasil','Allianz Parque','https://depuertoricopalmundo.com/'),
('2026-02-28','Sídney','Australia','ENGIE Stadium','https://depuertoricopalmundo.com/'),
('2026-03-01','Sídney','Australia','ENGIE Stadium','https://depuertoricopalmundo.com/'),
('2026-03-07','Tokio','Japón','','https://depuertoricopalmundo.com/'),
('2026-05-22','Barcelona','España','Estadi Olímpic Lluís Companys','https://depuertoricopalmundo.com/'),
('2026-05-23','Barcelona','España','Estadi Olímpic Lluís Companys','https://depuertoricopalmundo.com/'),
('2026-05-26','Lisboa','Portugal','Estadio da Luz','https://depuertoricopalmundo.com/'),
('2026-05-27','Lisboa','Portugal','Estadio da Luz','https://depuertoricopalmundo.com/'),
('2026-05-30','Madrid','España','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-05-31','Madrid','España','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-02','Madrid','España','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-03','Madrid','España','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-06','Madrid','España','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-07','Madrid','España','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-10','Madrid','España','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-11','Madrid','España','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-14','Madrid','España','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-15','Madrid','España','Riyadh Air Metropolitano','https://depuertoricopalmundo.com/'),
('2026-06-20','Düsseldorf','Alemania','Merkur Spiel-Arena','https://depuertoricopalmundo.com/'),
('2026-06-21','Düsseldorf','Alemania','Merkur Spiel-Arena','https://depuertoricopalmundo.com/'),
('2026-06-23','Arnhem','Países Bajos','GelreDome','https://depuertoricopalmundo.com/'),
('2026-06-24','Arnhem','Países Bajos','GelreDome','https://depuertoricopalmundo.com/'),
('2026-06-27','Londres','Reino Unido','Tottenham Hotspur Stadium','https://depuertoricopalmundo.com/'),
('2026-06-28','Londres','Reino Unido','Tottenham Hotspur Stadium','https://depuertoricopalmundo.com/'),
('2026-07-01','Marsella','Francia','Orange Vélodrome','https://depuertoricopalmundo.com/'),
('2026-07-04','París','Francia','La Défense Arena','https://depuertoricopalmundo.com/'),
('2026-07-05','París','Francia','La Défense Arena','https://depuertoricopalmundo.com/'),
('2026-07-10','Estocolmo','Suecia','Strawberry Arena','https://depuertoricopalmundo.com/'),
('2026-07-11','Estocolmo','Suecia','Strawberry Arena','https://depuertoricopalmundo.com/'),
('2026-07-14','Varsovia','Polonia','PGE Narodowy','https://depuertoricopalmundo.com/'),
('2026-07-17','Milán','Italia','Ippodromo Snai La Maura','https://depuertoricopalmundo.com/'),
('2026-07-18','Milán','Italia','Ippodromo Snai La Maura','https://depuertoricopalmundo.com/'),
('2026-07-22','Bruselas','Bélgica','King Baudouin Stadium','https://depuertoricopalmundo.com/'),
('2026-08-22','San Juan','Puerto Rico','Estadio Hiram Bithorn','https://depuertoricopalmundo.com/'),
('2026-08-23','San Juan','Puerto Rico','Estadio Hiram Bithorn','https://depuertoricopalmundo.com/');


-- 1.2. Chronological sequential indexing of concerts
-- Add the concert_id column to number each show from 1 to 59.

ALTER TABLE conciertos
ADD COLUMN id_concierto integer;

-- Use the ROW_NUMBER() window function ordered by date and system tuple ID (ctid)
-- to assign a unique chronological identifier as a baseline for tracing the tour route.

UPDATE conciertos c
SET id_concierto = sub.ID
FROM (
    SELECT fecha, ciudad, pais,
           ROW_NUMBER() OVER (ORDER BY fecha) AS ID
    FROM conciertos
) sub
WHERE c.fecha = sub.fecha
  AND c.ciudad = sub.ciudad
  AND c.pais = sub.pais;