-- =============================================================================
-- trigger_auditoria.sql
-- FASE 6 - Explotacion Avanzada SQL
-- TFG: Gestion de empresa de transporte intracomunitario (UE)
-- Centro FP Maria Auxiliadora - 2 DAM - Curso 2024-26
-- Alumno: Cesar Mendez | Fecha: 2026-06-02
-- =============================================================================
-- Copia sincronizada desde:
-- 06_FASE_6_Explotacion_Avanzada_SQL/entregables/trigger_auditoria.sql
-- Trigger: trg_auditoria_cambio_estado_servicio
-- Tipo: AFTER UPDATE ON servicio
-- Efecto: si el campo estado_actual cambia, inserta automaticamente un registro
--         en registro_auditoria con el cambio producido.
-- =============================================================================
-- INSTRUCCIONES PARA phpMyAdmin:
--   1. Abrir la pestana SQL de la BD tfg_transporte_ue
--   2. Cambiar el campo "Delimitador" de ; a //
--   3. Pegar y ejecutar este script completo
--   4. Volver a cambiar el delimitador a ; para consultas normales
-- =============================================================================

USE tfg_transporte_ue;

DROP TRIGGER IF EXISTS trg_auditoria_cambio_estado_servicio;

DELIMITER //

CREATE TRIGGER trg_auditoria_cambio_estado_servicio
AFTER UPDATE ON servicio
FOR EACH ROW
BEGIN
    IF NEW.estado_actual <> OLD.estado_actual THEN
        INSERT INTO registro_auditoria
            (tipo_operacion,
             entidad_afectada,
             id_registro_afectado,
             fecha_hora,
             usuario,
             descripcion)
        VALUES
            ('Cambio_estado',
             'servicio',
             NEW.id_servicio,
             NOW(),
             'sistema',
             CONCAT('Estado: ', OLD.estado_actual,
                    ' -> ', NEW.estado_actual,
                    ' | Servicio: ', NEW.numero_servicio));
    END IF;
END //

DELIMITER ;

-- =============================================================================
-- PRUEBA DEL TRIGGER
-- Ejecutar estos pasos uno a uno para verificar que el trigger funciona.
-- =============================================================================

-- Paso 1: ver el estado actual del servicio 4 antes del cambio
SELECT id_servicio, numero_servicio, estado_actual
FROM servicio
WHERE id_servicio = 4;

-- Paso 2: actualizar el estado del servicio 4 (Planificado -> Asignado)
-- Esto activa el trigger automaticamente
UPDATE servicio
SET estado_actual = 'Asignado'
WHERE id_servicio = 4;

-- Paso 3: comprobar que el trigger genero el registro en auditoria
SELECT id_auditoria, tipo_operacion, entidad_afectada,
       id_registro_afectado, fecha_hora, usuario, descripcion
FROM registro_auditoria
ORDER BY id_auditoria DESC
LIMIT 5;

-- =============================================================================
-- Resultado esperado en el Paso 3:
-- El registro mas reciente debe mostrar:
--   tipo_operacion   = 'Cambio_estado'
--   entidad_afectada = 'servicio'
--   id_registro_afectado = 4
--   descripcion      = 'Estado: Planificado -> Asignado | Servicio: SRV-2026-0004'
-- =============================================================================
