USE botas;
SELECT s.ordenes_produccion_id,e.etapa_id,e.nombre_etapa,SUM(s.cantidad_desperdicio_kg) AS perdida_kg
FROM seguimiento_etapas s
JOIN etapas_proceso e ON s.etapa_id = e.etapa_id
GROUP BY s.ordenes_produccion_id, e.etapa_id;