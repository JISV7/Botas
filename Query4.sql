use botas;
SELECT s.seguimiento_etapas_id, e.nombre_etapa, s.cantidad_producida
FROM seguimiento_etapas s
JOIN etapas_proceso e ON s.etapa_id = e.etapa_id;