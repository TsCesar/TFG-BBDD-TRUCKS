# Diagrama Lógico Textual

**Proyecto:** Diseño, creación y explotación de una base de datos para la gestión integral
de una empresa de transporte intracomunitario por carretera (UE)
**Fase:** 3 - Modelo Lógico y Normalización
**Módulo:** Proyecto 2 DAM - Centro FP María Auxiliadora - Curso 2024-26

---

## Diagrama exportado

Este documento textual se utilizó como guía para dibujar el diagrama lógico en draw.io.
El diagrama final exportado se encuentra en:

- `entregables/ModeloLogico.png` — copia original
- `../../diagramas/modelo_logico.png` — copia en la carpeta de diagramas del proyecto

---

## Propósito y notación

Este documento representa el modelo lógico relacional completo en formato textual.
Su objetivo principal es servir como referencia exacta para dibujar el diagrama en
draw.io (o herramienta equivalente) y como documento de consulta técnica durante
la defensa del TFG.

### Notación utilizada

```
NOMBRE_TABLA
  PK   columna_pk          TIPO
  FK   columna_fk          TIPO  →  TABLA_DESTINO.columna_destino
       columna_normal       TIPO  [NN] [UQ]
```

- `PK` — clave primaria
- `FK` — clave foránea (seguida de la tabla y columna que referencia)
- `NN` — NOT NULL (obligatorio)
- `UQ` — UNIQUE (valor único)
- `(null)` — campo nullable (FK opcionales o datos no siempre disponibles)
- `→` — dirección de la referencia (la flecha apunta a la tabla padre)

---

## Modelo lógico completo

### Área 1 — Clientes y terceros

```
CLIENTE
  PK   id_cliente           ENTERO          NN
       nombre_razon_social  TEXTO(200)       NN
       cif_nif              TEXTO(20)        NN  UQ
       pais                 TEXTO(60)        NN
       ciudad               TEXTO(100)
       direccion_sede       TEXTO(250)
       telefono             TEXTO(30)
       email                TEXTO(150)
       condiciones_pago     TEXTO(100)
       activo               BOOLEANO         NN


CONTACTO
  PK   id_contacto          ENTERO          NN
  FK   id_cliente           ENTERO          NN  →  CLIENTE.id_cliente
       nombre               TEXTO(100)       NN
       apellidos            TEXTO(150)       NN
       cargo                TEXTO(100)
       telefono             TEXTO(30)
       email                TEXTO(150)
       es_principal         BOOLEANO         NN


DIRECCION_OPERATIVA
  PK   id_direccion         ENTERO          NN
  FK   id_cliente           ENTERO          NN  →  CLIENTE.id_cliente
       descripcion          TEXTO(150)
       direccion            TEXTO(250)       NN
       ciudad               TEXTO(100)       NN
       pais                 TEXTO(60)        NN
       telefono             TEXTO(30)
       horario              TEXTO(100)
       activa               BOOLEANO         NN
```

---

### Área 2 — Servicios y seguimiento

```
SERVICIO
  PK   id_servicio          ENTERO          NN
  FK   id_cliente           ENTERO          NN  →  CLIENTE.id_cliente
  FK   id_factura           ENTERO         (null) →  FACTURA.id_factura
       numero_servicio      TEXTO(20)        NN  UQ
       fecha_solicitud      FECHA            NN
       fecha_prevista_rec.  FECHA            NN
       tipo_servicio        ENUMERADO(FTL, LTL, Especial)   NN
       nivel_urgencia       ENUMERADO(Estandar, Urgente,
                              Fecha_garantizada, Nocturno)  NN
       estado_actual        ENUMERADO(Pendiente, Planificado,
                              Asignado, En_transito,
                              Entregado, Cerrado,
                              Cancelado, Con_incidencia)    NN
       documentacion_compl. BOOLEANO         NN
       observaciones        TEXTO(500)


PUNTO_SERVICIO
  PK   id_punto             ENTERO          NN
  FK   id_servicio          ENTERO          NN  →  SERVICIO.id_servicio
  FK   id_direccion         ENTERO         (null) →  DIRECCION_OPERATIVA.id_direccion
       tipo                 ENUMERADO(Recogida, Entrega)  NN
       orden                ENTERO           NN
       direccion            TEXTO(250)       NN
       ciudad               TEXTO(100)       NN
       pais                 TEXTO(60)        NN
       ventana_inicio       FECHAHORA
       ventana_fin          FECHAHORA
       fecha_ejecucion_real FECHAHORA
       estado               ENUMERADO(Pendiente, En_proceso,
                              Completado, Fallido)          NN
       observaciones        TEXTO(500)


EVENTO_SEGUIMIENTO
  PK   id_evento            ENTERO          NN
  FK   id_servicio          ENTERO          NN  →  SERVICIO.id_servicio
       tipo_evento          ENUMERADO(Servicio_creado, Planificado,
                              Asignado, Recogida_completada,
                              En_transito, Llegada_punto,
                              Entrega_completada,
                              Incidencia_registrada, Cerrado,
                              Cancelado, Otro)              NN
       descripcion          TEXTO(500)       NN
       fecha_hora           FECHAHORA        NN
       estado_resultante    ENUMERADO(Pendiente, Planificado,
                              Asignado, En_transito,
                              Entregado, Cerrado,
                              Cancelado, Con_incidencia)    NN
       usuario_responsable  TEXTO(100)       NN
       observaciones        TEXTO(500)
```

---

### Área 3 — Mercancía y requisitos

```
MERCANCIA
  PK   id_mercancia         ENTERO          NN
  FK   id_servicio          ENTERO          NN      →  SERVICIO.id_servicio
       descripcion          TEXTO(500)       NN
       tipo_carga           ENUMERADO(Paletizada, Bultos, Granel,
                              Maquinaria, Piezas_especiales, Otro)  NN
       num_bultos_palets    ENTERO
       peso_kg              DECIMAL(10,2)
       volumen_m3           DECIMAL(8,3)
       valor_declarado      DECIMAL(12,2)
       observaciones        TEXTO(500)


REQUISITO_ESPECIAL
  PK   id_requisito         ENTERO          NN
  FK   id_servicio          ENTERO          NN  →  SERVICIO.id_servicio
       tipo                 ENUMERADO(Temperatura_controlada,
                              Manipulacion_especial,
                              Seguro_adicional,
                              Restriccion_acceso,
                              Documentacion_adicional, Otro)  NN
       descripcion          TEXTO(500)       NN
       temperatura_min      DECIMAL(5,1)
       temperatura_max      DECIMAL(5,1)
       instrucciones        TEXTO(1000)
       verificacion_oblig.  BOOLEANO         NN
```

---

### Área 4 — Incidencias

```
INCIDENCIA
  PK   id_incidencia        ENTERO          NN
  FK   id_servicio          ENTERO          NN  →  SERVICIO.id_servicio
       tipo                 ENUMERADO(Averia_vehiculo,
                              Accidente, Demora_significativa,
                              Mercancia_danada, Rechazo_entrega,
                              Problema_documentacion,
                              Problema_acceso, Otro)         NN
       descripcion          TEXTO(1000)      NN
       fecha_apertura       FECHAHORA        NN
       prioridad            ENUMERADO(Baja, Media, Alta, Critica) NN
       estado               ENUMERADO(Abierta, En_gestion,
                              Resuelta, Cerrada)              NN
       fecha_ult_actual.    FECHAHORA
       responsable_gestion  TEXTO(150)
       fecha_cierre         FECHAHORA
       descripcion_resol.   TEXTO(1000)
       genera_coste_adic.   BOOLEANO         NN
```

---

### Área 5 — Recursos

```
VEHICULO
  PK   id_vehiculo          ENTERO          NN
       matricula            TEXTO(15)        NN  UQ
       tipo                 ENUMERADO(Cabeza_tractora, Rigido)  NN
       marca                TEXTO(60)
       modelo               TEXTO(80)
       anio_matriculacion   ENTERO
       capacidad_carga_kg   DECIMAL(10,2)
       estado_operativo     ENUMERADO(Disponible, Asignado,
                              Mantenimiento, Baja)            NN


REMOLQUE
  PK   id_remolque          ENTERO          NN
       matricula            TEXTO(15)        NN  UQ
       tipo                 ENUMERADO(Lona, Frigorifico,
                              Cisterna, Portacoches,
                              Caja_cerrada, Otro)             NN
       capacidad_carga_kg   DECIMAL(10,2)
       longitud_m           DECIMAL(5,2)
       apto_temperatura     BOOLEANO
       estado_operativo     ENUMERADO(Disponible, Asignado,
                              Mantenimiento, Baja)            NN


CONDUCTOR
  PK   id_conductor         ENTERO          NN
       numero_empleado      TEXTO(20)        NN  UQ
       nombre               TEXTO(100)       NN
       apellidos            TEXTO(150)       NN
       fecha_nacimiento     FECHA
       telefono             TEXTO(30)
       email                TEXTO(150)
       numero_permiso       TEXTO(30)        NN  UQ
       estado_disponib.     ENUMERADO(Disponible, Asignado,
                              Vacaciones, Baja_temporal,
                              Baja_definitiva)                NN


ASIGNACION
  PK   id_asignacion        ENTERO          NN
  FK   id_servicio          ENTERO          NN  →  SERVICIO.id_servicio
  FK   id_conductor         ENTERO          NN  →  CONDUCTOR.id_conductor
  FK   id_vehiculo          ENTERO          NN  →  VEHICULO.id_vehiculo
  FK   id_remolque          ENTERO         (null) →  REMOLQUE.id_remolque
       fecha_asignacion     FECHAHORA        NN
       es_activa            BOOLEANO         NN
       motivo_cambio        TEXTO(500)
       observaciones        TEXTO(500)


CATEGORIA_PERMISO                               [catálogo]
  PK   id_categoria         ENTERO          NN
       codigo_categoria     TEXTO(10)        NN  UQ
       descripcion          TEXTO(250)       NN
       activa               BOOLEANO         NN


CONDUCTOR_CATEGORIA_PERMISO                     [tabla intermedia N:M — R-21]
  PK/FK  id_conductor       ENTERO          NN  →  CONDUCTOR.id_conductor
  PK/FK  id_categoria       ENTERO          NN  →  CATEGORIA_PERMISO.id_categoria
         fecha_obtencion    FECHA
  [PK compuesta: (id_conductor, id_categoria)]
```

---

### Área 6 — Costes operativos

```
COSTE_OPERATIVO
  PK   id_coste             ENTERO          NN
  FK   id_servicio          ENTERO          NN  →  SERVICIO.id_servicio
       tipo_coste           ENUMERADO(Combustible, Peajes,
                              Dietas, Reparacion,
                              Seguro_adicional,
                              Mantenimiento, Otro)            NN
       importe              DECIMAL(10,2)    NN
       fecha                FECHA            NN
       descripcion          TEXTO(500)
       justificante_disp.   BOOLEANO         NN
```

---

### Área 7 — Facturación y cobros

```
FACTURA
  PK   id_factura           ENTERO          NN
  FK   id_cliente           ENTERO          NN  →  CLIENTE.id_cliente
       numero_factura       TEXTO(20)        NN  UQ
       fecha_emision        FECHA            NN
       fecha_vencimiento    FECHA            NN
       importe_base         DECIMAL(12,2)    NN
       porcentaje_iva       DECIMAL(5,2)     NN
       importe_total        DECIMAL(12,2)    NN
       estado_cobro         ENUMERADO(Pendiente, Cobrada,
                              Vencida, En_mora, Anulada)      NN
       fecha_cobro          FECHA
       metodo_cobro         TEXTO(100)
```

---

### Área 8 — Documentación y control interno

```
DOCUMENTO_SERVICIO
  PK   id_documento_srv     ENTERO          NN
  FK   id_servicio          ENTERO          NN  →  SERVICIO.id_servicio
       tipo_documento       ENUMERADO(CMR, Albaran_entrega,
                              Parte_incidencia,
                              Registro_temperatura,
                              Certificado, Foto, Otro)        NN
       descripcion          TEXTO(500)
       fecha_documento      FECHA            NN
       recibido             BOOLEANO         NN
       fecha_recepcion      FECHA
       referencia_archivo   TEXTO(250)


DOCUMENTO_RECURSO
  PK   id_documento_rec     ENTERO          NN
  FK   id_vehiculo          ENTERO         (null) →  VEHICULO.id_vehiculo
  FK   id_remolque          ENTERO         (null) →  REMOLQUE.id_remolque
  FK   id_conductor         ENTERO         (null) →  CONDUCTOR.id_conductor
       [restricción: exactamente una de las tres FK es NOT NULL]
       tipo_documento       ENUMERADO(Permiso_circulacion,
                              Seguro, ITV, Tacografo_calibracion,
                              Permiso_conducir, CAP,
                              Tarjeta_tacografo,
                              Autorizacion_especial, Otro)    NN
       numero_documento     TEXTO(60)
       fecha_emision        FECHA
       fecha_caducidad      FECHA            NN
       organismo_emisor     TEXTO(150)
       referencia_archivo   TEXTO(250)


REGISTRO_AUDITORIA
  PK   id_auditoria         ENTERO          NN
       tipo_operacion       ENUMERADO(Crear, Modificar,
                              Eliminar, Cambio_estado,
                              Asignar, Facturar, Cobrar)      NN
       entidad_afectada     TEXTO(60)        NN
       id_registro_afect.   ENTERO           NN
       usuario              TEXTO(100)       NN
       fecha_hora           FECHAHORA        NN
       descripcion          TEXTO(1000)
       [sin FK — entidad transversal de auditoría]
```

---

## Mapa de relaciones

Todas las relaciones del modelo con su cardinalidad, nombre de relación (de FASE 2)
y la columna que materializa la FK:

| Cód | Relación | Tabla padre (1) | Tabla hija (N) | Columna FK | Nullable |
|:---:|---|---|---|---|:---:|
| R-01 | TIENE_CONTACTO | CLIENTE | CONTACTO | id_cliente | No |
| R-02 | TIENE_DIRECCION | CLIENTE | DIRECCION_OPERATIVA | id_cliente | No |
| R-03 | CONTRATA | CLIENTE | SERVICIO | id_cliente | No |
| R-04 | EMITIDA_A | CLIENTE | FACTURA | id_cliente | No |
| R-05 | AGRUPA_SERVICIOS | FACTURA | SERVICIO | id_factura | Sí |
| R-06 | TIENE_PUNTO | SERVICIO | PUNTO_SERVICIO | id_servicio | No |
| R-07 | REFERENCIA_DIRECCION | DIRECCION_OPERATIVA | PUNTO_SERVICIO | id_direccion | Sí |
| R-08 | REGISTRA_EVENTO | SERVICIO | EVENTO_SEGUIMIENTO | id_servicio | No |
| R-09 | CONTIENE_MERCANCIA (1:N) | SERVICIO | MERCANCIA | id_servicio | No |
| R-10 | REQUIERE_CONDICION | SERVICIO | REQUISITO_ESPECIAL | id_servicio | No |
| R-11 | GENERA_INCIDENCIA | SERVICIO | INCIDENCIA | id_servicio | No |
| R-12 | GENERA_COSTE | SERVICIO | COSTE_OPERATIVO | id_servicio | No |
| R-13 | TIENE_DOCUMENTO_SERVICIO | SERVICIO | DOCUMENTO_SERVICIO | id_servicio | No |
| R-14 | TIENE_ASIGNACION | SERVICIO | ASIGNACION | id_servicio | No |
| R-15 | REALIZA | CONDUCTOR | ASIGNACION | id_conductor | No |
| R-16 | UTILIZA_VEHICULO | VEHICULO | ASIGNACION | id_vehiculo | No |
| R-17 | UTILIZA_REMOLQUE | REMOLQUE | ASIGNACION | id_remolque | Sí |
| R-18 | DOCUMENTA_VEHICULO | VEHICULO | DOCUMENTO_RECURSO | id_vehiculo | Sí |
| R-19 | DOCUMENTA_REMOLQUE | REMOLQUE | DOCUMENTO_RECURSO | id_remolque | Sí |
| R-20 | DOCUMENTA_CONDUCTOR | CONDUCTOR | DOCUMENTO_RECURSO | id_conductor | Sí |
| **R-21** | **POSEE_CATEGORIA** | **CONDUCTOR** | **CONDUCTOR_CATEGORIA_PERMISO** | **id_conductor** | **No** |
| R-21b | POSEE_CATEGORIA (lado catálogo) | CATEGORIA_PERMISO | CONDUCTOR_CATEGORIA_PERMISO | id_categoria | No |

---

## Guía para trasladar a draw.io

### Paso 1 — Crear las tablas

Para cada tabla representada en este documento:
- Añadir un elemento de tipo **Table** (Entity en algunos templates de draw.io).
- Primera fila: nombre de tabla en negrita o mayúsculas.
- Columnas siguientes: una fila por atributo con icono de llave (PK/FK) o punto (atributo normal).
- Marcar PK con icono de llave amarilla o dorada.
- Marcar FK con icono de llave azul o enlace.

### Paso 2 — Organizar las tablas por área

Agrupar visualmente las tablas según las 8 áreas funcionales:
```
[Área 1: Clientes]              [Área 5: Recursos]
 CLIENTE                         VEHICULO  REMOLQUE  CONDUCTOR
  ├── CONTACTO                              ↓           │ N:M
  └── DIRECCION_OPERATIVA              ASIGNACION  CONDUCTOR_CATEGORIA_PERMISO
                                            ↑           │
[Área 2: Servicios] ────────────────────────┘     CATEGORIA_PERMISO
 SERVICIO (centro)
  ├── PUNTO_SERVICIO
  ├── EVENTO_SEGUIMIENTO
  ├── [Área 3] MERCANCIA (1:N)
  ├── [Área 3] REQUISITO_ESPECIAL
  ├── [Área 4] INCIDENCIA
  ├── [Área 6] COSTE_OPERATIVO
  └── [Área 8] DOCUMENTO_SERVICIO

[Área 7: Facturación]           [Área 8: Control]
 FACTURA ──→ SERVICIO.id_fac.    DOCUMENTO_RECURSO
  ↑                              REGISTRO_AUDITORIA
 CLIENTE
```

### Paso 3 — Dibujar las relaciones

Para cada relación del mapa de relaciones:
- Dibujar una línea entre la tabla padre y la tabla hija.
- En el extremo padre (1): poner la notación `1` o `||`.
- En el extremo hijo (N): poner la notación `N` o `>|` (cardinalidad muchos).
- Para FK nullable (participación parcial): añadir `0` o `o` en el extremo hijo: `0..N` o `o>|`.
- Para la relación 1:N R-09 CONTIENE_MERCANCIA (SERVICIO → MERCANCIA): `||──|<` (uno obligatorio en SERVICIO, muchos en MERCANCIA).

### Paso 4 — Notación de cardinalidades (estilo Chen o Crow's Foot)

Recomendación: usar la notación **Crow's Foot** (pata de cuervo), estándar en herramientas
como draw.io y MySQL Workbench:

| Cardinalidad | Notación Crow's Foot | Significado |
|---|---|---|
| Exactamente 1 | `\|` (barra simple) | Participación total, uno solo |
| Cero o uno | `O\|` (círculo + barra) | Participación parcial, máximo uno |
| Uno o más | `\|\|<` (doble barra + pata) | Participación total, muchos |
| Cero o más | `O\|<` (círculo + pata) | Participación parcial, muchos |

### Paso 5 — Resaltar elementos clave

- Usar **fondo amarillo o dorado** para las celdas PK.
- Usar **fondo azul claro** para las celdas FK.
- Usar **borde destacado** para la tabla SERVICIO (entidad central).
- Agrupar con rectángulos de color de fondo las tablas por área funcional.

---

## Cardinalidades derivadas del modelo lógico

Resumen de las cardinalidades finales en el modelo relacional, incluyendo las restricciones
de participación de FASE 2 trasladadas a la notación lógica:

| Relación | Cardinalidad | Notas |
|---|---|---|
| CLIENTE → CONTACTO | 1..N : 1 | Un cliente puede tener muchos contactos; participación parcial en CLIENTE |
| CLIENTE → DIRECCION_OPERATIVA | 1..N : 1 | Ídem; participación parcial en CLIENTE |
| CLIENTE → SERVICIO | 1..N : 1 | Todo servicio tiene cliente; CLIENTE puede estar sin servicios |
| CLIENTE → FACTURA | 1..N : 1 | Toda factura tiene cliente; CLIENTE puede estar sin facturas |
| FACTURA → SERVICIO | 0..N : 0..1 | Un servicio puede no estar facturado aún; FACTURA tiene al menos 1 servicio |
| SERVICIO → PUNTO_SERVICIO | 1..N : 1 | Participación total en ambos lados |
| DIRECCION_OPERATIVA → PUNTO_SERVICIO | 0..N : 0..1 | Un punto puede ser ad hoc (sin dirección registrada) |
| SERVICIO → EVENTO_SEGUIMIENTO | 1..N : 1 | Todo servicio tiene al menos el evento de creación |
| SERVICIO → MERCANCIA | 1..N : 1 | Un servicio puede tener varios lotes de mercancía (especialmente en LTL); participación total en MERCANCIA |
| SERVICIO → REQUISITO_ESPECIAL | 0..N : 1 | La mayoría de servicios no tienen requisitos especiales |
| SERVICIO → INCIDENCIA | 0..N : 1 | La mayoría de servicios se ejecutan sin incidencias |
| SERVICIO → COSTE_OPERATIVO | 0..N : 1 | Puede haber servicios sin costes adicionales registrados |
| SERVICIO → DOCUMENTO_SERVICIO | 0..N : 1 | Un servicio puede no tener documentos archivados aún |
| SERVICIO → ASIGNACION | 0..N : 1 | Un servicio en estado Pendiente puede no tener asignación |
| CONDUCTOR → ASIGNACION | 0..N : 1 | Un conductor disponible puede no tener asignaciones activas |
| VEHICULO → ASIGNACION | 0..N : 1 | Un vehículo disponible puede no tener asignaciones activas |
| REMOLQUE → ASIGNACION | 0..N : 0..1 | El remolque es opcional en la asignación |
| VEHICULO → DOCUMENTO_RECURSO | 0..N : 0..1 | Un documento pertenece a un vehículo, remolque o conductor |
| REMOLQUE → DOCUMENTO_RECURSO | 0..N : 0..1 | Ídem |
| CONDUCTOR → DOCUMENTO_RECURSO | 0..N : 0..1 | Ídem |
| CONDUCTOR → CATEGORIA_PERMISO | N:M | Resuelta mediante CONDUCTOR_CATEGORIA_PERMISO; participación total en CONDUCTOR, parcial en CATEGORIA_PERMISO |
