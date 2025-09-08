USE botas;
SELECT nombre_maquinaria, modelo, estado_operativo,fecha_ultimo_mantenimiento,
CASE 
WHEN estado_operativo = 'mantenimiento' THEN
CONCAT('En mantenimiento desde ', DATE_FORMAT(fecha_inicio_mantenimiento, '%d/%m/%Y'),
', estimado hasta ', DATE_FORMAT(fecha_fin_estimado_mantenimiento, '%d/%m/%Y'))
WHEN estado_operativo = 'fuera_servicio' THEN 'Fuera de servicio'
ELSE CONCAT('Operativa - Último mantenimiento: ', DATE_FORMAT(fecha_ultimo_mantenimiento, '%d/%m/%Y'))
END AS estado_detallado
FROM maquinaria
ORDER BY estado_operativo, nombre_maquinaria;