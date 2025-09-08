-- 6. Agregar tabla de clientes y relación con órdenes de producción
CREATE TABLE clientes (
    cliente_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre_cliente VARCHAR(150) NOT NULL,
    rif VARCHAR(30) NOT NULL,
    direccion VARCHAR(400) DEFAULT NULL,
    telefono VARCHAR(40) DEFAULT NULL,
    email VARCHAR(150) DEFAULT NULL,
    PRIMARY KEY (cliente_id),
    UNIQUE KEY uk_cliente_rif (rif)
);

ALTER TABLE ordenes_produccion 
ADD COLUMN cliente_id INT UNSIGNED AFTER producto_id;

ALTER TABLE ordenes_produccion 
ADD CONSTRAINT fk_op_cliente FOREIGN KEY (cliente_id) 
REFERENCES clientes(cliente_id) ON DELETE SET NULL ON UPDATE CASCADE;

-- Insertar clientes de ejemplo
INSERT INTO clientes (nombre_cliente, rif, direccion, telefono, email) VALUES
('Cliente A', 'J-12345678-0', 'Caracas, Venezuela', '0414-1234567', 'clientea@example.com'),
('Cliente B', 'J-87654321-0', 'Valencia, Venezuela', '0414-7654321', 'clienteb@example.com');

-- Actualizar órdenes existentes con cliente_id
UPDATE ordenes_produccion SET cliente_id = 1 WHERE cliente_id IS NULL;