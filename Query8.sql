use botas;
SELECT nombre_maquinaria, modelo, estado_operativo
FROM maquinaria
WHERE estado_operativo = 'mantenimiento';