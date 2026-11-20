--------------------------------------------------------------------------------
-- PROYECTO: Análisis Espacial y Logístico del "Debí tirar más fotos Tour" (Bad Bunny)
-- GESTOR DE BASE DE DATOS: PostgreSQL / PostGIS
-- DESCRIPCIÓN: Script integral de procesamiento, enriquecimiento y análisis espacial
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- SECCIÓN 7: CONSULTAS DE MÉTRICAS GLOBALES DE LA GIRA
--------------------------------------------------------------------------------

-- 7.2. Diapositiva 11. Cálculo de la duración temporal total del tour (en días)
-- Obtiene la diferencia exacta entre el primer y el último concierto programado.
SELECT 
    (MAX(fecha) - MIN(fecha)) AS duracion_dias
FROM conciertos;

-- 7.2. Diapositiva 13. Cálculo de cantidad de entradas vendidas por región
SELECT
region,
SUM(asist_total_pais) 
FROM paises_tour
GROUP BY(region) 
ORDER BY SUM(asist_total_pais) DESC;

-- 7.2. Diapositiva 23. Cálculo de media y mediana de CO2 per cápita
SELECT 
    AVG(kg_co2_asistente) AS media,
    percentile_cont(0.5) WITHIN GROUP (ORDER BY kg_co2_asistente) AS mediana
FROM tour_lineas;