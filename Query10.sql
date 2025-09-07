use botas;
SELECT emp.nombre, emp.apellido, et.nombre_etapa
FROM empleados_seguimiento_etapas ese
JOIN empleados emp ON ese.empleados_id = emp.empleados_id
JOIN seguimiento_etapas s ON ese.seguimiento_etapas_id = s.seguimiento_etapas_id
JOIN etapas_proceso et ON s.etapa_id = et.etapa_id;