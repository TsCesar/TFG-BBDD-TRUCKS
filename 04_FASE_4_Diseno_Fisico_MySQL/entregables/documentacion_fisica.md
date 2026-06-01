# Documentacion del Diseno Fisico MySQL

**Proyecto:** Diseno, creacion y explotacion de una base de datos para la gestion integral
de una empresa de transporte intracomunitario por carretera (UE)
**Fase:** 4 - Diseno Fisico en MySQL
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora - Curso 2024-26
**Alumno:** Cesar Mendez

---

## 1. Datos generales de la base de datos

| Parametro | Valor |
|---|---|
| **Nombre de la base de datos** | `tfg_transporte_ue` |
| **Motor de almacenamiento** | InnoDB |
| **Juego de caracteres** | utf8mb4 |
| **Collation** | utf8mb4_unicode_ci |
| **Version de MySQL** | 8.x |
| **Numero de tablas** | 20 |

### Por que InnoDB

InnoDB es el unico motor de MySQL que soporta claves foraneas con integridad referencial,
transacciones ACID y bloqueo a nivel de fila. Estas tres caracteristicas son imprescindibles
para el dominio del transporte, donde las operaciones de insercion de servicios, asignaciones
y facturas deben ser atomicas y consistentes. MyISAM fue descartado porque no aplica las
restricciones FK, lo que dejaria la integridad referencial completamente expuesta a errores
de la aplicacion.

### Por que utf8mb4

utf8mb4 es el unico juego de caracteres que cubre el plano basico multilingue completo de
Unicode, incluyendo caracteres especiales de los idiomas de los paises clientes (aleman,
frances, polaco, italiano). La collation `utf8mb4_unicode_ci` aplica ordenacion correcta
para comparaciones insensibles a mayusculas en todos esos idiomas.

---

## 2. Relacion con el modelo logico de FASE 3

El diseno fisico es una traduccion directa del esquema relacional de FASE 3. Las
transformaciones aplicadas son:

| Tipo logico (FASE 3) | Tipo fisico MySQL |
|---|---|
| ENTERO (PK autoincrementable) | `INT UNSIGNED NOT NULL AUTO_INCREMENT` |
| ENTERO (FK) | `INT UNSIGNED` (NOT NULL o NULL segun participacion) |
| TEXTO(n) | `VARCHAR(n)` |
| TEXTO largo (observaciones) | `TEXT` |
| DECIMAL(p,s) | `DECIMAL(p,s)` |
| FECHA | `DATE` |
| FECHAHORA | `DATETIME` |
| BOOLEANO | `TINYINT(1)` con DEFAULT 0 o 1 |
| ENUMERADO(v1,v2,...) | `ENUM('v1','v2',...)` |

---

## 3. Justificacion de tipos de dato

### INT UNSIGNED para PKs y FKs

Se usa `INT UNSIGNED AUTO_INCREMENT` para todas las PKs simples. El rango unsigned (0 a
4.294.967.295) es mas que suficiente para cualquier volumen de datos de esta empresa. Se
descarta BIGINT porque el overhead de almacenamiento no esta justificado en este contexto.
Las FKs usan `INT UNSIGNED` sin AUTO_INCREMENT.

### VARCHAR frente a CHAR

Se usa VARCHAR en todos los campos de texto variable. CHAR solo seria eficiente en campos
de longitud exactamente fija, que no existen en este modelo. Los campos de texto largo como
observaciones usan TEXT porque pueden superar los 255 caracteres.

### DECIMAL para importes y medidas

Se usa `DECIMAL(12,2)` para importes monetarios (importe_base, importe_total) y
`DECIMAL(10,2)` para pesos en kg y capacidades. FLOAT y DOUBLE fueron descartados porque
introducen errores de representacion binaria en calculos financieros, inaceptable en
contabilidad. DECIMAL garantiza exactitud absoluta.

### ENUM para valores cerrados

Se usa ENUM cuando el conjunto de valores es fijo, conocido y no cambia con frecuencia:
estados de servicio, tipos de vehiculo, tipos de incidencia, etc. La ventaja es que MySQL
rechaza automaticamente cualquier valor no listado, reduciendo errores de entrada. La
desventaja (necesidad de ALTER TABLE para anadir valores) es aceptable en este contexto.

### SMALLINT UNSIGNED para anio_matriculacion

El campo `vehiculo.anio_matriculacion` usa `SMALLINT UNSIGNED` en lugar de INT porque un
ano de matriculacion nunca supera los 4 digitos. SMALLINT ocupa 2 bytes frente a los 4 de
INT, ahorrando espacio en tablas con muchos vehiculos.

### TINYINT UNSIGNED para orden en punto_servicio

El campo `punto_servicio.orden` usa `TINYINT UNSIGNED` porque la posicion de una parada
dentro de una ruta no supera razonablemente 255 paradas.

---

## 4. Justificacion de claves primarias

Todas las tablas, salvo `conductor_categoria_permiso`, tienen PK artificial de tipo
`INT UNSIGNED AUTO_INCREMENT`. Esta decision sigue el patron establecido en FASE 3 y es
coherente con las recomendaciones de MySQL para PKs en tablas InnoDB:

- Son inmutables (un CIF puede cambiar por fusion empresarial; una matricula puede
  rematricularse; el id_conductor nunca cambia).
- Son compactos (4 bytes frente a 20-30 bytes de un codigo alfanumerico como cif_nif).
- Son generados automaticamente, eliminando conflictos en inserciones concurrentes.

**CONDUCTOR_CATEGORIA_PERMISO** es la unica excepcion: su PK es compuesta `(id_conductor,
id_categoria)`. Esta es la representacion correcta de una tabla de union N:M sin ciclo de
vida propio. No se usa PK artificial porque la combinacion conductor+categoria ya es por
definicion unica y semanticamente significativa.

---

## 5. Justificacion de claves foraneas y politicas ON DELETE / ON UPDATE

| Tabla | FK | ON DELETE | ON UPDATE | Razon |
|---|---|---|---|---|
| contacto | id_cliente | RESTRICT | CASCADE | No borrar cliente con contactos |
| direccion_operativa | id_cliente | RESTRICT | CASCADE | No borrar cliente con direcciones |
| factura | id_cliente | RESTRICT | CASCADE | No borrar cliente con facturas |
| servicio | id_cliente | RESTRICT | CASCADE | No borrar cliente con servicios |
| servicio | id_factura | SET NULL | CASCADE | Si se anula una factura, el servicio queda sin facturar |
| punto_servicio | id_servicio | RESTRICT | CASCADE | No borrar servicio con puntos |
| punto_servicio | id_direccion | SET NULL | CASCADE | Si se elimina direccion, el punto queda ad hoc |
| evento_seguimiento | id_servicio | RESTRICT | CASCADE | Historial de servicio no se puede huerfanar |
| mercancia | id_servicio | RESTRICT | CASCADE | No borrar servicio con mercancias |
| requisito_especial | id_servicio | RESTRICT | CASCADE | Idem |
| incidencia | id_servicio | RESTRICT | CASCADE | Idem |
| coste_operativo | id_servicio | RESTRICT | CASCADE | Idem |
| documento_servicio | id_servicio | RESTRICT | CASCADE | Idem |
| asignacion | id_servicio | RESTRICT | CASCADE | Idem |
| asignacion | id_conductor | RESTRICT | CASCADE | No borrar conductor con asignaciones |
| asignacion | id_vehiculo | RESTRICT | CASCADE | No borrar vehiculo con asignaciones |
| asignacion | id_remolque | SET NULL | CASCADE | Si remolque se da de baja, asignacion queda sin remolque |
| conductor_cat | id_conductor | RESTRICT | CASCADE | No borrar conductor con categorias asignadas |
| conductor_cat | id_categoria | RESTRICT | CASCADE | No borrar categoria usada |
| documento_recurso | id_vehiculo | RESTRICT | CASCADE | No borrar recurso con documentos vigentes |
| documento_recurso | id_remolque | RESTRICT | CASCADE | Idem |
| documento_recurso | id_conductor | RESTRICT | CASCADE | Idem |

---

## 6. Justificacion de restricciones UNIQUE

| Columna | Tabla | Razon |
|---|---|---|
| cif_nif | cliente | El identificador fiscal identifica univocamente a un cliente en toda la UE |
| matricula | vehiculo | La matricula identifica univocamente a un vehiculo en el territorio de matriculacion |
| matricula | remolque | Idem para remolques |
| numero_empleado | conductor | El numero de empleado es el identificador interno unico de la empresa |
| numero_permiso | conductor | El permiso de conducir es un documento oficial unico por persona |
| codigo_categoria | categoria_permiso | El codigo (C, CE, etc.) es el identificador oficial de la categoria |
| numero_servicio | servicio | El codigo de servicio (SRV-YYYY-NNNN) identifica univocamente el expediente |
| numero_factura | factura | El numero de factura es un documento legal; no puede duplicarse |

---

## 7. Justificacion de valores DEFAULT

| Columna | Tabla | DEFAULT | Razon |
|---|---|---|---|
| activo | cliente | 1 (TRUE) | Todo cliente creado esta activo hasta que se desactive explicitamente |
| es_principal | contacto | 0 (FALSE) | Al crear un contacto, no es principal salvo que se indique |
| activa | direccion_operativa | 1 (TRUE) | Toda direccion es activa al crearla |
| activa | categoria_permiso | 1 (TRUE) | Toda categoria creada esta vigente |
| nivel_urgencia | servicio | 'Estandar' | La urgencia por defecto es estandar |
| estado_actual | servicio | 'Pendiente' | Un servicio recien creado siempre empieza como Pendiente |
| documentacion_completa | servicio | 0 (FALSE) | La documentacion no esta completa hasta confirmacion |
| estado | punto_servicio | 'Pendiente' | Un punto recien creado esta pendiente de ejecucion |
| prioridad | incidencia | 'Media' | La prioridad por defecto es Media |
| estado | incidencia | 'Abierta' | Una incidencia recien creada siempre esta Abierta |
| genera_coste_adicional | incidencia | 0 (FALSE) | Por defecto no genera coste hasta que se confirme |
| es_activa | asignacion | 1 (TRUE) | Una asignacion recien creada siempre es la activa |
| verificacion_obligatoria | requisito_especial | 0 (FALSE) | Por defecto no requiere verificacion documental |
| justificante_disponible | coste_operativo | 0 (FALSE) | Por defecto no hay justificante hasta que se adjunte |
| recibido | documento_servicio | 0 (FALSE) | Un documento recien registrado no esta recibido aun |
| estado_cobro | factura | 'Pendiente' | Una factura emitida siempre empieza como Pendiente de cobro |

---

## 8. Justificacion de restricciones CHECK

### CHECK en DOCUMENTO_RECURSO

```sql
CONSTRAINT chk_doc_rec_exactamente_uno
    CHECK (
        (id_vehiculo IS NOT NULL) + (id_remolque IS NOT NULL) + (id_conductor IS NOT NULL) = 1
    )
```

Esta restriccion garantiza que cada fila de DOCUMENTO_RECURSO esta vinculada a exactamente
un recurso (un vehiculo, un remolque o un conductor), nunca a dos ni a ninguno. La suma
booleana funciona en MySQL porque TRUE se evalua como 1 y NULL/FALSE como 0.

**Por que este diseno frente a una superentidad RECURSO:** El modelo opto en FASE 2 por
tres FK opcionales en lugar de una jerarquia de herencia (superentidad RECURSO con
subtipos VEHICULO, REMOLQUE, CONDUCTOR), decision documentada como DD-007 en
docs/decisiones_diseno.md. La jerarquia requeriria una tabla adicional de la que heredan
tres tablas, lo que aumenta la complejidad de consultas y de mantenimiento sin ventajas
practicas en este dominio. La restriccion CHECK materializa la invariante del modelo en el
propio motor de base de datos.

---

## 9. Campos nullable: justificacion de valores NULL

### servicio.id_factura (NULL)

La FK `servicio.id_factura` admite NULL porque un servicio puede existir sin factura: es
el caso habitual durante toda la vida operativa del servicio (desde Pendiente hasta
Cerrado). La factura se emite una vez el servicio esta cerrado y el cliente la solicita.
Esta participacion parcial (R-05) se resuelve en FASE 3 colocando la FK en el lado N
(SERVICIO), con valor NULL mientras el servicio no este facturado.

### asignacion.id_remolque (NULL)

Los vehiculos de tipo Rigido no usan remolque. La FK `asignacion.id_remolque` admite NULL
para cubrir este caso. En el dataset de prueba, el vehiculo 6 (Renault T High 430, Rigido)
puede asignarse sin remolque.

### punto_servicio.id_direccion (NULL)

Un punto de servicio puede ser ad hoc: una direccion que no esta registrada como
DIRECCION_OPERATIVA del cliente (un cliente ocasional, un destinatario final no habitual,
una descarga en obra). En ese caso `id_direccion` es NULL y la informacion de la direccion
se almacena unicamente en el campo de texto `direccion`, que siempre es NOT NULL.

---

## 10. Indices adicionales

Ademas de los indices implicitos de PKs y UQs, se han creado los siguientes indices
para optimizar las consultas mas frecuentes identificadas en FASE 5 y FASE 6:

| Indice | Tabla | Columnas | Motivo |
|---|---|---|---|
| idx_servicio_estado | servicio | estado_actual | Filtrado de servicios por estado (operativa diaria) |
| idx_servicio_fecha_recogida | servicio | fecha_prevista_recogida | Planificacion semanal de recogidas |
| idx_evento_servicio_fecha | evento_seguimiento | id_servicio, fecha_hora | Consulta cronologica de eventos por servicio |
| idx_incidencia_estado | incidencia | estado | Gestion de incidencias abiertas |
| idx_doc_rec_caducidad | documento_recurso | fecha_caducidad | Control de documentos proximos a vencer (RF-028) |
| idx_factura_cobro (*) | factura | estado_cobro, fecha_vencimiento | Gestion de cobros pendientes y vencidos |

(*) Indice creado mediante ALTER TABLE en alter_table.sql.

---

## 11. Modificaciones de estructura: ALTER TABLE

### ALTER TABLE 1: ADD COLUMN km_estimados en servicio

```sql
ALTER TABLE servicio
    ADD COLUMN km_estimados INT UNSIGNED NULL
        COMMENT 'Kilometros estimados de la ruta completa (planificacion)'
        AFTER observaciones;
```

**Justificacion:** El modelo logico de FASE 3 no incluia esta columna. Al analizar los
requisitos de explotacion de FASE 5, se identifico que la consulta de rentabilidad por
servicio (RF-022) requiere comparar costes reales con una estimacion de costes de
combustible teoricos basados en kilometros. La columna es nullable porque en servicios
Pendientes la ruta no esta planificada todavia. La decision se registra como DD-008 en
docs/decisiones_diseno.md.

**Impacto:** Solo se anade una columna nullable. No se modifica ninguna FK, restriccion
ni dato existente. El ALTER TABLE es compatible con datos ya insertados.

### ALTER TABLE 2: ADD INDEX idx_factura_cobro en factura

```sql
ALTER TABLE factura
    ADD INDEX idx_factura_cobro (estado_cobro, fecha_vencimiento);
```

**Justificacion:** Las consultas de facturas impagadas y vencidas son las mas frecuentes
del modulo de administracion. El indice compuesto permite resolver consultas del tipo
`WHERE estado_cobro = 'Pendiente' AND fecha_vencimiento < CURDATE()` con acceso por rango
eficiente en lugar de full scan.

**Impacto:** Solo se crea un indice. No afecta a datos ni a restricciones.

---

## 12. Orden de ejecucion de scripts

```
1. schema.sql        -- CREATE DATABASE + todas las CREATE TABLE
2. alter_table.sql   -- ALTER TABLE (columna km_estimados + indice factura)
3. datos_prueba.sql  -- INSERT INTO todas las tablas
```

Es obligatorio respetar este orden. El script datos_prueba.sql inserta la columna
`km_estimados` como NULL (no se incluye en las sentencias INSERT), lo que es correcto
porque la columna admite NULL y se puede actualizar posteriormente.

---

## 13. Alineacion con la propuesta y los anexos

Se ha verificado que el diseno fisico es coherente con:

- **Propuesta TFG Cesar Mendez.pdf:** El nombre de la BD, las entidades y las relaciones
  coinciden con las descritas en la propuesta inicial y final.
- **RA2 TFG DAM Listado Fase3 y 4 CesarMendez.pdf:** Las 7 actividades de FASE 4 estan
  cubiertas: CREATE DATABASE (act.1), CREATE TABLE x20 (act.2), FK y relaciones (act.3),
  restricciones UNIQUE/DEFAULT/CHECK (act.4), ALTER TABLE x2 (act.5), INSERT INTO
  suficientes (act.6), scripts listos para phpMyAdmin (act.7).
- **FASE 3 cerrada:** El diseno fisico es una traduccion directa del esquema relacional
  de FASE 3. Las unicas diferencias son mejoras del diseno fisico (km_estimados,
  notas_internas en cliente) documentadas como decisiones de diseno.

**Decisiones de diseno que se apartan del modelo logico puro:**

| Decision | Descripcion | Documentado en |
|---|---|---|
| DD-006 | importe_total almacenado como valor inmutable, no calculado | docs/decisiones_diseno.md |
| DD-007 | DOCUMENTO_RECURSO con tres FK opcionales en lugar de superentidad RECURSO | docs/decisiones_diseno.md |
| DD-008 | km_estimados anadido en FASE 4 como columna nullable en servicio | docs/decisiones_diseno.md |

---

## 14. Estado de FASE 4

FASE 4 queda en estado **Pendiente de pruebas en phpMyAdmin**.

Los scripts estan listos para su ejecucion. La fase se marcara como Completada cuando:
- schema.sql se ejecute sin errores en phpMyAdmin
- alter_table.sql se ejecute sin errores
- datos_prueba.sql se ejecute sin errores
- Se obtengan las capturas de pantalla requeridas
