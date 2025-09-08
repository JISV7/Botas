USE botas;
SELECT o.ordenes_produccion_id,p.nombre_producto,p.modelo,p.talla,m.nombre_material,m.unidad_medida,
SUM(c.cantidad_consumida) AS total_consumo,ROUND(SUM(c.cantidad_consumida * i.precio_unitario), 2) AS costo_total_material,
COUNT(DISTINCT s.seguimiento_etapas_id) AS etapas_utilizadas
FROM consumo_materiales c
JOIN inventario_materia_prima i ON c.inventario_materia_prima_id = i.inventario_materia_prima_id
JOIN materia_prima m ON i.materia_prima_id = m.materia_prima_id
JOIN seguimiento_etapas s ON c.seguimiento_etapas_id = s.seguimiento_etapas_id
JOIN ordenes_produccion o ON s.ordenes_produccion_id = o.ordenes_produccion_id
JOIN productos p ON o.producto_id = p.productos_id
GROUP BY o.ordenes_produccion_id, m.materia_prima_id
ORDER BY o.ordenes_produccion_id, costo_total_material DESC;