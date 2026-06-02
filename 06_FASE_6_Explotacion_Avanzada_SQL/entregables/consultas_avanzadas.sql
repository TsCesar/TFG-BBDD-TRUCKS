-- =============================================================================
-- consultas_avanzadas.sql
-- FASE 6 - Explotacion Avanzada SQL
-- TFG: Gestion de empresa de transporte intracomunitario (UE)
-- Centro FP Maria Auxiliadora - 2 DAM - Curso 2024-26
-- Alumno: Cesar Mendez | Fecha: 2026-06-02
-- =============================================================================
-- Prerequisitos: schema.sql, alter_table.sql, datos_prueba.sql,
--                consultas_basicas.sql y trigger_auditoria.sql ya ejecutados.
-- =============================================================================

USE tfg_transporte_ue;

-- =============================================================================
-- ACTIVIDADES 1 + 2 -- Servicios con cliente, conductor y vehiculo asignados
-- Tablas: servicio, cliente, asignacion, conductor, vehiculo, remolque
-- JOINs: INNER JOIN cliente | LEFT JOIN asignacion, conductor, vehiculo, remolque
-- Cubre: actividades 1 y 2 del listado oficial FASE 6
-- =============================================================================

SELECT
    s.numero_servicio,
    s.tipo_servicio,
    s.nivel_urgencia,
    s.estado_actual,
    c.nombre_razon_social                      AS cliente,
    CONCAT(con.nombre, ' ', con.apellidos)     AS conductor,
    con.estado_disponibilidad                  AS estado_conductor,
    v.matricula                                AS vehiculo,
    v.tipo                                     AS tipo_vehiculo,
    r.matricula                                AS remolque
FROM servicio s
INNER JOIN cliente     c   ON s.id_cliente    = c.id_cliente
LEFT  JOIN asignacion  a   ON s.id_servicio   = a.id_servicio   AND a.es_activa = 1
LEFT  JOIN conductor   con ON a.id_conductor  = con.id_conductor
LEFT  JOIN vehiculo    v   ON a.id_vehiculo   = v.id_vehiculo
LEFT  JOIN remolque    r   ON a.id_remolque   = r.id_remolque
ORDER BY s.estado_actual, s.numero_servicio;

-- =============================================================================
-- ACTIVIDAD 3 -- Incidencias relacionadas con servicios
-- Tablas: incidencia, servicio, cliente
-- JOINs: INNER JOIN servicio, INNER JOIN cliente
-- Cubre: actividad 3 del listado oficial FASE 6
-- =============================================================================

SELECT
    s.numero_servicio,
    c.nombre_razon_social   AS cliente,
    i.tipo                  AS tipo_incidencia,
    i.prioridad,
    i.estado,
    i.fecha_apertura,
    i.responsable_gestion,
    i.genera_coste_adicional
FROM incidencia i
INNER JOIN servicio s ON i.id_servicio = s.id_servicio
INNER JOIN cliente  c ON s.id_cliente  = c.id_cliente
ORDER BY i.prioridad DESC, i.fecha_apertura;

-- =============================================================================
-- ACTIVIDAD 4 -- Costes totales por servicio y margen estimado
-- Tablas: servicio, cliente, coste_operativo, factura
-- JOINs: INNER JOIN cliente | LEFT JOIN coste_operativo, factura
-- Funciones: COUNT, SUM, COALESCE
-- Cubre: actividad 4 del listado oficial FASE 6
-- =============================================================================

SELECT
    s.numero_servicio,
    s.tipo_servicio,
    c.nombre_razon_social                                        AS cliente,
    COUNT(co.id_coste)                                           AS num_partidas_coste,
    COALESCE(SUM(co.importe), 0)                                 AS coste_total_eur,
    COALESCE(f.importe_base, 0)                                  AS ingreso_base_eur,
    COALESCE(f.importe_base, 0) - COALESCE(SUM(co.importe), 0)  AS margen_estimado_eur
FROM servicio s
INNER JOIN cliente         c  ON s.id_cliente  = c.id_cliente
LEFT  JOIN coste_operativo co ON s.id_servicio = co.id_servicio
LEFT  JOIN factura         f  ON s.id_factura  = f.id_factura
GROUP BY s.id_servicio, s.numero_servicio, s.tipo_servicio,
         c.nombre_razon_social, f.importe_base
ORDER BY coste_total_eur DESC;

-- =============================================================================
-- ACTIVIDAD 5 -- Facturacion por cliente y periodo (año 2026)
-- Tablas: factura, cliente
-- JOINs: INNER JOIN cliente
-- Funciones: COUNT, SUM, CASE WHEN, GROUP BY
-- Cubre: actividad 5 del listado oficial FASE 6
-- =============================================================================

SELECT
    c.nombre_razon_social                                               AS cliente,
    c.pais,
    COUNT(f.id_factura)                                                 AS num_facturas,
    SUM(f.importe_base)                                                 AS total_base_eur,
    SUM(f.importe_total)                                                AS total_con_iva_eur,
    SUM(CASE WHEN f.estado_cobro = 'Cobrada'
             THEN f.importe_total ELSE 0 END)                          AS cobrado_eur,
    SUM(CASE WHEN f.estado_cobro IN ('Pendiente', 'Vencida', 'En_mora')
             THEN f.importe_total ELSE 0 END)                          AS pendiente_eur
FROM factura f
INNER JOIN cliente c ON f.id_cliente = c.id_cliente
WHERE f.fecha_emision BETWEEN '2026-01-01' AND '2026-12-31'
GROUP BY c.id_cliente, c.nombre_razon_social, c.pais
ORDER BY total_con_iva_eur DESC;

-- =============================================================================
-- ACTIVIDAD 6a -- Servicios sin facturar (no cancelados, sin id_factura)
-- Tablas: servicio, cliente
-- JOINs: INNER JOIN cliente
-- Cubre: actividad 6 del listado oficial FASE 6
-- =============================================================================

SELECT
    s.numero_servicio,
    s.estado_actual,
    s.tipo_servicio,
    c.nombre_razon_social   AS cliente,
    s.fecha_prevista_recogida,
    s.documentacion_completa
FROM servicio s
INNER JOIN cliente c ON s.id_cliente = c.id_cliente
WHERE s.id_factura  IS NULL
  AND s.estado_actual NOT IN ('Cancelado', 'Pendiente')
ORDER BY s.estado_actual, s.fecha_prevista_recogida;

-- =============================================================================
-- ACTIVIDAD 6b -- Servicios con documentacion incompleta
-- Tablas: servicio, cliente
-- JOINs: INNER JOIN cliente
-- Cubre: actividad 6 del listado oficial FASE 6
-- =============================================================================

SELECT
    s.numero_servicio,
    s.estado_actual,
    c.nombre_razon_social   AS cliente,
    s.documentacion_completa
FROM servicio s
INNER JOIN cliente c ON s.id_cliente = c.id_cliente
WHERE s.documentacion_completa = 0
  AND s.estado_actual NOT IN ('Cancelado')
ORDER BY s.estado_actual;

-- =============================================================================
-- ACTIVIDAD 7a -- Documentos caducados (fecha_caducidad < hoy)
-- Tablas: documento_recurso, vehiculo, remolque, conductor
-- JOINs: LEFT JOIN vehiculo, remolque, conductor
-- Funciones: DATEDIFF, CURDATE, COALESCE, CASE WHEN
-- Cubre: actividad 7 del listado oficial FASE 6
-- =============================================================================

SELECT
    dr.id_documento_rec,
    dr.tipo_documento,
    dr.numero_documento,
    dr.fecha_caducidad,
    DATEDIFF(CURDATE(), dr.fecha_caducidad)            AS dias_vencido,
    COALESCE(v.matricula,
             r.matricula,
             CONCAT(con.nombre, ' ', con.apellidos))   AS recurso,
    CASE
        WHEN dr.id_vehiculo  IS NOT NULL THEN 'Vehiculo'
        WHEN dr.id_remolque  IS NOT NULL THEN 'Remolque'
        ELSE 'Conductor'
    END AS tipo_recurso
FROM documento_recurso dr
LEFT JOIN vehiculo  v   ON dr.id_vehiculo  = v.id_vehiculo
LEFT JOIN remolque  r   ON dr.id_remolque  = r.id_remolque
LEFT JOIN conductor con ON dr.id_conductor = con.id_conductor
WHERE dr.fecha_caducidad < CURDATE()
ORDER BY dr.fecha_caducidad;

-- =============================================================================
-- ACTIVIDAD 7b -- Documentos proximos a caducar (en los proximos 90 dias)
-- Tablas: documento_recurso, vehiculo, remolque, conductor
-- JOINs: LEFT JOIN vehiculo, remolque, conductor
-- Funciones: DATEDIFF, CURDATE, DATE_ADD, COALESCE, CASE WHEN
-- Cubre: actividad 7 del listado oficial FASE 6
-- =============================================================================

SELECT
    dr.id_documento_rec,
    dr.tipo_documento,
    dr.numero_documento,
    dr.fecha_caducidad,
    DATEDIFF(dr.fecha_caducidad, CURDATE())            AS dias_para_caducar,
    COALESCE(v.matricula,
             r.matricula,
             CONCAT(con.nombre, ' ', con.apellidos))   AS recurso,
    CASE
        WHEN dr.id_vehiculo  IS NOT NULL THEN 'Vehiculo'
        WHEN dr.id_remolque  IS NOT NULL THEN 'Remolque'
        ELSE 'Conductor'
    END AS tipo_recurso
FROM documento_recurso dr
LEFT JOIN vehiculo  v   ON dr.id_vehiculo  = v.id_vehiculo
LEFT JOIN remolque  r   ON dr.id_remolque  = r.id_remolque
LEFT JOIN conductor con ON dr.id_conductor = con.id_conductor
WHERE dr.fecha_caducidad BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 90 DAY)
ORDER BY dr.fecha_caducidad;

-- =============================================================================
-- ACTIVIDAD 8 -- El trigger se carga con trigger_auditoria.sql (separado)
-- ACTIVIDAD 9 -- Trazabilidad en relacion_requerimientos.md
-- =============================================================================

-- =============================================================================
-- CONSULTA RESUMEN -- Dashboard operativo: servicios activos agrupados por estado
-- Util para la pantalla de control del departamento de trafico
-- Tablas: servicio
-- Funciones: COUNT, CASE, GROUP BY, ORDER BY FIELD
-- =============================================================================

SELECT
    estado_actual,
    COUNT(*)                                                  AS num_servicios,
    COUNT(CASE WHEN documentacion_completa = 0 THEN 1 END)   AS doc_incompleta,
    COUNT(CASE WHEN id_factura IS NULL        THEN 1 END)     AS sin_factura
FROM servicio
WHERE estado_actual NOT IN ('Cancelado')
GROUP BY estado_actual
ORDER BY FIELD(estado_actual,
    'Pendiente', 'Planificado', 'Asignado', 'En_transito',
    'Con_incidencia', 'Entregado', 'Cerrado');

-- =============================================================================
-- Fin del script
-- Capturas: ver entregables/capturas_consultas_avanzadas.md
-- =============================================================================
