use botas;
SELECT m.nombre_material, SUM(i.cantidad_disponible) AS cantidad_disponible, m.unidad_medida AS total_disponible
FROM inventario_materia_prima i 
JOIN materia_prima m ON i.materia_prima_id = m.materia_prima_id
GROUP BY m.nombre_material;