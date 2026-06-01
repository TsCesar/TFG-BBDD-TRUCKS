-- =============================================================================
-- schema.sql
-- FASE 4 - Disenyo Fisico MySQL
-- Proyecto TFG: Gestion integral de empresa de transporte intracomunitario (UE)
-- Centro FP Maria Auxiliadora - 2 DAM - Curso 2024-26
-- Alumno: Cesar Mendez
-- Fecha: 2026-06-01
-- =============================================================================
-- NOTAS DE EJECUCION:
--   1. Ejecutar este script sobre un servidor MySQL 8.x limpio.
--   2. Si la BD ya existe, los DROP TABLE eliminaran las tablas en orden inverso.
--   3. Ejecutar despues: alter_table.sql, luego datos_prueba.sql.
-- =============================================================================

SET FOREIGN_KEY_CHECKS = 0;

-- -----------------------------------------------------------------------------
-- Base de datos
-- -----------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS tfg_transporte_ue
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE tfg_transporte_ue;

-- -----------------------------------------------------------------------------
-- DROP TABLE en orden inverso de creacion (respeta dependencias FK)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS registro_auditoria;
DROP TABLE IF EXISTS documento_recurso;
DROP TABLE IF EXISTS conductor_categoria_permiso;
DROP TABLE IF EXISTS asignacion;
DROP TABLE IF EXISTS documento_servicio;
DROP TABLE IF EXISTS coste_operativo;
DROP TABLE IF EXISTS incidencia;
DROP TABLE IF EXISTS requisito_especial;
DROP TABLE IF EXISTS mercancia;
DROP TABLE IF EXISTS evento_seguimiento;
DROP TABLE IF EXISTS punto_servicio;
DROP TABLE IF EXISTS servicio;
DROP TABLE IF EXISTS factura;
DROP TABLE IF EXISTS direccion_operativa;
DROP TABLE IF EXISTS contacto;
DROP TABLE IF EXISTS categoria_permiso;
DROP TABLE IF EXISTS conductor;
DROP TABLE IF EXISTS remolque;
DROP TABLE IF EXISTS vehiculo;
DROP TABLE IF EXISTS cliente;

-- =============================================================================
-- TABLA 1 - registro_auditoria
-- Sin FKs directas. Entidad transversal que registra operaciones sobre el sistema.
-- Se crea primero porque no tiene dependencias.
-- =============================================================================
CREATE TABLE registro_auditoria (
    id_auditoria          INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    tipo_operacion        ENUM('Crear','Modificar','Eliminar','Cambio_estado','Asignar','Facturar','Cobrar') NOT NULL COMMENT 'Tipo de operacion realizada',
    entidad_afectada      VARCHAR(60)     NOT NULL COMMENT 'Nombre de la tabla sobre la que se realizo la operacion',
    id_registro_afectado  INT UNSIGNED    NOT NULL COMMENT 'PK del registro afectado',
    fecha_hora            DATETIME        NOT NULL COMMENT 'Fecha y hora exacta de la operacion',
    usuario               VARCHAR(100)    NOT NULL COMMENT 'Usuario que realizo la operacion',
    descripcion           TEXT            NULL     COMMENT 'Descripcion del cambio; valores anteriores y nuevos si aplica',
    PRIMARY KEY (id_auditoria)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Registro de operaciones criticas para trazabilidad y control interno';

-- =============================================================================
-- TABLA 2 - cliente
-- Sin FKs externas. Entidad raiz del modelo.
-- =============================================================================
CREATE TABLE cliente (
    id_cliente            INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    nombre_razon_social   VARCHAR(200)    NOT NULL COMMENT 'Nombre completo o razon social',
    cif_nif               VARCHAR(20)     NOT NULL COMMENT 'Identificador fiscal; unico a nivel global',
    pais                  VARCHAR(60)     NOT NULL COMMENT 'Pais de registro o sede principal',
    ciudad                VARCHAR(100)    NULL     COMMENT 'Ciudad de la sede principal',
    direccion_sede        VARCHAR(250)    NULL     COMMENT 'Direccion postal de la sede principal',
    telefono              VARCHAR(30)     NULL     COMMENT 'Telefono de contacto principal',
    email                 VARCHAR(150)    NULL     COMMENT 'Correo electronico de contacto principal',
    condiciones_pago      VARCHAR(100)    NULL     COMMENT 'Plazo y forma de pago acordados',
    activo                TINYINT(1)      NOT NULL DEFAULT 1 COMMENT '1=activo, 0=inactivo',
    notas_internas        TEXT            NULL     COMMENT 'Notas internas de uso comercial o administrativo',
    PRIMARY KEY (id_cliente),
    UNIQUE KEY uq_cliente_cif_nif (cif_nif)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Empresas o personas que contratan servicios de transporte';

-- =============================================================================
-- TABLA 3 - vehiculo
-- Sin FKs externas. Recurso de flota propia.
-- =============================================================================
CREATE TABLE vehiculo (
    id_vehiculo           INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    matricula             VARCHAR(15)     NOT NULL COMMENT 'Matricula oficial del vehiculo',
    tipo                  ENUM('Cabeza_tractora','Rigido') NOT NULL COMMENT 'Tipo de vehiculo',
    marca                 VARCHAR(60)     NULL     COMMENT 'Marca del fabricante',
    modelo                VARCHAR(80)     NULL     COMMENT 'Modelo especifico',
    anio_matriculacion    SMALLINT UNSIGNED NULL   COMMENT 'Anyo de matriculacion',
    capacidad_carga_kg    DECIMAL(10,2)   NULL     COMMENT 'Capacidad maxima de carga en kilogramos',
    estado_operativo      ENUM('Disponible','Asignado','Mantenimiento','Baja') NOT NULL COMMENT 'Estado operativo actual',
    PRIMARY KEY (id_vehiculo),
    UNIQUE KEY uq_vehiculo_matricula (matricula)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Unidades de motor de la flota: cabezas tractoras y rigidos';

-- =============================================================================
-- TABLA 4 - remolque
-- Sin FKs externas. Elemento de carga acoplable a tractoras.
-- =============================================================================
CREATE TABLE remolque (
    id_remolque           INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    matricula             VARCHAR(15)     NOT NULL COMMENT 'Matricula oficial del remolque',
    tipo                  ENUM('Lona','Frigorifico','Cisterna','Portacoches','Caja_cerrada','Otro') NOT NULL,
    capacidad_carga_kg    DECIMAL(10,2)   NULL     COMMENT 'Capacidad maxima de carga en kilogramos',
    longitud_m            DECIMAL(5,2)    NULL     COMMENT 'Longitud del remolque en metros',
    apto_temperatura      TINYINT(1)      NULL     COMMENT '1=apto control temperatura, 0=no apto',
    estado_operativo      ENUM('Disponible','Asignado','Mantenimiento','Baja') NOT NULL,
    PRIMARY KEY (id_remolque),
    UNIQUE KEY uq_remolque_matricula (matricula)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Elementos de carga acoplables a las cabezas tractoras';

-- =============================================================================
-- TABLA 5 - conductor
-- Sin FKs directas. Las categorias de permiso se gestionan en tabla N:M.
-- =============================================================================
CREATE TABLE conductor (
    id_conductor          INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    numero_empleado       VARCHAR(20)     NOT NULL COMMENT 'Numero de empleado interno; unico',
    nombre                VARCHAR(100)    NOT NULL COMMENT 'Nombre del conductor',
    apellidos             VARCHAR(150)    NOT NULL COMMENT 'Apellidos del conductor',
    fecha_nacimiento      DATE            NULL     COMMENT 'Fecha de nacimiento',
    telefono              VARCHAR(30)     NULL     COMMENT 'Telefono de contacto',
    email                 VARCHAR(150)    NULL     COMMENT 'Correo electronico',
    numero_permiso        VARCHAR(30)     NOT NULL COMMENT 'Numero del permiso de conducir; unico',
    estado_disponibilidad ENUM('Disponible','Asignado','Vacaciones','Baja_temporal','Baja_definitiva') NOT NULL,
    PRIMARY KEY (id_conductor),
    UNIQUE KEY uq_conductor_numero_empleado (numero_empleado),
    UNIQUE KEY uq_conductor_numero_permiso (numero_permiso)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Conductores profesionales de la plantilla';

-- =============================================================================
-- TABLA 6 - categoria_permiso
-- Sin FKs externas. Tabla catalogo de categorias habilitantes.
-- =============================================================================
CREATE TABLE categoria_permiso (
    id_categoria          INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    codigo_categoria      VARCHAR(10)     NOT NULL COMMENT 'Codigo oficial: C, CE, C1, C1E, D, etc.',
    descripcion           VARCHAR(250)    NOT NULL COMMENT 'Descripcion del tipo de habilitacion',
    activa                TINYINT(1)      NOT NULL DEFAULT 1 COMMENT '1=vigente, 0=retirada',
    PRIMARY KEY (id_categoria),
    UNIQUE KEY uq_categoria_codigo (codigo_categoria)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Catalogo de categorias de permiso de conducir habilitantes';

-- =============================================================================
-- TABLA 7 - contacto
-- FK: id_cliente -> cliente (NOT NULL)
-- =============================================================================
CREATE TABLE contacto (
    id_contacto           INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    id_cliente            INT UNSIGNED    NOT NULL COMMENT 'FK: cliente al que pertenece',
    nombre                VARCHAR(100)    NOT NULL,
    apellidos             VARCHAR(150)    NOT NULL,
    cargo                 VARCHAR(100)    NULL     COMMENT 'Cargo o puesto en la empresa cliente',
    telefono              VARCHAR(30)     NULL,
    email                 VARCHAR(150)    NULL,
    es_principal          TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '1=contacto principal del cliente',
    PRIMARY KEY (id_contacto),
    CONSTRAINT fk_contacto_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Personas fisicas de las empresas cliente con las que se trabaja';

-- =============================================================================
-- TABLA 8 - direccion_operativa
-- FK: id_cliente -> cliente (NOT NULL)
-- =============================================================================
CREATE TABLE direccion_operativa (
    id_direccion          INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    id_cliente            INT UNSIGNED    NOT NULL COMMENT 'FK: cliente propietario de la instalacion',
    descripcion           VARCHAR(150)    NULL     COMMENT 'Nombre o denominacion de la instalacion',
    direccion             VARCHAR(250)    NOT NULL COMMENT 'Calle, numero y codigo postal',
    ciudad                VARCHAR(100)    NOT NULL,
    pais                  VARCHAR(60)     NOT NULL,
    telefono              VARCHAR(30)     NULL,
    horario               VARCHAR(100)    NULL     COMMENT 'Horario habitual de carga y descarga',
    activa                TINYINT(1)      NOT NULL DEFAULT 1 COMMENT '1=operativa, 0=cerrada',
    PRIMARY KEY (id_direccion),
    CONSTRAINT fk_direccion_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Ubicaciones fisicas desde las que opera un cliente';

-- =============================================================================
-- TABLA 9 - factura
-- FK: id_cliente -> cliente (NOT NULL)
-- No tiene FK a servicio: es SERVICIO quien apunta a FACTURA.
-- =============================================================================
CREATE TABLE factura (
    id_factura            INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    id_cliente            INT UNSIGNED    NOT NULL COMMENT 'FK: cliente al que se emite la factura',
    numero_factura        VARCHAR(30)     NOT NULL COMMENT 'Numero oficial de factura; unico',
    fecha_emision         DATE            NOT NULL,
    fecha_vencimiento     DATE            NOT NULL COMMENT 'Fecha limite de pago',
    importe_base          DECIMAL(12,2)   NOT NULL COMMENT 'Importe sin impuestos en euros',
    porcentaje_iva        DECIMAL(5,2)    NOT NULL COMMENT 'Porcentaje IVA aplicado',
    importe_total         DECIMAL(12,2)   NOT NULL COMMENT 'Importe total con impuestos (valor inmutable)',
    estado_cobro          ENUM('Pendiente','Cobrada','Vencida','En_mora','Anulada') NOT NULL DEFAULT 'Pendiente',
    fecha_cobro           DATE            NULL     COMMENT 'Fecha de pago recibido; NULL hasta cobro',
    metodo_cobro          VARCHAR(100)    NULL     COMMENT 'Forma de cobro efectuada',
    PRIMARY KEY (id_factura),
    UNIQUE KEY uq_factura_numero (numero_factura),
    CONSTRAINT fk_factura_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Documentos de cobro emitidos por servicios completados';

-- =============================================================================
-- TABLA 10 - servicio
-- FK: id_cliente -> cliente (NOT NULL)
-- FK: id_factura -> factura (NULL) -- patron circular resuelto con FK nullable
-- SERVICIO se crea despues de FACTURA para poder declarar la FK.
-- =============================================================================
CREATE TABLE servicio (
    id_servicio              INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    id_cliente               INT UNSIGNED    NOT NULL COMMENT 'FK: cliente que contrata el servicio',
    id_factura               INT UNSIGNED    NULL     COMMENT 'FK: factura que agrupa el servicio; NULL si aun no facturado',
    numero_servicio          VARCHAR(20)     NOT NULL COMMENT 'Codigo interno legible; unico',
    fecha_solicitud          DATE            NOT NULL COMMENT 'Fecha del encargo del cliente',
    fecha_prevista_recogida  DATE            NOT NULL COMMENT 'Fecha planificada para primera recogida',
    tipo_servicio            ENUM('FTL','LTL','Especial') NOT NULL,
    nivel_urgencia           ENUM('Estandar','Urgente','Fecha_garantizada','Nocturno') NOT NULL DEFAULT 'Estandar',
    estado_actual            ENUM('Pendiente','Planificado','Asignado','En_transito','Entregado','Cerrado','Cancelado','Con_incidencia') NOT NULL DEFAULT 'Pendiente',
    documentacion_completa   TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '1=todos los documentos recibidos',
    observaciones            TEXT            NULL,
    PRIMARY KEY (id_servicio),
    UNIQUE KEY uq_servicio_numero (numero_servicio),
    CONSTRAINT fk_servicio_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_servicio_factura
        FOREIGN KEY (id_factura) REFERENCES factura (id_factura)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    INDEX idx_servicio_estado (estado_actual),
    INDEX idx_servicio_fecha_recogida (fecha_prevista_recogida)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Entidad central: cada operacion de transporte desde solicitud hasta cierre';

-- =============================================================================
-- TABLA 11 - punto_servicio
-- FK: id_servicio -> servicio (NOT NULL)
-- FK: id_direccion -> direccion_operativa (NULL -- punto ad hoc sin direccion registrada)
-- =============================================================================
CREATE TABLE punto_servicio (
    id_punto              INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    id_servicio           INT UNSIGNED    NOT NULL COMMENT 'FK: servicio al que pertenece el punto',
    id_direccion          INT UNSIGNED    NULL     COMMENT 'FK: direccion operativa registrada; NULL si es ad hoc',
    tipo                  ENUM('Recogida','Entrega') NOT NULL,
    orden                 TINYINT UNSIGNED NOT NULL COMMENT 'Posicion de la parada dentro de la ruta',
    direccion             VARCHAR(250)    NOT NULL COMMENT 'Direccion exacta del punto (siempre informada)',
    ciudad                VARCHAR(100)    NOT NULL,
    pais                  VARCHAR(60)     NOT NULL,
    ventana_inicio        DATETIME        NULL     COMMENT 'Inicio de la ventana horaria acordada',
    ventana_fin           DATETIME        NULL     COMMENT 'Fin de la ventana horaria acordada',
    fecha_ejecucion_real  DATETIME        NULL     COMMENT 'Fecha y hora real de ejecucion',
    estado                ENUM('Pendiente','En_proceso','Completado','Fallido') NOT NULL DEFAULT 'Pendiente',
    observaciones         TEXT            NULL,
    PRIMARY KEY (id_punto),
    CONSTRAINT fk_punto_servicio
        FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_punto_direccion
        FOREIGN KEY (id_direccion) REFERENCES direccion_operativa (id_direccion)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Paradas individuales dentro de un servicio: recogidas y entregas';

-- =============================================================================
-- TABLA 12 - evento_seguimiento
-- FK: id_servicio -> servicio (NOT NULL)
-- =============================================================================
CREATE TABLE evento_seguimiento (
    id_evento             INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    id_servicio           INT UNSIGNED    NOT NULL COMMENT 'FK: servicio al que pertenece el evento',
    tipo_evento           ENUM('Servicio_creado','Planificado','Asignado','Recogida_completada','En_transito','Llegada_punto','Entrega_completada','Incidencia_registrada','Cerrado','Cancelado','Otro') NOT NULL,
    descripcion           VARCHAR(500)    NOT NULL,
    fecha_hora            DATETIME        NOT NULL,
    estado_resultante     ENUM('Pendiente','Planificado','Asignado','En_transito','Entregado','Cerrado','Cancelado','Con_incidencia') NOT NULL,
    usuario_responsable   VARCHAR(100)    NOT NULL,
    observaciones         VARCHAR(500)    NULL,
    PRIMARY KEY (id_evento),
    CONSTRAINT fk_evento_servicio
        FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    INDEX idx_evento_servicio_fecha (id_servicio, fecha_hora)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Historial cronologico de eventos de cada servicio (trazabilidad)';

-- =============================================================================
-- TABLA 13 - mercancia
-- FK: id_servicio -> servicio (NOT NULL)
-- Sin UNIQUE sobre id_servicio: relacion 1:N (LTL puede tener varios lotes).
-- =============================================================================
CREATE TABLE mercancia (
    id_mercancia          INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    id_servicio           INT UNSIGNED    NOT NULL COMMENT 'FK: servicio al que pertenece el lote',
    descripcion           VARCHAR(500)    NOT NULL COMMENT 'Descripcion general de la carga',
    tipo_carga            ENUM('Paletizada','Bultos','Granel','Maquinaria','Piezas_especiales','Otro') NOT NULL,
    num_bultos_palets     INT UNSIGNED    NULL     COMMENT 'Numero de bultos, pales o unidades',
    peso_kg               DECIMAL(10,2)   NULL     COMMENT 'Peso total en kilogramos',
    volumen_m3            DECIMAL(8,3)    NULL     COMMENT 'Volumen total en metros cubicos',
    valor_declarado       DECIMAL(12,2)   NULL     COMMENT 'Valor declarado de la carga en euros',
    observaciones         TEXT            NULL,
    PRIMARY KEY (id_mercancia),
    CONSTRAINT fk_mercancia_servicio
        FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Descripcion fisica de la carga por servicio (1:N para LTL)';

-- =============================================================================
-- TABLA 14 - requisito_especial
-- FK: id_servicio -> servicio (NOT NULL)
-- =============================================================================
CREATE TABLE requisito_especial (
    id_requisito          INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    id_servicio           INT UNSIGNED    NOT NULL COMMENT 'FK: servicio al que aplica el requisito',
    tipo                  ENUM('Temperatura_controlada','Manipulacion_especial','Seguro_adicional','Restriccion_acceso','Documentacion_adicional','Otro') NOT NULL,
    descripcion           VARCHAR(500)    NOT NULL,
    temperatura_min       DECIMAL(5,1)    NULL     COMMENT 'Temperatura minima requerida en grados C',
    temperatura_max       DECIMAL(5,1)    NULL     COMMENT 'Temperatura maxima requerida en grados C',
    instrucciones         TEXT            NULL     COMMENT 'Instrucciones operativas para el conductor',
    verificacion_obligatoria TINYINT(1)   NOT NULL DEFAULT 0 COMMENT '1=requiere verificacion documental',
    PRIMARY KEY (id_requisito),
    CONSTRAINT fk_requisito_servicio
        FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Condicionantes operativos especificos de un servicio';

-- =============================================================================
-- TABLA 15 - incidencia
-- FK: id_servicio -> servicio (NOT NULL)
-- =============================================================================
CREATE TABLE incidencia (
    id_incidencia              INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    id_servicio                INT UNSIGNED    NOT NULL COMMENT 'FK: servicio en el que se produce la incidencia',
    tipo                       ENUM('Averia_vehiculo','Accidente','Demora_significativa','Mercancia_danada','Rechazo_entrega','Problema_documentacion','Problema_acceso','Otro') NOT NULL,
    descripcion                TEXT            NOT NULL,
    fecha_apertura             DATETIME        NOT NULL,
    prioridad                  ENUM('Baja','Media','Alta','Critica') NOT NULL DEFAULT 'Media',
    estado                     ENUM('Abierta','En_gestion','Resuelta','Cerrada') NOT NULL DEFAULT 'Abierta',
    fecha_ultima_actualizacion DATETIME        NULL,
    responsable_gestion        VARCHAR(150)    NULL,
    fecha_cierre               DATETIME        NULL     COMMENT 'NULL mientras la incidencia este abierta',
    descripcion_resolucion     TEXT            NULL,
    genera_coste_adicional     TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '1=genero coste extra',
    PRIMARY KEY (id_incidencia),
    CONSTRAINT fk_incidencia_servicio
        FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    INDEX idx_incidencia_estado (estado)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Eventos no planificados que afectan a la ejecucion de un servicio';

-- =============================================================================
-- TABLA 16 - coste_operativo
-- FK: id_servicio -> servicio (NOT NULL)
-- =============================================================================
CREATE TABLE coste_operativo (
    id_coste              INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    id_servicio           INT UNSIGNED    NOT NULL COMMENT 'FK: servicio al que se imputa el coste',
    tipo_coste            ENUM('Combustible','Peajes','Dietas','Reparacion','Seguro_adicional','Mantenimiento','Otro') NOT NULL,
    importe               DECIMAL(10,2)   NOT NULL COMMENT 'Importe del coste en euros',
    fecha                 DATE            NOT NULL COMMENT 'Fecha en que se incurrio el coste',
    descripcion           VARCHAR(500)    NULL,
    justificante_disponible TINYINT(1)    NOT NULL DEFAULT 0 COMMENT '1=hay factura o justificante',
    PRIMARY KEY (id_coste),
    CONSTRAINT fk_coste_servicio
        FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Gastos directos imputables a cada servicio de transporte';

-- =============================================================================
-- TABLA 17 - documento_servicio
-- FK: id_servicio -> servicio (NOT NULL)
-- =============================================================================
CREATE TABLE documento_servicio (
    id_documento_srv      INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    id_servicio           INT UNSIGNED    NOT NULL COMMENT 'FK: servicio al que pertenece el documento',
    tipo_documento        ENUM('CMR','Albaran_entrega','Parte_incidencia','Registro_temperatura','Certificado','Foto','Otro') NOT NULL,
    descripcion           VARCHAR(500)    NULL,
    fecha_documento       DATE            NOT NULL,
    recibido              TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '1=recibido y archivado',
    fecha_recepcion       DATE            NULL     COMMENT 'NULL si aun no recibido',
    referencia_archivo    VARCHAR(250)    NULL     COMMENT 'Ruta al archivo fisico o digital',
    PRIMARY KEY (id_documento_srv),
    CONSTRAINT fk_documento_srv_servicio
        FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Documentacion vinculada a cada servicio: CMR, albaranes, etc.';

-- =============================================================================
-- TABLA 18 - asignacion
-- FK: id_servicio -> servicio (NOT NULL)
-- FK: id_conductor -> conductor (NOT NULL)
-- FK: id_vehiculo -> vehiculo (NOT NULL)
-- FK: id_remolque -> remolque (NULL -- vehiculo rigido sin remolque)
-- =============================================================================
CREATE TABLE asignacion (
    id_asignacion         INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    id_servicio           INT UNSIGNED    NOT NULL COMMENT 'FK: servicio al que se asignan recursos',
    id_conductor          INT UNSIGNED    NOT NULL COMMENT 'FK: conductor asignado',
    id_vehiculo           INT UNSIGNED    NOT NULL COMMENT 'FK: vehiculo asignado',
    id_remolque           INT UNSIGNED    NULL     COMMENT 'FK: remolque asignado; NULL si no se usa remolque',
    fecha_asignacion      DATETIME        NOT NULL COMMENT 'Fecha y hora de formalizacion de la asignacion',
    es_activa             TINYINT(1)      NOT NULL DEFAULT 1 COMMENT '1=vigente, 0=historico sustituido',
    motivo_cambio         VARCHAR(500)    NULL     COMMENT 'Motivo de reasignacion si sustituye a una anterior',
    observaciones         VARCHAR(500)    NULL,
    PRIMARY KEY (id_asignacion),
    CONSTRAINT fk_asignacion_servicio
        FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_asignacion_conductor
        FOREIGN KEY (id_conductor) REFERENCES conductor (id_conductor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_asignacion_vehiculo
        FOREIGN KEY (id_vehiculo) REFERENCES vehiculo (id_vehiculo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_asignacion_remolque
        FOREIGN KEY (id_remolque) REFERENCES remolque (id_remolque)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Asignacion de conductor, vehiculo y remolque a un servicio';

-- =============================================================================
-- TABLA 19 - conductor_categoria_permiso
-- Tabla intermedia N:M entre conductor y categoria_permiso.
-- PK compuesta: (id_conductor, id_categoria). Sin PK artificial.
-- =============================================================================
CREATE TABLE conductor_categoria_permiso (
    id_conductor          INT UNSIGNED    NOT NULL COMMENT 'FK/PK: conductor que posee la categoria',
    id_categoria          INT UNSIGNED    NOT NULL COMMENT 'FK/PK: categoria de permiso habilitante',
    fecha_obtencion       DATE            NULL     COMMENT 'Fecha en que el conductor obtuvo esta categoria',
    PRIMARY KEY (id_conductor, id_categoria),
    CONSTRAINT fk_ccp_conductor
        FOREIGN KEY (id_conductor) REFERENCES conductor (id_conductor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_ccp_categoria
        FOREIGN KEY (id_categoria) REFERENCES categoria_permiso (id_categoria)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Relacion N:M entre conductores y categorias de permiso de conducir';

-- =============================================================================
-- TABLA 20 - documento_recurso
-- FK opcionales: id_vehiculo, id_remolque, id_conductor (exactamente UNA NOT NULL).
-- CHECK garantiza que exactamente una de las tres FK sea NOT NULL.
-- =============================================================================
CREATE TABLE documento_recurso (
    id_documento_rec      INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    id_vehiculo           INT UNSIGNED    NULL     COMMENT 'FK: vehiculo al que pertenece; NULL si no aplica',
    id_remolque           INT UNSIGNED    NULL     COMMENT 'FK: remolque al que pertenece; NULL si no aplica',
    id_conductor          INT UNSIGNED    NULL     COMMENT 'FK: conductor al que pertenece; NULL si no aplica',
    tipo_documento        ENUM('Permiso_circulacion','Seguro','ITV','Tacografo_calibracion','Permiso_conducir','CAP','Tarjeta_tacografo','Autorizacion_especial','Otro') NOT NULL,
    numero_documento      VARCHAR(60)     NULL     COMMENT 'Numero o referencia del documento',
    fecha_emision         DATE            NULL     COMMENT 'Fecha de emision del documento',
    fecha_caducidad       DATE            NOT NULL COMMENT 'Fecha hasta la que el documento es valido',
    organismo_emisor      VARCHAR(150)    NULL     COMMENT 'Organismo o entidad que emite el documento',
    referencia_archivo    VARCHAR(250)    NULL     COMMENT 'Ruta al archivo fisico o digital',
    PRIMARY KEY (id_documento_rec),
    CONSTRAINT chk_doc_rec_exactamente_uno
        CHECK (
            (id_vehiculo IS NOT NULL) + (id_remolque IS NOT NULL) + (id_conductor IS NOT NULL) = 1
        ),
    CONSTRAINT fk_doc_rec_vehiculo
        FOREIGN KEY (id_vehiculo) REFERENCES vehiculo (id_vehiculo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_doc_rec_remolque
        FOREIGN KEY (id_remolque) REFERENCES remolque (id_remolque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_doc_rec_conductor
        FOREIGN KEY (id_conductor) REFERENCES conductor (id_conductor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    INDEX idx_doc_rec_caducidad (fecha_caducidad)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Documentos con caducidad de vehiculos, remolques y conductores';

SET FOREIGN_KEY_CHECKS = 1;

-- =============================================================================
-- Fin del script
-- Tablas creadas: 20
-- Siguiente script: alter_table.sql, luego datos_prueba.sql
-- =============================================================================
