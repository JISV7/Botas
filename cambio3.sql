-- Agregar columnas para fechas de mantenimiento
ALTER TABLE maquinaria 
ADD COLUMN fecha_inicio_mantenimiento DATE AFTER fecha_ultimo_mantenimiento,
ADD COLUMN fecha_fin_estimado_mantenimiento DATE AFTER fecha_inicio_mantenimiento;

-- Actualizar datos existentes con fechas de mantenimiento (ejemplo)
UPDATE maquinaria 
SET fecha_inicio_mantenimiento = '2025-08-15', 
    fecha_fin_estimado_mantenimiento = '2025-08-25'
WHERE maquinaria_id = 4; -- Moldeadora B2