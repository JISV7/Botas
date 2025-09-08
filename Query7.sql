USE botas;
SELECT nombre,apellido,cargo,fecha_ingreso,CONCAT(
FLOOR(DATEDIFF(CURDATE(), fecha_ingreso) / 365), ' años, ',
FLOOR((DATEDIFF(CURDATE(), fecha_ingreso) % 365) / 30), ' meses'
) AS antiguedad
FROM empleados
WHERE estado = 'activo';