use botas;
SELECT m.nombre_maquinaria, e.nombre_etapa, s.seguimiento_etapas_id FROM maquinaria_seguimiento_etapas ms
JOIN maquinaria m ON ms.maquinaria_id = m.maquinaria_id
JOIN seguimiento_etapas s ON ms.seguimiento_etapas_id = s.seguimiento_etapas_id
JOIN etapas_proceso e ON s.etapa_id = e.etapa_id;