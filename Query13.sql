USE botas;
SELECT m.nombre_material,p.nombre_proveedor,i.lote,i.cantidad_disponible,m.unidad_medida,i.precio_unitario,
ROUND(i.cantidad_disponible * i.precio_unitario, 2) AS valor_total,i.fecha_recepcion,
DATEDIFF(CURDATE(), i.fecha_recepcion) AS dias_en_inventario
FROM proveedores_inventario_materia_prima pim
JOIN proveedores p ON pim.proveedor_id = p.proveedor_id
JOIN inventario_materia_prima i ON pim.inventario_materia_prima_id = i.inventario_materia_prima_id
JOIN materia_prima m ON i.materia_prima_id = m.materia_prima_id
-- WHERE m.nombre_material LIKE '%PVC%'
ORDER BY m.nombre_material, i.fecha_recepcion DESC;