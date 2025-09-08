USE botas;
SELECT o.ordenes_produccion_id,p.nombre_producto,e.nombre_etapa,m.nombre_material,m.unidad_medida,
c.cantidad_consumida,ROUND(c.cantidad_consumida * i.precio_unitario, 2) AS costo_material,c.fecha_consumo
FROM consumo_materiales c
JOIN inventario_materia_prima i ON c.inventario_materia_prima_id = i.inventario_materia_prima_id
JOIN materia_prima m ON i.materia_prima_id = m.materia_prima_id
JOIN seguimiento_etapas s ON c.seguimiento_etapas_id = s.seguimiento_etapas_id
JOIN ordenes_produccion o ON s.ordenes_produccion_id = o.ordenes_produccion_id
JOIN productos p ON o.producto_id = p.productos_id
JOIN etapas_proceso e ON s.etapa_id = e.etapa_id
ORDER BY o.ordenes_produccion_id, e.nombre_etapa, c.fecha_consumo;