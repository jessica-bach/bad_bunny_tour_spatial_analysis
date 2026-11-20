--------------------------------------------------------------------------------
-- PROYECTO: Análisis Espacial y Logístico del "Debí tirar más fotos Tour" (Bad Bunny)
-- GESTOR DE BASE DE DATOS: PostgreSQL / PostGIS
-- DESCRIPCIÓN: Script integral de procesamiento, enriquecimiento y análisis espacial
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- SECCIÓN 5: PROCESAMIENTO DE CAPAS BASE GLOBAL ("PAISES_MUNDO")
--------------------------------------------------------------------------------

-- Estandarización de la capa vectorial global de países
ALTER TABLE paises_mundo
RENAME COLUMN "PAÍS" TO pais;

-- Exclusión de la Antártida para optimizar el encuadre cartográfico mundial.
DELETE FROM paises_mundo 
WHERE pais = 'Antártida'; 

-- Creación de campo indicador de participación en el tour ('sí' / 'no').
ALTER TABLE paises_mundo
ADD COLUMN tour text;

UPDATE paises_mundo 
SET tour = 'no'; 

UPDATE paises_mundo 
SET tour = 'sí' 
WHERE pais IN (SELECT DISTINCT pais FROM estadios); 

-- Auditoría de control de calidad para detectar desajustes tipográficos entre tablas.
SELECT DISTINCT e.pais
FROM estadios e
WHERE e.pais NOT IN (
    SELECT pais 
    FROM paises_mundo 
    WHERE tour = 'sí'
);

-- Corrección tipográfica en nombres oficiales de países para asegurar cruces relacionales exitosos.
UPDATE paises_mundo
SET pais = CASE
    WHEN pais = 'Paises Bajos' THEN 'Países Bajos'
    WHEN pais = 'Puerto Rico (EEUU)' THEN 'Puerto Rico'
END
WHERE pais IN ('Paises Bajos', 'Puerto Rico (EEUU)');

-- Consulta de validación cruzada: verifica mediante ST_Intersects si los puntos de los estadios caen 
-- dentro de los límites del país asignado alfanuméricamente.
SELECT 
    e.estadio, 
    e.ciudad, 
    e.pais AS pais_estadio, 
    p.pais AS pais_poligono 
FROM estadios AS e 
LEFT JOIN paises_mundo AS p 
    ON ST_Intersects(e.geom, p.geom) 
WHERE e.pais != p.pais 
   OR p.pais IS NULL;
