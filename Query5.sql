use botas;
SELECT o.ordenes_produccion_id, SUM(s.cantidad_producida) AS total_producido
FROM seguimiento_etapas s
JOIN ordenes_produccion o ON s.ordenes_produccion_id = o.ordenes_produccion_id
GROUP BY o.ordenes_produccion_id;