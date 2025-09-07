use botas;
SELECT  m.nombre_material, c.cantidad_consumida,m.unidad_medida
FROM consumo_materiales c
JOIN inventario_materia_prima i ON c.inventario_materia_prima_id = i.inventario_materia_prima_id
JOIN materia_prima m ON i.materia_prima_id = m.materia_prima_id
JOIN seguimiento_etapas s ON c.seguimiento_etapas_id = s.seguimiento_etapas_id;