-- =============================================================================
-- datos_prueba.sql
-- FASE 4 - Diseno Fisico MySQL
-- Proyecto TFG: Gestion integral de empresa de transporte intracomunitario (UE)
-- Centro FP Maria Auxiliadora - 2 DAM - Curso 2024-26
-- Alumno: Cesar Mendez
-- Fecha: 2026-06-01
-- =============================================================================
-- NOTAS DE EJECUCION:
--   1. Ejecutar schema.sql primero, luego alter_table.sql, luego este script.
--   2. Los datos respetan el orden de FK declarado en schema.sql.
--   3. Datos ficticios pero realistas para transporte intracomunitario UE.
-- =============================================================================
-- ESCENARIO:
--   5 clientes (ES, DE, FR, PL, IT)
--   6 vehiculos (4 cabezas tractoras, 1 rigido, 1 en mantenimiento)
--   4 remolques (2 lona, 1 frigorifico, 1 caja cerrada)
--   6 conductores de distintas nacionalidades
--   8 servicios (FTL, LTL, Especial; varios estados y facturas)
-- =============================================================================

SET FOREIGN_KEY_CHECKS = 0;
USE tfg_transporte_ue;

-- =============================================================================
-- TABLA: cliente (5 registros)
-- =============================================================================
INSERT INTO cliente
    (id_cliente, nombre_razon_social, cif_nif, pais, ciudad, direccion_sede,
     telefono, email, condiciones_pago, activo, notas_internas)
VALUES
    (1, 'Industrias Textiles Lenz S.L.',   'B-28441029',      'España',  'Zaragoza', 'Av. de la Hispanidad 45, 50012',          '+34 976 441 200', 'logistica@lenz.es',               '30 dias fin de mes',      1, 'Cliente preferente sector textil. Historico desde 2019.'),
    (2, 'Pharma Distribution GmbH',         'DE298741003',     'Alemania','Munchen',  'Industriestrasse 82, 80339',              '+49 89 3214 8800','transport@pharmadist.de',         '60 dias fecha factura',   1, 'Requiere siempre CMR y registro temperatura. GDP obligatorio.'),
    (3, 'Boulangerie Du Nord SARL',          'FR75812034521',   'Francia', 'Lille',    'Rue des Moulins 12, 59800',               '+33 3 2045 1100', 'achats@boulangerie-nord.fr',      '45 dias fin de mes',      1, 'LTL habitual. Entregas en varios puntos de Belgica.'),
    (4, 'Auto Parts Poland Sp. z o.o.',      'PL9482736104',    'Polonia', 'Warszawa', 'Ul. Przemyslowa 48, 01-234 Warszawa',     '+48 22 800 4400', 'logistics@autoparts-pl.com',      '30 dias fecha factura',   1, 'Nuevo cliente 2026. Piezas de automovil para mercado iberico.'),
    (5, 'Elettronica Italiana S.r.l.',       'IT03471840219',   'Italia',  'Milano',   'Via Montenapoleone 8, 20121 Milano',      '+39 02 7654 9900','acquisti@elettronica-it.com',    '60 dias fin de mes',      1, 'Componentes electronicos de alto valor. Seguro adicional habitual.');

-- =============================================================================
-- TABLA: vehiculo (6 registros)
-- =============================================================================
INSERT INTO vehiculo
    (id_vehiculo, matricula, tipo, marca, modelo, anio_matriculacion,
     capacidad_carga_kg, estado_operativo)
VALUES
    (1, '4121-HKJ', 'Cabeza_tractora', 'Volvo',        'FH16 540',       2022, 26000.00, 'Asignado'),
    (2, '8834-KPL', 'Cabeza_tractora', 'Mercedes-Benz','Actros 1853',     2021, 26000.00, 'Asignado'),
    (3, '3345-BCN', 'Cabeza_tractora', 'Scania',        'R500',            2020, 26000.00, 'Disponible'),
    (4, '7712-MAD', 'Cabeza_tractora', 'DAF',           'XF480',           2023, 26000.00, 'Asignado'),
    (5, '9901-BIL', 'Cabeza_tractora', 'MAN',           'TGX 18.460',      2019, 24000.00, 'Mantenimiento'),
    (6, '2267-VAL', 'Rigido',          'Renault',       'T High 430',      2021, 18000.00, 'Disponible');

-- =============================================================================
-- TABLA: remolque (4 registros)
-- =============================================================================
INSERT INTO remolque
    (id_remolque, matricula, tipo, capacidad_carga_kg, longitud_m,
     apto_temperatura, estado_operativo)
VALUES
    (1, 'RE-2024-001', 'Lona',        24000.00, 13.60, 0, 'Asignado'),
    (2, 'RE-2024-002', 'Frigorifico', 22000.00, 13.60, 1, 'Asignado'),
    (3, 'RE-2023-015', 'Lona',        24000.00, 13.60, 0, 'Disponible'),
    (4, 'RE-2025-008', 'Caja_cerrada',20000.00, 13.60, 0, 'Asignado');

-- =============================================================================
-- TABLA: conductor (6 registros)
-- =============================================================================
INSERT INTO conductor
    (id_conductor, numero_empleado, nombre, apellidos, fecha_nacimiento,
     telefono, email, numero_permiso, estado_disponibilidad)
VALUES
    (1, 'EMP-0042', 'Carlos', 'Martinez Lopez',   '1985-03-14', '+34 655 100 200', 'c.martinez@transportes.eu', 'B-1985-ZGZ-7842',  'Asignado'),
    (2, 'EMP-0071', 'Ana',    'Garcia Ruiz',      '1990-11-08', '+34 655 100 210', 'a.garcia@transportes.eu',  'M-1990-MAD-3301',  'Asignado'),
    (3, 'EMP-0033', 'Pedro',  'Ramos Vega',       '1982-07-22', '+34 655 100 220', 'p.ramos@transportes.eu',   'P-1982-BCN-5522',  'Disponible'),
    (4, 'EMP-0088', 'Maria',  'Santos Ferreira',  '1988-05-14', '+351 96 234 5678','m.santos@transportes.eu',  'PT-1988-LIS-0088', 'Asignado'),
    (5, 'EMP-0055', 'Jan',    'Kowalski',         '1979-03-08', '+48 604 123 456', 'j.kowalski@transportes.eu','PL-1979-WAW-0055', 'Disponible'),
    (6, 'EMP-0097', 'Luigi',  'Moretti',          '1991-12-30', '+39 347 890 1234','l.moretti@transportes.eu', 'IT-1991-MIL-0097', 'Vacaciones');

-- =============================================================================
-- TABLA: categoria_permiso (6 registros)
-- =============================================================================
INSERT INTO categoria_permiso
    (id_categoria, codigo_categoria, descripcion, activa)
VALUES
    (1, 'C',   'Vehiculos de motor para transporte de mercancias con MMA > 3,5 t (camiones rigidos)', 1),
    (2, 'CE',  'Combinacion de vehiculo tractor con remolque cuya MMA supere los 3,5 t (articulado)', 1),
    (3, 'C1',  'Vehiculos de motor para transporte de mercancias con MMA entre 3,5 t y 7,5 t',        1),
    (4, 'C1E', 'Combinacion de C1 con remolque cuya MMA supere los 750 kg',                           1),
    (5, 'D',   'Vehiculos de motor para el transporte de personas con mas de 8 plazas',               1),
    (6, 'B+E', 'Conjunto formado por vehiculo clase B y remolque cuya MMA supere 750 kg',             1);

-- =============================================================================
-- TABLA: contacto (8 registros)
-- =============================================================================
INSERT INTO contacto
    (id_contacto, id_cliente, nombre, apellidos, cargo, telefono, email, es_principal)
VALUES
    (1, 1, 'Marta',    'Serrano Blanco',    'Responsable de Logistica', '+34 616 200 110', 'm.serrano@lenz.es',              1),
    (2, 1, 'Jordi',    'Puig Roca',         'Director de Compras',      '+34 616 200 120', 'j.puig@lenz.es',                 0),
    (3, 2, 'Klaus',    'Hoffmann',          'Supply Chain Manager',     '+49 173 4512 880','k.hoffmann@pharmadist.de',        1),
    (4, 3, 'Amelie',   'Renard',            'Responsable Achats',       '+33 6 7800 4412', 'a.renard@boulangerie-nord.fr',    1),
    (5, 4, 'Tomasz',   'Nowak',             'Dyrektor Logistyki',       '+48 600 123 456', 't.nowak@autoparts-pl.com',        1),
    (6, 4, 'Agnieszka','Wisniewska',        'Spedytor',                 '+48 600 234 567', 'a.wisniewska@autoparts-pl.com',   0),
    (7, 5, 'Marco',    'Ferretti',          'Responsabile Acquisti',    '+39 02 7654 9901','m.ferretti@elettronica-it.com',   1),
    (8, 5, 'Giulia',   'Ricci',             'Logistica e Trasporti',    '+39 02 7654 9902','g.ricci@elettronica-it.com',      0);

-- =============================================================================
-- TABLA: direccion_operativa (8 registros)
-- =============================================================================
INSERT INTO direccion_operativa
    (id_direccion, id_cliente, descripcion, direccion, ciudad, pais, telefono, horario, activa)
VALUES
    (1, 1, 'Almacen Central Zaragoza',        'Pol. Ind. Malpica, C/ Rio Ebro 8, 50016',             'Zaragoza',         'Espana',  '+34 976 441 201', 'L-V 07:00-20:00', 1),
    (2, 1, 'Planta de Produccion Barcelona',  'C/ Pallars 112, Nave 3, 08018',                        'Barcelona',        'Espana',  '+34 932 210 800', 'L-V 06:00-22:00', 1),
    (3, 2, 'Centro de Distribucion Munchen',  'Landsberger Str. 300, 80687',                          'Munchen',          'Alemania','+49 89 3214 8810','L-V 06:00-18:00', 1),
    (4, 3, 'Deposito Lille',                  'Zone Industrielle des Pres, Rue Lavoisier 5, 59650',   'Villeneuve d Ascq','Francia', '+33 3 2054 2200', 'L-S 05:00-14:00', 1),
    (5, 4, 'Centro Logistico Warszawa',       'Ul. Przemyslowa 48, 01-234',                           'Warszawa',         'Polonia', '+48 22 800 4401', 'L-V 06:00-20:00', 1),
    (6, 4, 'Almacen Barcelona Zona Franca',   'Carrer C 18, Zona Franca, 08004',                      'Barcelona',        'Espana',  '+34 934 310 200', 'L-V 07:00-19:00', 1),
    (7, 5, 'Sede y Almacen Milano',           'Via Montenapoleone 8, 20121',                          'Milano',           'Italia',  '+39 02 7654 9903','L-V 08:00-18:00', 1),
    (8, 5, 'Deposito Lyon',                   'Zone Industrielle Techlid Bat. B3, 69130',             'Ecully',           'Francia', '+33 4 7823 5500', 'L-V 07:00-17:00', 1);

-- =============================================================================
-- TABLA: factura (4 registros)
-- Debe crearse antes que servicio (servicio.id_factura FK nullable a factura)
-- =============================================================================
INSERT INTO factura
    (id_factura, id_cliente, numero_factura, fecha_emision, fecha_vencimiento,
     importe_base, porcentaje_iva, importe_total, estado_cobro, fecha_cobro, metodo_cobro)
VALUES
    (1, 1, 'FAC-2026-0001', '2026-04-10', '2026-05-10', 1450.00, 21.00, 1754.50, 'Cobrada',  '2026-05-08', 'Transferencia bancaria'),
    (2, 2, 'FAC-2026-0002', '2026-04-15', '2026-06-14', 2380.00,  0.00, 2380.00, 'Pendiente', NULL,         NULL),
    (3, 1, 'FAC-2026-0003', '2026-03-30', '2026-04-30', 1890.00, 21.00, 2286.90, 'Cobrada',  '2026-04-25', 'Transferencia bancaria'),
    (4, 3, 'FAC-2026-0004', '2026-05-05', '2026-05-05', 820.00,   0.00,  820.00, 'Vencida',   NULL,         NULL);

-- FAC-0002: IVA 0% por transporte intracomunitario (art. 9.1.c LIVA)
-- FAC-0004: IVA 0% por servicio intracomunitario FR->BE. Vencida por impago.

-- =============================================================================
-- TABLA: servicio (8 registros)
-- =============================================================================
INSERT INTO servicio
    (id_servicio, id_cliente, id_factura, numero_servicio, fecha_solicitud,
     fecha_prevista_recogida, tipo_servicio, nivel_urgencia, estado_actual,
     documentacion_completa, observaciones)
VALUES
    (1, 1, 1,    'SRV-2026-0001', '2026-03-28', '2026-04-01', 'FTL',     'Estandar',         'Cerrado',      1, 'Carga textil palet completo Zaragoza -> Munchen'),
    (2, 2, NULL, 'SRV-2026-0002', '2026-04-18', '2026-04-21', 'FTL',     'Urgente',          'En_transito',  0, 'Distribucion farmaceutica temperatura controlada Munchen -> Madrid'),
    (3, 3, 4,    'SRV-2026-0003', '2026-04-20', '2026-04-23', 'LTL',     'Estandar',         'Entregado',    1, 'Reparto alimentacion Lille -> Gante + Brujas'),
    (4, 4, NULL, 'SRV-2026-0004', '2026-05-10', '2026-05-15', 'FTL',     'Estandar',         'Planificado',  0, 'Piezas de automovil Warszawa -> Barcelona. Palets maquinaria ligera'),
    (5, 5, NULL, 'SRV-2026-0005', '2026-05-18', '2026-05-22', 'LTL',     'Urgente',          'Asignado',     0, 'Componentes electronicos Milano -> Lyon + Toulouse. Alto valor'),
    (6, 1, 3,    'SRV-2026-0006', '2026-03-05', '2026-03-10', 'FTL',     'Estandar',         'Cerrado',      1, 'Carga textil Zaragoza -> Bruselas. Segundo servicio Lenz Q1 2026'),
    (7, 4, NULL, 'SRV-2026-0007', '2026-05-28', '2026-06-05', 'Especial','Fecha_garantizada', 'Pendiente',   0, 'Maquinaria industrial sobredimensionada. Requiere autorizacion especial de transporte'),
    (8, 3, NULL, 'SRV-2026-0008', '2026-04-28', '2026-05-05', 'FTL',     'Estandar',         'Cancelado',    0, 'Servicio cancelado por el cliente. Retraso en produccion del almacen origen');

-- =============================================================================
-- TABLA: punto_servicio (17 registros)
-- =============================================================================
INSERT INTO punto_servicio
    (id_punto, id_servicio, id_direccion, tipo, orden, direccion, ciudad, pais,
     ventana_inicio, ventana_fin, fecha_ejecucion_real, estado, observaciones)
VALUES
    -- SRV-0001 (Zaragoza -> Munchen, Cerrado)
    (1,  1, 1,    'Recogida', 1, 'Pol. Ind. Malpica, C/ Rio Ebro 8, 50016',          'Zaragoza',          'Espana',   '2026-04-01 08:00', '2026-04-01 12:00', '2026-04-01 09:15', 'Completado', 'Acceso por puerta norte'),
    (2,  1, 3,    'Entrega',  2, 'Landsberger Str. 300, 80687',                       'Munchen',           'Alemania', '2026-04-03 07:00', '2026-04-03 15:00', '2026-04-03 11:40', 'Completado', 'Cita previa con Klaus Hoffmann'),
    -- SRV-0002 (Munchen -> Alcobendas, En_transito)
    (3,  2, 3,    'Recogida', 1, 'Landsberger Str. 300, 80687',                       'Munchen',           'Alemania', '2026-04-21 06:00', '2026-04-21 10:00', '2026-04-21 07:30', 'Completado', NULL),
    (4,  2, NULL, 'Entrega',  2, 'Av. de la Industria 40, Nave 12, 28108',            'Alcobendas',        'Espana',   '2026-04-23 07:00', '2026-04-23 14:00', NULL,               'Pendiente',  'Deposito FARMAD. Requiere identificacion conductor'),
    -- SRV-0003 (Lille -> Gante + Brujas, Entregado)
    (5,  3, 4,    'Recogida', 1, 'Zone Industrielle des Pres, Rue Lavoisier 5, 59650','Villeneuve d Ascq', 'Francia',  '2026-04-23 05:30', '2026-04-23 08:00', '2026-04-23 06:00', 'Completado', 'Carga antes del amanecer'),
    (6,  3, NULL, 'Entrega',  2, 'Rue de Gand 200, 9000',                             'Gante',             'Belgica',  '2026-04-23 13:00', '2026-04-23 16:00', '2026-04-23 14:20', 'Completado', NULL),
    (7,  3, NULL, 'Entrega',  3, 'Mariastraat 14, 8000',                              'Brujas',            'Belgica',  '2026-04-23 17:00', '2026-04-23 20:00', '2026-04-23 17:45', 'Completado', NULL),
    -- SRV-0004 (Warszawa -> Barcelona, Planificado)
    (8,  4, 5,    'Recogida', 1, 'Ul. Przemyslowa 48, 01-234',                        'Warszawa',          'Polonia',  '2026-05-15 07:00', '2026-05-15 12:00', NULL,               'Pendiente',  'Carga en muelle 3. Contactar con Agnieszka'),
    (9,  4, 6,    'Entrega',  2, 'Carrer C 18, Zona Franca, 08004',                   'Barcelona',         'Espana',   '2026-05-18 08:00', '2026-05-18 16:00', NULL,               'Pendiente',  NULL),
    -- SRV-0005 (Milano -> Lyon + Toulouse, Asignado)
    (10, 5, 7,    'Recogida', 1, 'Via Montenapoleone 8, 20121',                        'Milano',            'Italia',   '2026-05-22 08:00', '2026-05-22 12:00', '2026-05-22 09:10', 'Completado', NULL),
    (11, 5, 8,    'Entrega',  2, 'Zone Industrielle Techlid Bat. B3, 69130',           'Ecully',            'Francia',  '2026-05-23 10:00', '2026-05-23 15:00', NULL,               'En_proceso', NULL),
    (12, 5, NULL, 'Entrega',  3, 'Rue Jules Guesde 100, 31000',                        'Toulouse',          'Francia',  '2026-05-24 09:00', '2026-05-24 14:00', NULL,               'Pendiente',  'Destinatario: Composants du Midi SARL'),
    -- SRV-0006 (Zaragoza -> Bruselas, Cerrado)
    (13, 6, 1,    'Recogida', 1, 'Pol. Ind. Malpica, C/ Rio Ebro 8, 50016',           'Zaragoza',          'Espana',   '2026-03-10 08:00', '2026-03-10 12:00', '2026-03-10 09:30', 'Completado', 'Acceso por puerta norte. Mismo punto que SRV-0001'),
    (14, 6, NULL, 'Entrega',  2, 'Rue de Bruxelles 55, 1000',                          'Bruselas',          'Belgica',  '2026-03-12 07:00', '2026-03-12 16:00', '2026-03-12 13:00', 'Completado', 'Deposito central cliente final'),
    -- SRV-0007 (Maquinaria especial, Pendiente)
    (15, 7, 5,    'Recogida', 1, 'Ul. Przemyslowa 48, 01-234',                         'Warszawa',          'Polonia',  '2026-06-05 07:00', '2026-06-05 12:00', NULL,               'Pendiente',  'Carga especial: fresadora CNC. Requiere grua 20 t'),
    (16, 7, 3,    'Entrega',  2, 'Landsberger Str. 300, 80687',                        'Munchen',           'Alemania', '2026-06-08 08:00', '2026-06-08 17:00', NULL,               'Pendiente',  'Descarga solo con equipo especializado del destinatario'),
    -- SRV-0008 (Cancelado, no se ejecuto)
    (17, 8, 4,    'Recogida', 1, 'Zone Industrielle des Pres, Rue Lavoisier 5, 59650','Villeneuve d Ascq', 'Francia',  '2026-05-05 06:00', '2026-05-05 10:00', NULL,               'Pendiente',  'Cancelado antes de ejecucion');

-- =============================================================================
-- TABLA: evento_seguimiento (24 registros)
-- =============================================================================
INSERT INTO evento_seguimiento
    (id_evento, id_servicio, tipo_evento, descripcion, fecha_hora,
     estado_resultante, usuario_responsable, observaciones)
VALUES
    -- SRV-0001 (6 eventos: creado -> cerrado)
    (1,  1, 'Servicio_creado',      'Servicio SRV-2026-0001 creado por encargo de Lenz S.L.',                    '2026-03-28 10:05', 'Pendiente',   'trafico.garcia',    NULL),
    (2,  1, 'Planificado',          'Ruta planificada: Zaragoza -> Munchen. Distancia estimada 1.620 km',         '2026-03-29 09:30', 'Planificado', 'trafico.garcia',    NULL),
    (3,  1, 'Asignado',             'Asignados conductor C. Martinez y vehiculo 4121-HKJ con remolque RE-2024-001','2026-03-30 11:00','Asignado',   'trafico.garcia',    NULL),
    (4,  1, 'Recogida_completada',  'Recogida completada en almacen Zaragoza. 22 pales cargados',                 '2026-04-01 09:20', 'En_transito', 'conductor.martinez',NULL),
    (5,  1, 'Entrega_completada',   'Entrega completada en Munchen. Albaran firmado por K. Hoffmann',             '2026-04-03 11:45', 'Entregado',   'conductor.martinez',NULL),
    (6,  1, 'Cerrado',              'Servicio cerrado. Documentacion recibida. Listo para facturar',              '2026-04-05 08:00', 'Cerrado',     'trafico.garcia',    NULL),
    -- SRV-0002 (3 eventos: creado -> en transito)
    (7,  2, 'Servicio_creado',      'Servicio SRV-2026-0002 creado. Prioridad urgente: distribucion farmaceutica','2026-04-18 14:10', 'Pendiente',   'trafico.lopez',     NULL),
    (8,  2, 'Asignado',             'Primera asignacion: conductor P. Ramos, vehiculo 9901-BIL, remolque RE-2024-002','2026-04-19 09:00','Asignado','trafico.lopez',     'Vehiculo paso a mantenimiento. Se reasigno.'),
    (9,  2, 'Asignado',             'Reasignacion: conductor A. Garcia, vehiculo 8834-KPL, remolque RE-2024-002', '2026-04-20 08:00', 'Asignado',   'trafico.lopez',     NULL),
    (10, 2, 'Recogida_completada',  'Recogida completada en Munchen. 6 pales producto farmaceutico. Temp: -2 C',  '2026-04-21 07:35', 'En_transito', 'conductor.garcia',  NULL),
    -- SRV-0003 (3 eventos: creado -> entregado con incidencia)
    (11, 3, 'Servicio_creado',      'Servicio SRV-2026-0003 creado. LTL con 2 entregas en Belgica',              '2026-04-20 09:15', 'Pendiente',   'trafico.garcia',    NULL),
    (12, 3, 'Incidencia_registrada','Incidencia de acceso registrada en punto Villeneuve d Ascq',                 '2026-04-23 06:15', 'Con_incidencia','conductor.martinez',NULL),
    (13, 3, 'Entrega_completada',   'Ambas entregas completadas en Belgica. Documentacion entregada',             '2026-04-23 18:00', 'Entregado',   'conductor.martinez',NULL),
    -- SRV-0004 (2 eventos: creado -> planificado)
    (14, 4, 'Servicio_creado',      'Servicio SRV-2026-0004 creado. FTL Auto Parts Poland -> Barcelona',         '2026-05-10 11:00', 'Pendiente',   'trafico.garcia',    NULL),
    (15, 4, 'Planificado',          'Ruta planificada: Warszawa -> Barcelona. Distancia estimada 2.680 km',       '2026-05-12 10:00', 'Planificado', 'trafico.garcia',    NULL),
    -- SRV-0005 (2 eventos: creado -> asignado)
    (16, 5, 'Servicio_creado',      'Servicio SRV-2026-0005 creado. LTL componentes electronicos Milano -> FR',  '2026-05-18 14:30', 'Pendiente',   'trafico.lopez',     NULL),
    (17, 5, 'Asignado',             'Asignada conductora M. Santos, vehiculo 7712-MAD, remolque RE-2025-008',    '2026-05-20 09:00', 'Asignado',   'trafico.lopez',     NULL),
    -- SRV-0006 (5 eventos: creado -> cerrado)
    (18, 6, 'Servicio_creado',      'Servicio SRV-2026-0006 creado. FTL textil Zaragoza -> Bruselas',           '2026-03-05 09:00', 'Pendiente',   'trafico.garcia',    NULL),
    (19, 6, 'Asignado',             'Asignado conductor P. Ramos, vehiculo 3345-BCN, remolque RE-2023-015',      '2026-03-08 10:00', 'Asignado',   'trafico.garcia',    NULL),
    (20, 6, 'Recogida_completada',  'Recogida completada en Zaragoza. 18 pales ropa deportiva',                  '2026-03-10 09:30', 'En_transito', 'conductor.ramos',   NULL),
    (21, 6, 'Entrega_completada',   'Entrega completada en Bruselas. Albaran firmado',                           '2026-03-12 13:05', 'Entregado',   'conductor.ramos',   NULL),
    (22, 6, 'Cerrado',              'Servicio cerrado. Toda la documentacion recibida',                          '2026-03-15 08:00', 'Cerrado',     'trafico.garcia',    NULL),
    -- SRV-0007 (1 evento: creado)
    (23, 7, 'Servicio_creado',      'Servicio SRV-2026-0007 creado. Especial maquinaria sobredimensionada PL->DE','2026-05-28 10:00','Pendiente',  'trafico.garcia',    NULL),
    -- SRV-0008 (2 eventos: creado -> cancelado)
    (24, 8, 'Servicio_creado',      'Servicio SRV-2026-0008 creado. FTL alimentacion Lille -> destino BE',       '2026-04-28 09:00', 'Pendiente',   'trafico.garcia',    NULL);

-- =============================================================================
-- TABLA: mercancia (10 registros)
-- =============================================================================
INSERT INTO mercancia
    (id_mercancia, id_servicio, descripcion, tipo_carga, num_bultos_palets,
     peso_kg, volumen_m3, valor_declarado, observaciones)
VALUES
    (1,  1, 'Tejidos tecnicos y ropa confeccionada de temporada',              'Paletizada',       22,  14200.00, 52.800, 85000.00,  'Pales 120x80 cm, fleje y film retractil'),
    (2,  2, 'Medicamentos refrigerados: vacunas y biologicos',                 'Paletizada',        6,   3800.00, 12.600,420000.00,  'GDP compliant. Temperatura: -2 C a +8 C'),
    (3,  3, 'Harinas especiales y mezclas para panaderia (lote Gante)',         'Bultos',          220,   5500.00, 15.600, 12100.00,  'Sacos 25 kg. Mantener seco. Destino: Gante'),
    (4,  3, 'Ingredientes de pasteleria: azucar, levadura y mejorantes (lote Brujas)','Bultos',   120,   3000.00,  8.400,  6600.00,  'Sacos y cajas 20 kg. Mantener seco. Destino: Brujas'),
    (5,  4, 'Piezas de automovil: amortiguadores, filtros y kits de frenos',   'Paletizada',        8,   4200.00, 22.400, 65000.00,  'Pales europalets. Fragil: no apilar mas de 2 alturas'),
    (6,  5, 'Componentes electronicos PCB para sistemas de iluminacion',        'Bultos',          180,   1800.00, 12.600, 95000.00,  'Cajas blindadas antiestaticas. No exponer a humedad. Destino Lyon'),
    (7,  5, 'Modulos de control industrial PLC y variadores de frecuencia',     'Bultos',           60,    900.00,  5.400, 42000.00,  'Embalaje reforzado. Alto valor. Destino Toulouse'),
    (8,  6, 'Tejidos tecnicos lote 2: ropa deportiva temporada verano',         'Paletizada',       18,  11500.00, 43.200, 72000.00,  'Pales 120x80 cm'),
    (9,  7, 'Fresadora CNC industrial modelo XR-5000 sobredimensionada',        'Maquinaria',        1,   8500.00, 18.000,185000.00,  'Pieza unica. Dimensiones: 4,2 m x 2,8 m x 2,4 m. Carga especial'),
    (10, 8, 'Harina integral a granel para panaderia industrial',               'Granel',         NULL,  18000.00, 24.000,  9000.00,  'Servicio cancelado. Carga nunca realizada');

-- =============================================================================
-- TABLA: requisito_especial (5 registros)
-- =============================================================================
INSERT INTO requisito_especial
    (id_requisito, id_servicio, tipo, descripcion, temperatura_min, temperatura_max,
     instrucciones, verificacion_obligatoria)
VALUES
    (1, 2, 'Temperatura_controlada',  'Transporte de medicamentos refrigerados. Cadena de frio continua obligatoria', -2.0,  8.0, 'Verificar temperatura remolque antes de carga. Registrar cada 2 horas. Adjuntar grafico al CMR', 1),
    (2, 2, 'Documentacion_adicional', 'Requiere certificado GDP y hoja de datos de seguridad por partida',            NULL, NULL, 'Entregar documentacion al responsable antes de descarga. No aceptar sin firma de conformidad',      1),
    (3, 3, 'Restriccion_acceso',      'Acceso zona industrial Villeneuve d Ascq restringido a vehiculos < 3,5 m altura',NULL,NULL,'Acceso por Rue Lavoisier sentido oeste. Barrera automatica: codigo 4421',                          0),
    (4, 5, 'Seguro_adicional',        'Seguro adicional obligatorio para mercancias electronicas de alto valor',      NULL, NULL, 'Contratar cobertura adicional min 150.000 EUR. Adjuntar poliza al expediente',                       1),
    (5, 7, 'Documentacion_adicional', 'Requiere autorizacion especial de transporte por dimensiones excepcionales',   NULL, NULL, 'Solicitar autorizacion con min 15 dias de antelacion. Escolta obligatoria en tramos urbanos',          1);

-- =============================================================================
-- TABLA: incidencia (4 registros)
-- =============================================================================
INSERT INTO incidencia
    (id_incidencia, id_servicio, tipo, descripcion, fecha_apertura, prioridad,
     estado, fecha_ultima_actualizacion, responsable_gestion, fecha_cierre,
     descripcion_resolucion, genera_coste_adicional)
VALUES
    (1, 3, 'Problema_acceso',       'Barrera de acceso a zona industrial bloqueada por averia. Espera de 45 minutos',
     '2026-04-23 06:10', 'Baja',  'Cerrada',    '2026-04-23 07:00', 'trafico.garcia',   '2026-04-23 07:00', 'Personal del poligono reparo la barrera. No hubo perdida de ventana horaria', 0),
    (2, 2, 'Demora_significativa',  'Retraso en cruce de frontera francesa por control aduanero prolongado. Demora 3 horas',
     '2026-04-22 14:00', 'Alta', 'Abierta',     '2026-04-22 14:00', 'trafico.lopez',    NULL,               NULL,                                                                            0),
    (3, 4, 'Averia_vehiculo',       'Pinchazo de neumatico trasero en autopista A2 cercana a Lodz. Cambio en ruta',
     '2026-05-16 11:30', 'Media','Resuelta',    '2026-05-16 14:00', 'trafico.garcia',   NULL,               'Conductor cambio neumatico de repuesto. Retraso 2 h. Coste extra taller Lodz',  1),
    (4, 5, 'Problema_documentacion','Falta certificado de conformidad CE para componentes electronicos en aduana italiana',
     '2026-05-22 10:00', 'Alta', 'En_gestion',  '2026-05-22 10:00', 'trafico.lopez',    NULL,               NULL,                                                                            0);

-- =============================================================================
-- TABLA: asignacion (6 registros)
-- Incluye una reasignacion en SRV-0002 (vehiculo paso a mantenimiento)
-- =============================================================================
INSERT INTO asignacion
    (id_asignacion, id_servicio, id_conductor, id_vehiculo, id_remolque,
     fecha_asignacion, es_activa, motivo_cambio, observaciones)
VALUES
    (1, 1, 1, 1, 1, '2026-03-30 11:00', 0, 'Servicio completado; registro historico',                                      NULL),
    (2, 6, 3, 3, 3, '2026-03-08 10:00', 0, 'Servicio completado; registro historico',                                      NULL),
    (3, 3, 1, 1, 1, '2026-04-22 08:00', 1, NULL,                                                                            'LTL Belgica; conductor Carlos disponible tras cierre de SRV-0001'),
    (4, 2, 3, 5, 2, '2026-04-19 09:00', 0, 'Vehiculo 9901-BIL paso a mantenimiento preventivo urgente. Reasignado.',        'Primera asignacion sustituida'),
    (5, 2, 2, 2, 2, '2026-04-20 08:00', 1, NULL,                                                                            'Remolque frigorifico obligatorio por requisito GDP temperatura'),
    (6, 5, 4, 4, 4, '2026-05-20 09:00', 1, NULL,                                                                            'Caja cerrada adecuada para electronica de alto valor');

-- =============================================================================
-- TABLA: coste_operativo (16 registros)
-- =============================================================================
INSERT INTO coste_operativo
    (id_coste, id_servicio, tipo_coste, importe, fecha, descripcion, justificante_disponible)
VALUES
    -- SRV-0001
    (1,  1, 'Combustible',    380.00, '2026-04-01', 'Repostaje Zaragoza salida',                      1),
    (2,  1, 'Peajes',         142.50, '2026-04-02', 'Peajes AP-2 y autopistas francesas',             1),
    (3,  1, 'Combustible',    290.00, '2026-04-02', 'Repostaje Lyon trayecto',                        1),
    (4,  1, 'Dietas',          60.00, '2026-04-02', 'Dieta conductor noche en ruta',                  1),
    -- SRV-0002
    (5,  2, 'Combustible',    520.00, '2026-04-21', 'Repostaje Munchen inicio servicio urgente',      1),
    (6,  2, 'Peajes',          88.00, '2026-04-21', 'Peajes Austria - paso Brenner',                  1),
    (7,  2, 'Seguro_adicional',150.00,'2026-04-19', 'Prima seguro adicional transporte farmaceutico', 1),
    -- SRV-0003
    (8,  3, 'Combustible',    195.00, '2026-04-23', 'Repostaje Lille inicio LTL Belgica',             1),
    (9,  3, 'Peajes',          22.50, '2026-04-23', 'Vignette autopistas belgas',                     0),
    -- SRV-0004
    (10, 4, 'Combustible',    290.00, '2026-05-15', 'Repostaje pre-servicio deposito Warszawa',       1),
    (11, 4, 'Reparacion',     180.00, '2026-05-16', 'Cambio neumatico averia A2 cerca Lodz',          1),
    -- SRV-0005
    (12, 5, 'Combustible',    410.00, '2026-05-22', 'Repostaje Milano inicio servicio LTL',           1),
    (13, 5, 'Peajes',          65.00, '2026-05-22', 'Peajes A8 Italia y autopistas francesas',        1),
    -- SRV-0006
    (14, 6, 'Combustible',    350.00, '2026-03-10', 'Repostaje Zaragoza salida SRV-0006',             1),
    (15, 6, 'Peajes',         118.00, '2026-03-11', 'Peajes Francia + peaje autopistas belgicas',     1),
    (16, 6, 'Dietas',          60.00, '2026-03-11', 'Dieta conductor noche en ruta Bruselas',         1);

-- =============================================================================
-- TABLA: documento_servicio (12 registros)
-- =============================================================================
INSERT INTO documento_servicio
    (id_documento_srv, id_servicio, tipo_documento, descripcion, fecha_documento,
     recibido, fecha_recepcion, referencia_archivo)
VALUES
    -- SRV-0001
    (1,  1, 'CMR',              'Carta de Porte CMR firmada en origen (Zaragoza) y destino (Munchen)',    '2026-04-01', 1, '2026-04-07', '/docs/2026/SRV-0001/CMR-001.pdf'),
    (2,  1, 'Albaran_entrega',  'Albaran de entrega firmado por K. Hoffmann en Munchen',                  '2026-04-03', 1, '2026-04-07', '/docs/2026/SRV-0001/ALB-001.pdf'),
    -- SRV-0002
    (3,  2, 'CMR',              'Carta de Porte CMR firmada en origen Munchen. Pendiente firma destino',  '2026-04-21', 0, NULL,         NULL),
    (4,  2, 'Registro_temperatura','Registro de temperatura continua del remolque RE-2024-002',           '2026-04-21', 0, NULL,         NULL),
    -- SRV-0003
    (5,  3, 'CMR',              'Carta de Porte CMR LTL. Tres apartados: Lille, Gante y Brujas',          '2026-04-23', 1, '2026-04-24', '/docs/2026/SRV-0003/CMR-001.pdf'),
    (6,  3, 'Albaran_entrega',  'Albaran entrega Gante firmado',                                          '2026-04-23', 1, '2026-04-24', '/docs/2026/SRV-0003/ALB-001.pdf'),
    (7,  3, 'Albaran_entrega',  'Albaran entrega Brujas firmado',                                         '2026-04-23', 1, '2026-04-24', '/docs/2026/SRV-0003/ALB-002.pdf'),
    -- SRV-0004
    (8,  4, 'CMR',              'CMR preparado para SRV-0004. Pendiente de ejecucion',                    '2026-05-10', 0, NULL,         NULL),
    -- SRV-0005
    (9,  5, 'CMR',              'CMR LTL componentes electronicos. Pendiente firma origen',               '2026-05-18', 0, NULL,         NULL),
    -- SRV-0006
    (10, 6, 'CMR',              'Carta de Porte CMR Zaragoza -> Bruselas firmada ambos extremos',         '2026-03-10', 1, '2026-03-15', '/docs/2026/SRV-0006/CMR-001.pdf'),
    (11, 6, 'Albaran_entrega',  'Albaran entrega Bruselas firmado por destinatario',                      '2026-03-12', 1, '2026-03-15', '/docs/2026/SRV-0006/ALB-001.pdf'),
    -- SRV-0007
    (12, 7, 'Certificado',      'Solicitud autorizacion especial transporte sobredimensionado en tramite', '2026-05-28', 0, NULL,         NULL);

-- =============================================================================
-- TABLA: conductor_categoria_permiso (13 filas)
-- PK compuesta (id_conductor, id_categoria)
-- =============================================================================
INSERT INTO conductor_categoria_permiso
    (id_conductor, id_categoria, fecha_obtencion)
VALUES
    -- EMP-0042 Carlos Martinez: C + CE
    (1, 1, '2008-06-15'),
    (1, 2, '2010-03-22'),
    -- EMP-0071 Ana Garcia: C + CE
    (2, 1, '2014-09-10'),
    (2, 2, '2015-11-05'),
    -- EMP-0033 Pedro Ramos: C + CE + C1
    (3, 1, '2005-09-15'),
    (3, 2, '2007-04-12'),
    (3, 3, '2004-06-22'),
    -- EMP-0088 Maria Santos: C + CE
    (4, 1, '2012-07-18'),
    (4, 2, '2014-02-25'),
    -- EMP-0055 Jan Kowalski: C + CE
    (5, 1, '2002-11-30'),
    (5, 2, '2005-06-14'),
    -- EMP-0097 Luigi Moretti: C + CE
    (6, 1, '2016-10-05'),
    (6, 2, '2018-03-19');

-- =============================================================================
-- TABLA: documento_recurso (35 registros)
-- CHECK garantiza que exactamente una FK sea NOT NULL en cada fila.
-- Se incluyen documentos vencidos y proximos a vencer para demostrar RF-028.
-- =============================================================================
INSERT INTO documento_recurso
    (id_documento_rec, id_vehiculo, id_remolque, id_conductor,
     tipo_documento, numero_documento, fecha_emision, fecha_caducidad,
     organismo_emisor, referencia_archivo)
VALUES
    -- VEHICULO 1 (4121-HKJ Volvo FH16)
    (1,  1, NULL, NULL, 'ITV',                  'ITV-2024-ZGZ-41100', '2024-10-15', '2026-10-15', 'Estacion ITV Zaragoza Norte',          '/docs/vehiculos/4121-HKJ/ITV-2024.pdf'),
    (2,  1, NULL, NULL, 'Seguro',               'POL-2025-ZGZ-8821',  '2025-01-01', '2026-12-31', 'Mapfre Transporte',                     '/docs/vehiculos/4121-HKJ/SEGURO-2025.pdf'),
    (3,  1, NULL, NULL, 'Tacografo_calibracion','TAC-2023-ZGZ-0042',  '2023-07-10', '2025-07-10', 'Taller Autorizado VDO Zaragoza',        '/docs/vehiculos/4121-HKJ/TAC-2023.pdf'),
    -- VEHICULO 2 (8834-KPL Mercedes Actros)
    (4,  2, NULL, NULL, 'ITV',                  'ITV-2025-MAD-72200', '2025-03-20', '2027-03-20', 'Estacion ITV Madrid Sur',               '/docs/vehiculos/8834-KPL/ITV-2025.pdf'),
    (5,  2, NULL, NULL, 'Seguro',               'POL-2025-MAD-3310',  '2025-01-01', '2026-12-31', 'Allianz Fleet',                         '/docs/vehiculos/8834-KPL/SEGURO-2025.pdf'),
    -- VEHICULO 3 (3345-BCN Scania R500)
    (6,  3, NULL, NULL, 'ITV',                  'ITV-2024-BCN-33450', '2024-08-22', '2026-08-22', 'ITV Barcelona Norte',                   '/docs/vehiculos/3345-BCN/ITV-2024.pdf'),
    (7,  3, NULL, NULL, 'Seguro',               'POL-2025-BCN-9910',  '2025-01-01', '2026-12-31', 'Generali Transporte',                   '/docs/vehiculos/3345-BCN/SEGURO-2025.pdf'),
    (8,  3, NULL, NULL, 'Permiso_circulacion',  'PC-2020-BCN-33450',  '2020-05-10', '2030-05-10', 'DGT Cataluna',                          '/docs/vehiculos/3345-BCN/PC-2020.pdf'),
    -- VEHICULO 4 (7712-MAD DAF XF480)
    (9,  4, NULL, NULL, 'ITV',                  'ITV-2025-MAD-77120', '2025-10-05', '2027-10-05', 'Estacion ITV Madrid Norte',             '/docs/vehiculos/7712-MAD/ITV-2025.pdf'),
    (10, 4, NULL, NULL, 'Seguro',               'POL-2025-MAD-7712',  '2025-01-01', '2026-12-31', 'AXA Fleet Spain',                       '/docs/vehiculos/7712-MAD/SEGURO-2025.pdf'),
    -- VEHICULO 5 (9901-BIL MAN TGX - en mantenimiento)
    (11, 5, NULL, NULL, 'ITV',                  'ITV-2024-BIL-99010', '2024-06-15', '2026-06-15', 'Estacion ITV Bilbao Este',              '/docs/vehiculos/9901-BIL/ITV-2024.pdf'),
    (12, 5, NULL, NULL, 'Seguro',               'POL-2025-BIL-9901',  '2025-01-01', '2026-12-31', 'Zurich Fleet',                          '/docs/vehiculos/9901-BIL/SEGURO-2025.pdf'),
    -- VEHICULO 6 (2267-VAL Renault T High)
    (13, 6, NULL, NULL, 'ITV',                  'ITV-2025-VAL-22670', '2025-04-20', '2027-04-20', 'Estacion ITV Valencia Centro',          '/docs/vehiculos/2267-VAL/ITV-2025.pdf'),
    -- REMOLQUE 1 (RE-2024-001 Lona)
    (14, NULL, 1, NULL, 'ITV',                  'ITV-2024-ZGZ-41101', '2024-10-15', '2026-10-15', 'Estacion ITV Zaragoza Norte',           '/docs/remolques/RE-2024-001/ITV-2024.pdf'),
    (15, NULL, 1, NULL, 'Seguro',               'POL-2025-ZGZ-8822',  '2025-01-01', '2026-12-31', 'Mapfre Transporte',                     '/docs/remolques/RE-2024-001/SEGURO-2025.pdf'),
    -- REMOLQUE 2 (RE-2024-002 Frigorifico)
    (16, NULL, 2, NULL, 'ITV',                  'ITV-2025-MAD-72201', '2025-03-20', '2027-03-20', 'Estacion ITV Madrid Sur',               '/docs/remolques/RE-2024-002/ITV-2025.pdf'),
    (17, NULL, 2, NULL, 'Tacografo_calibracion','TAC-2024-MAD-0080',  '2024-09-05', '2026-09-05', 'Taller Autorizado Stoneridge Madrid',   '/docs/remolques/RE-2024-002/TAC-2024.pdf'),
    -- REMOLQUE 3 (RE-2023-015 Lona)
    (18, NULL, 3, NULL, 'ITV',                  'ITV-2023-ZGZ-41102', '2023-11-08', '2025-11-08', 'Estacion ITV Zaragoza Norte',           '/docs/remolques/RE-2023-015/ITV-2023.pdf'),
    (19, NULL, 3, NULL, 'Seguro',               'POL-2024-ZGZ-8823',  '2024-01-01', '2026-12-31', 'Mapfre Transporte',                     '/docs/remolques/RE-2023-015/SEGURO-2024.pdf'),
    -- REMOLQUE 4 (RE-2025-008 Caja cerrada)
    (20, NULL, 4, NULL, 'ITV',                  'ITV-2025-MAD-72202', '2025-07-14', '2027-07-14', 'Estacion ITV Madrid Sur',               '/docs/remolques/RE-2025-008/ITV-2025.pdf'),
    -- CONDUCTOR 1 (EMP-0042 Carlos Martinez)
    (21, NULL, NULL, 1, 'Permiso_conducir',     'B-1985-ZGZ-7842',    '2015-06-20', '2025-06-20', 'DGT Zaragoza',                          '/docs/conductores/EMP-0042/PERMISO.pdf'),
    (22, NULL, NULL, 1, 'CAP',                  'CAP-ZGZ-0042',       '2021-09-10', '2026-09-10', 'Centro Formacion CETM',                 '/docs/conductores/EMP-0042/CAP-2021.pdf'),
    (23, NULL, NULL, 1, 'Tarjeta_tacografo',    'TT-ES-042-2019',     '2019-04-01', '2024-04-01', 'DGT Jefatura Trafico Aragon',           '/docs/conductores/EMP-0042/TT-2019.pdf'),
    -- CONDUCTOR 2 (EMP-0071 Ana Garcia)
    (24, NULL, NULL, 2, 'Permiso_conducir',     'M-1990-MAD-3301',    '2020-11-15', '2025-11-15', 'DGT Madrid',                            '/docs/conductores/EMP-0071/PERMISO.pdf'),
    (25, NULL, NULL, 2, 'CAP',                  'CAP-MAD-0071',       '2022-03-22', '2027-03-22', 'Centro Formacion ASTIC',                '/docs/conductores/EMP-0071/CAP-2022.pdf'),
    (26, NULL, NULL, 2, 'Tarjeta_tacografo',    'TT-ES-071-2022',     '2022-08-15', '2027-08-15', 'DGT Jefatura Trafico Madrid',           '/docs/conductores/EMP-0071/TT-2022.pdf'),
    -- CONDUCTOR 3 (EMP-0033 Pedro Ramos)
    (27, NULL, NULL, 3, 'Permiso_conducir',     'P-1982-BCN-5522',    '2022-01-20', '2027-01-20', 'DGT Barcelona',                         '/docs/conductores/EMP-0033/PERMISO.pdf'),
    (28, NULL, NULL, 3, 'CAP',                  'CAP-BCN-0033',       '2020-05-10', '2025-05-10', 'Centro Formacion CETM Cataluna',        '/docs/conductores/EMP-0033/CAP-2020.pdf'),
    (29, NULL, NULL, 3, 'Tarjeta_tacografo',    'TT-ES-033-2021',     '2021-07-01', '2026-07-01', 'DGT Cataluna',                          '/docs/conductores/EMP-0033/TT-2021.pdf'),
    -- CONDUCTOR 4 (EMP-0088 Maria Santos)
    (30, NULL, NULL, 4, 'Permiso_conducir',     'PT-1988-LIS-0088',   '2023-06-15', '2028-06-15', 'IMT Lisboa',                            '/docs/conductores/EMP-0088/PERMISO.pdf'),
    (31, NULL, NULL, 4, 'CAP',                  'CAP-PT-0088',        '2023-02-10', '2028-02-10', 'Centro Formacao Transportes Portugal',  '/docs/conductores/EMP-0088/CAP-2023.pdf'),
    -- CONDUCTOR 5 (EMP-0055 Jan Kowalski)
    (32, NULL, NULL, 5, 'Permiso_conducir',     'PL-1979-WAW-0055',   '2021-04-22', '2026-04-22', 'Urzad Marszalkowski Mazowieckie',       '/docs/conductores/EMP-0055/PERMISO.pdf'),
    (33, NULL, NULL, 5, 'CAP',                  'CAP-PL-0055',        '2022-08-30', '2027-08-30', 'ZRIP Warszawa',                         '/docs/conductores/EMP-0055/CAP-2022.pdf'),
    -- CONDUCTOR 6 (EMP-0097 Luigi Moretti)
    (34, NULL, NULL, 6, 'Permiso_conducir',     'IT-1991-MIL-0097',   '2024-01-10', '2034-01-10', 'Motorizzazione Civile Milano',          '/docs/conductores/EMP-0097/PERMISO.pdf'),
    (35, NULL, NULL, 6, 'CAP',                  'CAP-IT-0097',        '2023-05-20', '2028-05-20', 'ANITA Formazione',                      '/docs/conductores/EMP-0097/CAP-2023.pdf');

-- Documentos vencidos o proximos a vencer (util para consultas FASE 5):
-- id=3  (TAC calibracion veh1): caducidad 2025-07-10 -- VENCIDO
-- id=11 (ITV veh5 MAN):         caducidad 2026-06-15 -- vence en 14 dias
-- id=18 (ITV rem3):             caducidad 2025-11-08 -- VENCIDO
-- id=21 (Permiso cond1):        caducidad 2025-06-20 -- VENCIDO
-- id=23 (TT cond1):             caducidad 2024-04-01 -- VENCIDO
-- id=24 (Permiso cond2):        caducidad 2025-11-15 -- VENCIDO
-- id=28 (CAP cond3):            caducidad 2025-05-10 -- VENCIDO
-- id=32 (Permiso cond5):        caducidad 2026-04-22 -- VENCIDO
-- id=6  (ITV veh3):             caducidad 2026-08-22 -- vence en ~2 meses

-- =============================================================================
-- TABLA: registro_auditoria (18 registros)
-- Sin FK directas. Referencias por nombre de entidad + PK del registro.
-- Se inserta al final porque registra operaciones sobre otras entidades.
-- =============================================================================
INSERT INTO registro_auditoria
    (id_auditoria, tipo_operacion, entidad_afectada, id_registro_afectado,
     usuario, fecha_hora, descripcion)
VALUES
    -- Ciclo de vida SRV-0001
    (1,  'Crear',         'servicio',   1, 'trafico.garcia',   '2026-03-28 10:05', 'Creacion del servicio SRV-2026-0001 para cliente id=1'),
    (2,  'Cambio_estado', 'servicio',   1, 'trafico.garcia',   '2026-03-29 09:30', 'Estado: Pendiente -> Planificado'),
    (3,  'Asignar',       'asignacion', 1, 'trafico.garcia',   '2026-03-30 11:00', 'Asignacion id=1 creada: conductor 1, vehiculo 1, remolque 1 -> servicio 1'),
    (4,  'Cambio_estado', 'servicio',   1, 'conductor.martinez','2026-04-01 09:20','Estado: Asignado -> En_transito (recogida completada)'),
    (5,  'Cambio_estado', 'servicio',   1, 'conductor.martinez','2026-04-03 11:45','Estado: En_transito -> Entregado'),
    (6,  'Cambio_estado', 'servicio',   1, 'trafico.garcia',   '2026-04-05 08:00', 'Estado: Entregado -> Cerrado'),
    (7,  'Facturar',      'factura',    1, 'admin.finanzas',   '2026-04-10 09:00', 'Factura FAC-2026-0001 emitida. Servicios: id=1. Importe: 1.754,50 EUR'),
    (8,  'Cobrar',        'factura',    1, 'admin.finanzas',   '2026-05-08 10:30', 'Cobro registrado FAC-2026-0001. Metodo: Transferencia bancaria. Estado: Cobrada'),
    -- Ciclo de vida SRV-0002
    (9,  'Crear',         'servicio',   2, 'trafico.lopez',    '2026-04-18 14:10', 'Creacion del servicio SRV-2026-0002 para cliente id=2. Urgente'),
    (10, 'Asignar',       'asignacion', 4, 'trafico.lopez',    '2026-04-19 09:00', 'Asignacion id=4 creada (luego sustituida): conductor 3, vehiculo 5, remolque 2'),
    (11, 'Asignar',       'asignacion', 5, 'trafico.lopez',    '2026-04-20 08:00', 'Reasignacion id=5: conductor 2, vehiculo 2, remolque 2. Motivo: MAN a mantenimiento'),
    (12, 'Cambio_estado', 'servicio',   2, 'conductor.garcia', '2026-04-21 07:35', 'Estado: Asignado -> En_transito (recogida completada Munchen)'),
    -- Ciclo SRV-0003
    (13, 'Crear',         'incidencia', 1, 'conductor.martinez','2026-04-23 06:10','Incidencia de acceso aperturada en SRV-2026-0003. Prioridad: Baja'),
    (14, 'Cambio_estado', 'incidencia', 1, 'trafico.garcia',   '2026-04-23 07:00', 'Incidencia id=1 cerrada. Resolucion documentada'),
    -- SRV-0006 (marzo)
    (15, 'Crear',         'servicio',   6, 'trafico.garcia',   '2026-03-05 09:00', 'Creacion del servicio SRV-2026-0006 para cliente id=1'),
    (16, 'Cambio_estado', 'servicio',   6, 'trafico.garcia',   '2026-03-15 08:00', 'Estado: Entregado -> Cerrado'),
    (17, 'Facturar',      'factura',    3, 'admin.finanzas',   '2026-03-30 10:00', 'Factura FAC-2026-0003 emitida. Servicios: id=6. Importe: 2.286,90 EUR'),
    (18, 'Cobrar',        'factura',    3, 'admin.finanzas',   '2026-04-25 11:00', 'Cobro registrado FAC-2026-0003. Metodo: Transferencia bancaria. Estado: Cobrada');

SET FOREIGN_KEY_CHECKS = 1;

-- =============================================================================
-- Fin del script
-- Total de registros insertados por tabla:
--   cliente: 5 | vehiculo: 6 | remolque: 4 | conductor: 6
--   categoria_permiso: 6 | contacto: 8 | direccion_operativa: 8
--   factura: 4 | servicio: 8 | punto_servicio: 17
--   evento_seguimiento: 24 | mercancia: 10 | requisito_especial: 5
--   incidencia: 4 | asignacion: 6 | coste_operativo: 16
--   documento_servicio: 12 | conductor_categoria_permiso: 13
--   documento_recurso: 35 | registro_auditoria: 18
-- =============================================================================
