# Justificacion del Modelo Conceptual

**Proyecto:** Diseno, creacion y explotacion de una base de datos para la gestion integral
de una empresa de transporte intracomunitario por carretera (UE) en MySQL (phpMyAdmin)
**Fase:** 2 - Modelo Conceptual
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora - Curso 2024-26

---

## 1. Fundamentos del modelo

El modelo conceptual de este TFG se ha construido respetando al 100% el alcance de la
propuesta oficial, que organiza el contenido de la base de datos en ocho areas funcionales:

1. Clientes y terceros
2. Servicios y seguimiento
3. Mercancia y requisitos
4. Incidencias
5. Recursos
6. Costes operativos
7. Facturacion y cobros
8. Documentacion y control interno

Las 18 entidades del modelo se distribuyen exactamente en estas ocho areas, garantizando
que ningun elemento del alcance aprobado queda sin cobertura en el modelo conceptual.

La propuesta fija el alcance del proyecto; las instrucciones del modulo fijan el formato
y el nivel de detalle de cada fase. Este documento cumple ambos requisitos.

---

## 2. Criterio de identificacion de entidades

Cada una de las 18 entidades del modelo cumple los tres criterios de identificacion
de entidades en un modelo Entidad-Relacion:

1. **Identidad propia:** puede identificarse de forma unica mediante una clave primaria.
2. **Informacion propia:** tiene atributos que le pertenecen y que no pueden asignarse
   correctamente a otra entidad sin distorsionar el modelo o generar redundancias.
3. **Relaciones con otras entidades:** participa en al menos una relacion del modelo.

---

## 3. Justificacion por areas

### 3.1 Clientes y terceros (CLIENTE, CONTACTO, DIRECCION_OPERATIVA)

La propuesta menciona explicitamente: *"clientes, contactos y direcciones operativas"*.

**CLIENTE** es el actor externo principal y debe existir como entidad independiente con
sus datos de identificacion y condiciones comerciales.

**CONTACTO** se mantiene separado de CLIENTE porque un cliente corporativo tiene multiples
interlocutores con datos distintos (nombre, cargo, telefono). Fusionarlo en CLIENTE
obligaria a grupos de atributos repetidos, violando la Primera Forma Normal.

**DIRECCION_OPERATIVA** se mantiene separada porque los clientes con varias instalaciones
necesitan sus ubicaciones registradas para ser reutilizadas en los puntos de servicio
sin necesidad de teclearlas en cada nuevo servicio. Esto mejora la consistencia de datos.

### 3.2 Servicios y seguimiento (SERVICIO, PUNTO_SERVICIO, EVENTO_SEGUIMIENTO)

La propuesta menciona explicitamente: *"servicios/envios, puntos de recogida y entrega,
ventanas horarias, estados y eventos de seguimiento, e historial"*.

**SERVICIO** es la entidad central del modelo y no admite ninguna duda. Toda la informacion
operativa, economica y documental de una operacion de transporte esta vinculada a ella.

**PUNTO_SERVICIO** se mantiene como entidad independiente porque los servicios multipunto
son habituales en el sector (especialmente en LTL) y cada parada tiene sus propios datos:
direccion, orden en la ruta, ventana horaria y estado de ejecucion independiente. Si los
puntos fueran atributos de SERVICIO se generarian grupos repetidos, violando 1FN.

**EVENTO_SEGUIMIENTO** implementa el historial de trazabilidad del servicio exigido por
la propuesta. Se modela como entidad independiente y no como un simple campo de estado
en SERVICIO porque la propuesta requiere conservar *todos* los eventos del ciclo de vida,
no solo el estado actual. El atributo estado_actual en SERVICIO permite consultas rapidas;
EVENTO_SEGUIMIENTO conserva el historial completo con fecha, tipo de evento y responsable.
Estos dos elementos son complementarios, no redundantes.

### 3.3 Mercancia y requisitos (MERCANCIA, REQUISITO_ESPECIAL)

La propuesta menciona explicitamente: *"caracteristicas generales de la mercancia y
requisitos operativos especiales cuando proceda"*.

**MERCANCIA** se mantiene como entidad separada de SERVICIO por dos razones:
(a) distinguir la informacion del encargo operativo (quien, cuando, tipo de servicio) de
la descripcion fisica de la carga (que se transporta, cuanto pesa, que volumen ocupa);
(b) permitir multiples registros de carga por servicio. La relacion es **1:N** (no 1:1):
en servicios LTL (Less than Truck Load) el vehiculo puede transportar mercancias de
tipos distintos pertenecientes a diferentes expedidores; cada lote tiene su propia
descripcion, peso, volumen y valor declarado. La relacion 1:1 original se corrigio a 1:N
tras identificar que el modelo LTL la requiere. Cubre RF-007.

**REQUISITO_ESPECIAL** se mantiene como entidad independiente porque la propuesta la
incluye explicitamente y porque un mismo servicio puede tener varios requisitos de tipos
distintos (por ejemplo: temperatura controlada Y manipulacion especial Y seguro adicional).
Si los requisitos fueran atributos de SERVICIO se generarian grupos de atributos repetidos,
violando la Primera Forma Normal. Los requisitos son instancias especificas de cada servicio,
no un catalogo reutilizable, por lo que la relacion es 1:N y no N:M. Cubre RF-008.

### 3.4 Incidencias (INCIDENCIA)

La propuesta menciona explicitamente: *"registro, clasificacion, gestion y cierre, con
trazabilidad"*. INCIDENCIA se modela como entidad con su propio ciclo de vida (estados:
abierta, en gestion, resuelta, cerrada) porque la propuesta exige trazabilidad de su
gestion, no solo un simple campo de texto. Un servicio puede tener cero o varias
incidencias, y cada una tiene su propio ciclo de gestion independiente.

### 3.5 Recursos (VEHICULO, REMOLQUE, CONDUCTOR, ASIGNACION, CATEGORIA_PERMISO)

La propuesta menciona explicitamente: *"vehiculos, remolques y conductores, con
disponibilidad y asignaciones operativas"*.

**VEHICULO y REMOLQUE** se modelan como entidades separadas porque la combinacion
tractora-remolque puede variar en cada servicio, y porque cada uno tiene documentacion
con fechas de caducidad independientes. Fusionarlos falsificaria la realidad operativa
del sector.

**CONDUCTOR** es un recurso con atributos propios, disponibilidad gestionable y
documentacion habilitante con fechas de caducidad. Su existencia como entidad es
innegociable. El atributo `categorias_permiso` se elimina de CONDUCTOR porque no puede
modelarse correctamente como un campo de texto unico (viola la Primera Forma Normal al
contener multiples valores). Se sustituye por la relacion N:M POSEE_CATEGORIA con
la entidad CATEGORIA_PERMISO.

**ASIGNACION** se modela como entidad asociativa y no como simple relacion ternaria
porque: (a) tiene atributos propios (fecha de asignacion, es_activa, motivo_cambio);
(b) puede haber varias asignaciones historicas para un mismo servicio cuando se cambian
recursos; (c) el flag es_activa permite distinguir la asignacion vigente del historial.
La propuesta menciona explicitamente las *"asignaciones operativas"* como parte del
contenido de la base de datos. En el diagrama E/R se representa como **rectangulo**
(entidad asociativa), no como rombo.

**CATEGORIA_PERMISO** se modela como entidad catalogo separada de CONDUCTOR porque:
(a) un conductor puede tener varias categorias habilitantes (C, CE, C1, etc.);
(b) una misma categoria es compartida por muchos conductores, creando una relacion N:M
real e innegable en el dominio;
(c) modelar las categorias como atributo de texto libre (`categorias_permiso`) viola la
Primera Forma Normal y dificulta las consultas por categoria (RF-014);
(d) una entidad catalogo permite mantener las categorias homogeneizadas y evitar
variaciones ortograficas o errores de introduccion.
La relacion N:M POSEE_CATEGORIA (R-21) entre CONDUCTOR y CATEGORIA_PERMISO es la
unica N:M directa del modelo conceptual, representada con rombo en el diagrama E/R.
En FASE 3 se transformara en tabla intermedia CONDUCTOR_CATEGORIA_PERMISO.

### 3.6 Costes operativos (COSTE_OPERATIVO)

La propuesta menciona explicitamente: *"costes asociados a la operacion (combustible,
peajes y mantenimiento) y su imputacion"*. COSTE_OPERATIVO se modela como entidad
independiente porque un servicio puede generar varios costes de tipos distintos, y
porque su registro permite calcular la rentabilidad real de cada operacion comparando
costes con ingresos de la factura.

### 3.7 Facturacion y cobros (FACTURA)

La propuesta menciona explicitamente: *"registro de facturacion de servicios y seguimiento
de cobros"*. FACTURA se modela como entidad independiente de SERVICIO porque: (a) una
factura puede agrupar varios servicios en un ciclo de facturacion; (b) la factura tiene
su propio ciclo de vida economico (pendiente, cobrada, vencida, en mora) independiente
del ciclo operativo del servicio; (c) los datos fiscales de la factura pertenecen al
dominio contable.

### 3.8 Documentacion y control interno (DOCUMENTO_SERVICIO, DOCUMENTO_RECURSO, REGISTRO_AUDITORIA)

La propuesta menciona explicitamente: *"documentacion asociada a servicios, evidencias,
vigencias/caducidades y registros de auditoria interna"*.

**DOCUMENTO_SERVICIO** cubre la documentacion generada por cada servicio (CMR, albaranes,
evidencias). Se modela como entidad independiente porque un servicio puede generar varios
documentos de tipos distintos, y cada uno tiene su propio estado de recepcion y fecha.

**DOCUMENTO_RECURSO** cubre las vigencias y caducidades de documentos de vehiculos,
remolques y conductores. Se modela con tres FK opcionales (exactamente una con valor por
registro) porque los tres tipos de recurso comparten la misma estructura documental
pero son entidades distintas. La propuesta incluye explicitamente las vigencias/caducidades
como elemento del control interno.

**REGISTRO_AUDITORIA** cubre la auditoria interna exigida por la propuesta. Se modela
como entidad transversal (sin FK directas a otras entidades) porque registra operaciones
sobre cualquier entidad del sistema. Usa referencias por texto (nombre de entidad) e
identificador numerico para mantener la flexibilidad del registro de auditoria.

---

## 4. Decisiones de diseno explicadas

### 4.1 Identificadores artificiales en todas las entidades

Todas las entidades usan un identificador artificial autoincrementable como PK en lugar
de identificadores naturales (matricula, CIF, numero de empleado). Los identificadores
naturales pueden cambiar en el tiempo; los artificiales son inmutables y garantizan
la estabilidad de todas las relaciones del modelo.

### 4.2 Enumerados para campos de estado y tipo

Los atributos que aceptan un conjunto cerrado y conocido de valores (tipo_servicio,
estado_actual, tipo_incidencia, estado_cobro, tipo_documento...) se definen como
Enumerados. Esto es una decision de modelo conceptual, no de implementacion fisica;
en FASE 4 se materializaran de la forma mas adecuada segun el criterio tecnico.

### 4.3 EVENTO_SEGUIMIENTO como historial explicito de trazabilidad

La propuesta requiere trazabilidad y seguimiento mediante estados y eventos con historial
consultable. El modelo implementa esto de forma dual: el atributo estado_actual en SERVICIO
proporciona acceso eficiente al estado presente sin necesidad de consultar el historial;
EVENTO_SEGUIMIENTO conserva el registro completo y cronologico de todos los eventos.
Esta dualidad es un patron de diseno estandar en sistemas que requieren trazabilidad.

### 4.4 Tres FK opcionales en DOCUMENTO_RECURSO

La entidad DOCUMENTO_RECURSO se vincula a vehiculos, remolques o conductores mediante
tres FK opcionales, de las cuales exactamente una tiene valor en cada registro. Esta
solucion es pragmatica y defendible para el nivel de un TFG DAM. La alternativa
(superentidad RECURSO con herencia de subtipos) es mas elegante en teoria pero
introduce complejidad de modelado innecesaria para el alcance de este proyecto.

---

## 5. Analisis de relaciones N:M en el modelo conceptual

### 5.1 Relacion N:M directa: CONDUCTOR -- POSEE_CATEGORIA -- CATEGORIA_PERMISO

Esta es la **unica relacion N:M conceptual directa** del modelo. Se representa con
**rombo** en el diagrama E/R porque no tiene atributos propios y conecta dos entidades
de forma muchos-a-muchos pura:

```
[CONDUCTOR] --N-- <POSEE_CATEGORIA> --M-- [CATEGORIA_PERMISO]
```

Justificacion de la N:M:
- Un conductor puede tener varias categorias de permiso (C, CE, C1, C1E, etc.).
- Una misma categoria puede pertenecer a muchos conductores.
- No puede modelarse como atributo de texto en CONDUCTOR (violaria la 1FN).
- No tiene atributos propios en el modelo conceptual, por lo que se representa directamente
  con rombo (no como entidad asociativa en FASE 2).
- En FASE 3 se transformara en tabla intermedia CONDUCTOR_CATEGORIA_PERMISO.

Participacion:
- CONDUCTOR: **total** (todo conductor debe tener al menos una categoria habilitante)
- CATEGORIA_PERMISO: **parcial** (puede existir una categoria sin conductores asignados)

### 5.2 Relacion N:M resuelta mediante entidad asociativa: ASIGNACION

Las N:M entre SERVICIO y los tres recursos (CONDUCTOR, VEHICULO, REMOLQUE) se resuelven
mediante la entidad asociativa ASIGNACION, que tiene atributos propios y ciclo de vida
independiente. En el diagrama E/R, ASIGNACION se representa como **rectangulo** (entidad
asociativa), no como rombo, porque tiene atributos propios.

### 5.3 Tipos de relacion en el modelo final

| Tipo de relacion | Presencia en el modelo | Representacion |
|---|---|---|
| **1:1** | Ninguna | N/A |
| **1:N** | R-01 a R-20 (excepto R-21) | Lineas con crow's foot |
| **N:M directa** | R-21 POSEE_CATEGORIA | **Rombo** en diagrama E/R |
| **N:M resuelta** | CONDUCTOR/VEHICULO/REMOLQUE -- SERVICIO via ASIGNACION | **Rectangulo** (entidad asociativa) |

### 5.4 Relaciones 1:N deliberadas frente a posibles N:M

| Relacion | Decision | Razon |
|---|---|---|
| FACTURA -- SERVICIO (R-05 AGRUPA_SERVICIOS) | 1:N | Cada servicio se factura en una unica factura. Facturacion parcial fuera de alcance. |
| SERVICIO -- REQUISITO_ESPECIAL (R-10 REQUIERE_CONDICION) | 1:N | Requisitos son instancias especificas de cada servicio, no catalogo reutilizable. |
| SERVICIO -- MERCANCIA (R-09 CONTIENE_MERCANCIA) | 1:N | Cada lote describe la carga real de un servicio concreto, no es catalogo. |

---

## 6. Correspondencia entre requerimientos funcionales y entidades

| Requerimiento | Entidades que lo cubren |
|---|---|
| RF-001 Registrar clientes | CLIENTE |
| RF-002 Gestionar contactos | CONTACTO, R-01 |
| RF-003 Gestionar direcciones operativas | DIRECCION_OPERATIVA, R-02 |
| RF-004 Registrar servicios | SERVICIO |
| RF-005 Puntos de recogida y entrega con ventanas | PUNTO_SERVICIO, R-06 |
| RF-006 Niveles de urgencia y compromisos | Atrib. nivel_urgencia en SERVICIO |
| RF-007 Informacion de la mercancia (incluyendo varios lotes por servicio) | MERCANCIA, R-09 (1:N) |
| RF-008 Requisitos operativos especiales | REQUISITO_ESPECIAL, R-10 |
| RF-009 Estado actual del servicio | Atrib. estado_actual en SERVICIO |
| RF-010 Eventos de seguimiento e historial | EVENTO_SEGUIMIENTO, R-08 |
| RF-011 Consultar estado e historial | SERVICIO + EVENTO_SEGUIMIENTO + R-08 |
| RF-012 Registrar vehiculos | VEHICULO |
| RF-013 Registrar remolques | REMOLQUE |
| RF-014 Registrar conductores | CONDUCTOR |
| RF-015 Disponibilidad de recursos | Atrib. estado_operativo (VEHICULO, REMOLQUE), estado_disponibilidad (CONDUCTOR) |
| RF-016 Asignar recursos a servicios | ASIGNACION, R-14, R-15, R-16, R-17 |
| RF-017 Historial de asignaciones | Multiples registros ASIGNACION + atrib. es_activa |
| RF-018 Registrar incidencias | INCIDENCIA, R-11 |
| RF-019 Ciclo de vida de incidencias | Atrib. estado, prioridad, responsable_gestion en INCIDENCIA |
| RF-020 Resolucion de incidencias | Atrib. descripcion_resolucion, fecha_cierre en INCIDENCIA |
| RF-021 Costes operativos imputados | COSTE_OPERATIVO, R-12 |
| RF-022 Coste total del servicio | Suma de COSTE_OPERATIVO agrupada por id_servicio |
| RF-023 Registrar facturas | FACTURA, R-04 |
| RF-024 Seguimiento de cobros | Atrib. estado_cobro, fecha_cobro en FACTURA |
| RF-025 Facturacion por cliente y periodo | FACTURA + R-04 (join con CLIENTE) |
| RF-026 Documentacion de servicios | DOCUMENTO_SERVICIO, R-13 |
| RF-027 Documentacion con vigencia de recursos | DOCUMENTO_RECURSO, R-18, R-19, R-20 |
| RF-028 Alertas y control de caducidades | Atrib. fecha_caducidad en DOCUMENTO_RECURSO |
| RF-029 Requisitos especiales con vigencia | Atrib. verificacion_obligatoria en REQUISITO_ESPECIAL |
| RF-030 Auditoria interna | REGISTRO_AUDITORIA |