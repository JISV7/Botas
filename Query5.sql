USE botas;
SELECT o.ordenes_produccion_id,o.fecha_solicitud AS fecha_orden,c.nombre_cliente,p.nombre_producto,
(SELECT s2.cantidad_producida
FROM seguimiento_etapas s2
WHERE s2.ordenes_produccion_id = o.ordenes_produccion_id
ORDER BY s2.fecha_fin DESC LIMIT 1) AS total_botas
FROM ordenes_produccion o
JOIN clientes c ON o.cliente_id = c.cliente_id
JOIN productos p ON o.producto_id = p.productos_id;