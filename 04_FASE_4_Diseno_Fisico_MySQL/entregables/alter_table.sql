-- =============================================================================
-- alter_table.sql -- FASE 4
-- Ejecutar despues de schema.sql y antes de datos_prueba.sql.
-- =============================================================================

USE tfg_transporte_ue;

-- Columna para distancia estimada de ruta (planificacion y rentabilidad RF-022)
ALTER TABLE servicio
    ADD COLUMN km_estimados INT UNSIGNED NULL
        COMMENT 'Kilometros estimados de la ruta completa (planificacion)'
        AFTER observaciones;

-- Indice compuesto para consultas de cobro por estado y fecha de vencimiento
ALTER TABLE factura
    ADD INDEX idx_factura_cobro (estado_cobro, fecha_vencimiento);
