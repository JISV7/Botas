use botas;
SELECT o.ordenes_produccion_id, m.nombre_material, SUM(c.cantidad_consumida) AS total_consumo
FROM consumo_materiales c
JOIN inventario_materia_prima i ON c.inventario_materia_prima_id = i.inventario_materia_prima_id
JOIN materia_prima m ON i.materia_prima_id = m.materia_prima_id
JOIN seguimiento_etapas s ON c.seguimiento_etapas_id = s.seguimiento_etapas_id
JOIN ordenes_produccion o ON s.ordenes_produccion_id = o.ordenes_produccion_id
GROUP BY o.ordenes_produccion_id, m.nombre_material;