-- =============================================================================
-- consultas_basicas.sql
-- FASE 5 - Explotacion Basica SQL
-- TFG: Gestion de empresa de transporte intracomunitario (UE)
-- Centro FP Maria Auxiliadora - 2 DAM - Curso 2024-26
-- Alumno: Cesar Mendez | Fecha: 2026-06-02
-- =============================================================================
-- Copia sincronizada desde:
-- 05_FASE_5_Explotacion_Basica_SQL/entregables/consultas_basicas.sql
-- Prerequisitos: schema.sql, alter_table.sql y datos_prueba.sql ya ejecutados.
-- Ejecutar este script sobre la BD tfg_transporte_ue ya cargada en FASE 4.
-- Para tomar capturas por separado: ejecutar cada seccion de forma individual.
-- =============================================================================

USE tfg_transporte_ue;

-- =============================================================================
-- ACTIVIDAD 1 -- INSERT: Añadir nuevos registros
-- Cubre: actividad 1 del listado oficial FASE 5
-- =============================================================================

-- Nuevo contacto para Pharma Distribution GmbH (id_cliente=2)
-- Caso real: la empresa cliente incorpora una coordinadora de transporte
INSERT INTO contacto
    (id_cliente, nombre, apellidos, cargo, telefono, email, es_principal)
VALUES
    (2, 'Petra', 'Schreiber', 'Coordinadora de Transporte',
     '+49 173 9988 771', 'p.schreiber@pharmadist.de', 0);

-- Nuevo coste operativo imputado a SRV-2026-0002 (farmaceutico, en transito)
-- Caso real: dieta del conductor durante la noche en ruta hacia Madrid
INSERT INTO coste_operativo
    (id_servicio, tipo_coste, importe, fecha, descripcion, justificante_disponible)
VALUES
    (2, 'Dietas', 55.00, '2026-04-22',
     'Dieta conductor noche en ruta Innsbruck', 1);

-- Registro de prueba para demostracion de DELETE
-- Se usa un CIF ficticio para poder borrarlo de forma segura y controlada
INSERT INTO cliente
    (nombre_razon_social, cif_nif, pais, ciudad, condiciones_pago, activo)
VALUES
    ('TEST Empresa Demo SL', 'TEST-DELETE-01', 'Espana', 'Madrid', '30 dias', 1);

-- =============================================================================
-- ACTIVIDAD 2 -- UPDATE: Modificar datos existentes
-- Cubre: actividad 2 del listado oficial FASE 5
-- =============================================================================

-- Corregir email de Auto Parts Poland (nuevo cliente 2026, dato actualizado)
UPDATE cliente
SET email = 'transporte@autoparts-pl.eu'
WHERE id_cliente = 4;

-- Marcar SRV-2026-0004 con documentacion completa tras recibir el CMR desde Warszawa
UPDATE servicio
SET documentacion_completa = 1
WHERE numero_servicio = 'SRV-2026-0004';

-- Pasar incidencia id=2 (demora frontera francesa, Pharma) de Abierta a En_gestion
UPDATE incidencia
SET estado                     = 'En_gestion',
    fecha_ultima_actualizacion = NOW(),
    responsable_gestion        = 'trafico.lopez'
WHERE id_incidencia = 2;

-- =============================================================================
-- ACTIVIDAD 3 -- DELETE: Borrar registros de prueba
-- Cubre: actividad 3 del listado oficial FASE 5
-- El cliente de prueba no tiene servicios ni contactos vinculados, por lo que
-- el DELETE no viola ninguna restriccion de integridad referencial.
-- =============================================================================

DELETE FROM cliente
WHERE cif_nif = 'TEST-DELETE-01';

-- =============================================================================
-- ACTIVIDAD 4 -- Consultar clientes activos
-- Cubre: actividad 4 del listado oficial FASE 5
-- Tablas: cliente
-- =============================================================================

SELECT id_cliente,
       nombre_razon_social,
       pais,
       ciudad,
       condiciones_pago
FROM cliente
WHERE activo = 1
ORDER BY nombre_razon_social;

-- =============================================================================
-- ACTIVIDAD 5 -- Consultar servicios por estado
-- Cubre: actividad 5 del listado oficial FASE 5
-- Tablas: servicio
-- =============================================================================

SELECT numero_servicio,
       tipo_servicio,
       nivel_urgencia,
       estado_actual,
       fecha_solicitud,
       fecha_prevista_recogida
FROM servicio
ORDER BY estado_actual, fecha_prevista_recogida;

-- =============================================================================
-- ACTIVIDAD 6 -- Consultar vehiculos y conductores disponibles
-- Cubre: actividad 6 del listado oficial FASE 5
-- Tablas: vehiculo, conductor
-- =============================================================================

-- Vehiculos disponibles para asignacion
SELECT id_vehiculo,
       matricula,
       tipo,
       marca,
       modelo,
       capacidad_carga_kg
FROM vehiculo
WHERE estado_operativo = 'Disponible'
ORDER BY tipo, marca;

-- Conductores disponibles para asignacion
SELECT id_conductor,
       numero_empleado,
       nombre,
       apellidos,
       estado_disponibilidad
FROM conductor
WHERE estado_disponibilidad = 'Disponible'
ORDER BY apellidos;

-- =============================================================================
-- ACTIVIDAD 7 -- Consultar facturas pendientes e incidencias abiertas
-- Cubre: actividad 7 del listado oficial FASE 5
-- Tablas: factura, incidencia
-- =============================================================================

-- Facturas pendientes de cobro o vencidas
SELECT id_factura,
       numero_factura,
       fecha_emision,
       fecha_vencimiento,
       importe_total,
       estado_cobro
FROM factura
WHERE estado_cobro IN ('Pendiente', 'Vencida', 'En_mora')
ORDER BY fecha_vencimiento;

-- Incidencias abiertas o en gestion
SELECT id_incidencia,
       id_servicio,
       tipo,
       prioridad,
       estado,
       fecha_apertura,
       responsable_gestion
FROM incidencia
WHERE estado IN ('Abierta', 'En_gestion')
ORDER BY prioridad DESC, fecha_apertura;

-- =============================================================================
-- Actividad 8 (capturas): ver entregables/capturas_consultas_basicas.md
-- =============================================================================
