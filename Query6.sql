use botas;
SELECT o.ordenes_produccion_id,p.nombre_producto, o.cantidad_a_producir, o.estado
FROM ordenes_produccion o
JOIN productos p ON o.producto_id = p.productos_id;