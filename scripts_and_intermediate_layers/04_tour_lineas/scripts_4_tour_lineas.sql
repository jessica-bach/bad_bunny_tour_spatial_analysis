--------------------------------------------------------------------------------
-- PROYECTO: Análisis Espacial y Logístico del "Debí tirar más fotos Tour" (Bad Bunny)
-- GESTOR DE BASE DE DATOS: PostgreSQL / PostGIS
-- DESCRIPCIÓN: Script integral de procesamiento, enriquecimiento y análisis espacial
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- SECCIÓN 4: CONSTRUCCIÓN DE TRAYECTORIAS Y ANÁLISIS DE RED ("TOUR_LINEAS")
--------------------------------------------------------------------------------

-- 4.1. Creación de la capa de líneas de vuelo secuenciales
-- Utiliza la función de ventana LEAD() para conectar el estadio actual con el siguiente cronológico,
-- construyendo arcos vectoriales mediante ST_MakeLine().
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

-- Eliminación del registro nulo correspondiente al último tramo (San Juan no tiene destino posterior).
DELETE FROM tour_lineas
WHERE geom IS NULL;

-- Depuración de identificadores auxiliares temporales.
ALTER TABLE tour_lineas
DROP COLUMN desde_id,
DROP COLUMN hasta_id;


-- 4.2. Enriquecimiento de trayectorias (Distancias y Logística de Vuelo)

-- 4.2.1. Cálculo de distancias geodésicas (Ortodrómicas) en Kilómetros
ALTER TABLE tour_lineas
ADD COLUMN distancia_km numeric;

UPDATE tour_lineas
SET distancia_km = ROUND(
    ST_Distance(
        ST_StartPoint(geom)::geography,
        ST_EndPoint(geom)::geography
    ) / 1000
);


-- 4.2.2. Estimación del tiempo de vuelo en horas continuas
-- Basado en la velocidad de crucero promedio de un jet privado Bombardier Global 7500 (904 km/h).
ALTER TABLE tour_lineas
ADD COLUMN horas_de_vuelo numeric;

UPDATE tour_lineas
SET horas_de_vuelo = ROUND(distancia_km / 904.0, 2);


-- 4.2.3. Formateo legible de tiempo de vuelo (Horas y Minutos)
ALTER TABLE tour_lineas
ADD COLUMN tiempo_vuelo text;

UPDATE tour_lineas
SET tiempo_vuelo =
    FLOOR(horas_de_vuelo)::text || 'h ' ||
    ROUND((horas_de_vuelo - FLOOR(horas_de_vuelo)) * 60)::text || '''';


-- 4.2.4. Estimación de emisiones brutas de CO2 (Toneladas)
-- Aplicando un factor de emisión de 3.8 toneladas de CO2 por hora de vuelo para reactores ejecutivos.
ALTER TABLE tour_lineas
ADD COLUMN co2_ton NUMERIC;

UPDATE tour_lineas
SET co2_ton = ROUND(horas_de_vuelo * 3.8, 2);


-- 4.2.5. Normalización de la huella de carbono por asistente en destino
-- Se vincula el volumen de asistentes del estadio de destino y se calcula el ratio kg CO2 / espectador.
ALTER TABLE tour_lineas
ADD COLUMN asistentes_destino INTEGER;

UPDATE tour_lineas tl
SET asistentes_destino = e.asist_total
FROM estadios e
WHERE tl.hasta_ciudad = e.ciudad
  AND tl.hasta_pais = e.pais;

ALTER TABLE tour_lineas
ADD COLUMN kg_co2_asistente NUMERIC;

UPDATE tour_lineas
SET kg_co2_asistente = ROUND(
    (co2_ton * 1000.0) / asistentes_destino,
    3
)
WHERE asistentes_destino > 0;