use botas;
SELECT i.lote, m.nombre_material, i.cantidad_disponible, i.ubicacion_almacen, i.sector
FROM inventario_materia_prima i
JOIN materia_prima m ON i.materia_prima_id = m.materia_prima_id;