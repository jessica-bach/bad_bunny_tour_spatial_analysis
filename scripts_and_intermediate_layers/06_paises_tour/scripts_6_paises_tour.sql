--------------------------------------------------------------------------------
-- PROYECTO: Análisis Espacial y Logístico del "Debí tirar más fotos Tour" (Bad Bunny)
-- GESTOR DE BASE DE DATOS: PostgreSQL / PostGIS
-- DESCRIPCIÓN: Script integral de procesamiento, enriquecimiento y análisis espacial
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- SECCIÓN 6: SEGMENTACIÓN DE MERCADO ("PAISES_TOUR")
--------------------------------------------------------------------------------

-- 6.1. Creación de subconjuntos espaciales derivados
DROP TABLE IF EXISTS paises_tour;
CREATE TABLE paises_tour AS
SELECT *
FROM paises_mundo
WHERE tour = 'sí';

-- 6.2. Enriquecimiento de la capa

-- 6.2.1. Suma agregada de entradas vendidas a escala nacional (Absolutos)
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


-- 6.2.2. Agregación de cuota porcentual de mercado por país (Relativos)
ALTER TABLE paises_tour
ADD COLUMN IF NOT EXISTS porcentaje_asist_pais numeric;

UPDATE paises_tour pt
SET porcentaje_asist_pais = sub.total_porcentaje
FROM (
    SELECT pais, SUM(porcentaje_asist_global) AS total_porcentaje
    FROM estadios
    GROUP BY pais
) sub
WHERE pt.pais = sub.pais;

-- 6.2.3. Segmentación de los países por región
ALTER TABLE paises_tour 
ADD COLUMN region VARCHAR(50);

UPDATE paises_tour
SET region = CASE 
    WHEN pais IN ('México', 'Puerto Rico', 'República Dominicana', 'Chile', 'Costa Rica', 'Colombia', 'Perú', 'Argentina', 'Brasil') THEN 'América'
    WHEN pais IN ('Países Bajos', 'Bélgica', 'Reino Unido', 'Portugal', 'España', 'Francia', 'Italia', 'Alemania', 'Polonia', 'Suecia') THEN 'Europa'
    WHEN pais = 'Japón' THEN 'Asia'
    WHEN pais = 'Australia' THEN 'Oceanía'
    ELSE 'Otra' -- Manejo opcional por si hay algún país que no esté contemplado
END;
