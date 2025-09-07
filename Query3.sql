use botas;
SELECT ordenes_produccion_id, cantidad_a_producir, estado,fecha_inicio_planificada
FROM ordenes_produccion
WHERE estado = 'en_proceso';