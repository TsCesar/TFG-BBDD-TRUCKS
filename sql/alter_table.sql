-- =============================================================================
-- alter_table.sql
-- FASE 4 - Diseno Fisico MySQL
-- Proyecto TFG: Gestion integral de empresa de transporte intracomunitario (UE)
-- Centro FP Maria Auxiliadora - 2 DAM - Curso 2024-26
-- Alumno: Cesar Mendez
-- Fecha: 2026-06-01
-- =============================================================================
-- NOTAS DE EJECUCION:
--   Ejecutar DESPUES de schema.sql y ANTES de datos_prueba.sql.
--   Contiene dos modificaciones estructurales independientes y justificadas.
-- =============================================================================

USE tfg_transporte_ue;

-- =============================================================================
-- ALTER TABLE 1: ADD COLUMN km_estimados en servicio
-- =============================================================================
-- Justificacion:
--   Al cerrar FASE 3 se detecto que el modelo logico no incluye informacion
--   sobre la distancia estimada de cada servicio. Sin embargo, la propuesta
--   exige calcular la rentabilidad por operacion (RF-022). Para ello es util
--   disponer de los kilometros estimados de la ruta, dato que se conoce en la
--   fase de planificacion y que permite calcular costes de combustible teoricos
--   y comparar estimacion vs real.
--   Esta columna no figuraba en FASE 3 porque el modelo logico se centra en
--   datos operativos y documentales. Se anade en FASE 4 como mejora del
--   diseno fisico tras el analisis de requisitos de explotacion de FASE 5.
--   Decision registrada como DD-008 en docs/decisiones_diseno.md.
-- =============================================================================

ALTER TABLE servicio
    ADD COLUMN km_estimados INT UNSIGNED NULL
        COMMENT 'Kilometros estimados de la ruta completa (planificacion)'
        AFTER observaciones;

-- Verificacion: la columna debe aparecer al final de servicio
-- DESCRIBE servicio;

-- =============================================================================
-- ALTER TABLE 2: ADD INDEX idx_factura_cobro en factura
-- =============================================================================
-- Justificacion:
--   Las consultas de FASE 5 y FASE 6 sobre el estado de cobro de facturas
--   (facturas pendientes, vencidas, en mora) son las mas frecuentes en la
--   gestion financiera de la empresa. Sin un indice sobre (estado_cobro,
--   fecha_vencimiento), MySQL realiza un full table scan sobre factura cada
--   vez que el departamento de administracion consulta facturas impagadas.
--   El indice compuesto permite resolver consultas del tipo:
--     WHERE estado_cobro = 'Pendiente' AND fecha_vencimiento < CURDATE()
--   con un acceso por rango eficiente.
--   Esta optimizacion no altera el modelo logico ni las restricciones, solo
--   mejora el rendimiento de lectura en un patron de consulta previsible.
-- =============================================================================

ALTER TABLE factura
    ADD INDEX idx_factura_cobro (estado_cobro, fecha_vencimiento);

-- Verificacion: el indice debe aparecer en SHOW INDEX FROM factura
-- SHOW INDEX FROM factura WHERE Key_name = 'idx_factura_cobro';

-- =============================================================================
-- Fin del script
-- Cambios aplicados:
--   1. servicio.km_estimados INT UNSIGNED NULL (nueva columna)
--   2. factura: indice compuesto (estado_cobro, fecha_vencimiento)
-- =============================================================================
