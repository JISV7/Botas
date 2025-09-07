use botas;
SELECT p.nombre_proveedor, i.lote,i.cantidad_disponible,i.precio_unitario
FROM proveedores_inventario_materia_prima pim
JOIN proveedores p ON pim.proveedor_id = p.proveedor_id
JOIN inventario_materia_prima i ON pim.inventario_materia_prima_id = i.inventario_materia_prima_id
WHERE i.materia_prima_id = 1;