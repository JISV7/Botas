use botas;
SELECT ordenes_produccion_id, cantidad_a_producir, estado,fecha_solicitud,
fecha_inicio_planificada,fecha_fin_planificada,fecha_fin
FROM ordenes_produccion
WHERE estado = 'en_proceso';