use botas;
-- 1. Convertir unidades de medida a mayúsculas en la tabla materia_prima
UPDATE materia_prima SET unidad_medida = UPPER(unidad_medida);

-- 2. Agregar división de almacenes (sectores) para materia prima y producto terminado
-- Primero, añadir columna 'sector' en inventario_materia_prima
ALTER TABLE inventario_materia_prima ADD COLUMN sector VARCHAR(50) AFTER ubicacion_almacen;

-- Actualizar sectores existentes para Almacén A (materia prima)
UPDATE inventario_materia_prima 
SET sector = '2B' 
WHERE ubicacion_almacen = 'Almacén A';

UPDATE inventario_materia_prima 
SET sector = '9S' 
WHERE ubicacion_almacen = 'Almacén B';

-- Crear nueva tabla para inventario de producto terminado
CREATE TABLE inventario_producto_terminado (
    inventario_pt_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    producto_id INT UNSIGNED NOT NULL,
    lote VARCHAR(60) NOT NULL,
    cantidad_disponible INT NOT NULL DEFAULT 0,
    ubicacion_almacen VARCHAR(120) DEFAULT 'Almacén B',
    sector VARCHAR(50) DEFAULT 'PT-A2',
    fecha_ingreso DATE NOT NULL,
    PRIMARY KEY (inventario_pt_id),
    CONSTRAINT fk_invpt_producto FOREIGN KEY (producto_id) 
        REFERENCES productos(productos_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 3. Eliminar decimales innecesarios en tablas donde los valores son enteros
-- Cambiar tipo de datos a INT en tablas donde los decimales no son necesarios

ALTER TABLE seguimiento_etapas 
MODIFY cantidad_producida INT;

ALTER TABLE ordenes_produccion 
MODIFY cantidad_a_producir INT NOT NULL;

-- 4. Agregar fecha de solicitud en órdenes de producción
ALTER TABLE ordenes_produccion 
ADD COLUMN fecha_solicitud DATE AFTER fecha_creacion;


-- 6. Agregar tabla para registrar pérdidas por etapa por orden de producción (ya existe en seguimiento_etapas, pero se asegura la sumatoria)
-- La tabla seguimiento_etapas ya tiene cantidad_desperdicio_kg, por lo que no se necesita cambio estructural.