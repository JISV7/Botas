USE botas;
SELECT emp.empleados_id,CONCAT(emp.nombre, ' ', emp.apellido) AS empleado,emp.cargo,
COUNT(DISTINCT s.seguimiento_etapas_id) AS total_etapas_participadas,COUNT(DISTINCT o.ordenes_produccion_id) AS total_ordenes_trabajadas,
SUM(TIMESTAMPDIFF(HOUR, s.fecha_inicio, s.fecha_fin)) AS total_horas_trabajadas,
SUM(s.cantidad_producida) AS total_produccion
FROM empleados_seguimiento_etapas ese
JOIN empleados emp ON ese.empleados_id = emp.empleados_id
JOIN seguimiento_etapas s ON ese.seguimiento_etapas_id = s.seguimiento_etapas_id
JOIN ordenes_produccion o ON s.ordenes_produccion_id = o.ordenes_produccion_id
WHERE emp.estado = 'activo'
GROUP BY emp.empleados_id
ORDER BY total_horas_trabajadas DESC;