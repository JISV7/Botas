USE botas;
SELECT o.ordenes_produccion_id,p.nombre_producto,e.nombre_etapa,m.nombre_maquinaria,
GROUP_CONCAT(CONCAT(emp.nombre, ' ', emp.apellido) SEPARATOR ', ') AS empleados_participantes, s.fecha_inicio,s.fecha_fin
FROM seguimiento_etapas s
JOIN ordenes_produccion o ON s.ordenes_produccion_id = o.ordenes_produccion_id
JOIN productos p ON o.producto_id = p.productos_id
JOIN etapas_proceso e ON s.etapa_id = e.etapa_id
JOIN maquinaria_seguimiento_etapas ms ON s.seguimiento_etapas_id = ms.seguimiento_etapas_id
JOIN maquinaria m ON ms.maquinaria_id = m.maquinaria_id
LEFT JOIN empleados_seguimiento_etapas es ON s.seguimiento_etapas_id = es.seguimiento_etapas_id
LEFT JOIN empleados emp ON es.empleados_id = emp.empleados_id
WHERE o.ordenes_produccion_id = 1
GROUP BY s.seguimiento_etapas_id, o.ordenes_produccion_id, p.nombre_producto, e.nombre_etapa,m.nombre_maquinaria, s.fecha_inicio, s.fecha_fin
ORDER BY s.fecha_inicio;