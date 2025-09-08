USE botas;
SELECT o.ordenes_produccion_id,p.nombre_producto,p.modelo,p.talla,p.color,c.nombre_cliente,o.cantidad_a_producir,
COALESCE(SUM(s.cantidad_producida), 0) AS cantidad_producida,o.estado,o.fecha_solicitud,o.fecha_inicio_planificada,
o.fecha_fin_planificada, DATEDIFF(CURDATE(), o.fecha_solicitud) AS dias_desde_solicitud
FROM ordenes_produccion o
JOIN productos p ON o.producto_id = p.productos_id
LEFT JOIN clientes c ON o.cliente_id = c.cliente_id
LEFT JOIN seguimiento_etapas s ON o.ordenes_produccion_id = s.ordenes_produccion_id
GROUP BY o.ordenes_produccion_id
ORDER BY o.estado, o.fecha_solicitud DESC;