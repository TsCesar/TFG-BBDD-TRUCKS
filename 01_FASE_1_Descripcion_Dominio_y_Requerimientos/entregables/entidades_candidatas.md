# Entidades Candidatas

**Proyecto:** Diseno, creacion y explotacion de una base de datos para la gestion integral
de una empresa de transporte intracomunitario por carretera (UE) en MySQL (phpMyAdmin)
**Fase:** 1 - Descripcion del dominio y requerimientos del cliente
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora - Curso 2024-26

> Este documento identifica las entidades candidatas del sistema de forma narrativa.
> Los atributos, claves y relaciones formales se definen en la FASE 2 (Modelo Conceptual).

---

## 1. Criterio de identificacion

Una entidad candidata es un objeto, concepto o actor del mundo real sobre el que la empresa
necesita almacenar informacion de forma persistente. Las entidades identificadas en este
documento se derivan directamente del **contenido previsto de la base de datos** descrito
en la propuesta oficial del TFG, que organiza el alcance en ocho areas funcionales.

---

## 2. Area 1: Clientes y terceros

### CLIENTE
Representa a cada empresa o persona que contrata servicios de transporte con la operadora.
Es el actor externo principal del sistema. Un cliente tiene datos de identificacion fiscal,
condiciones comerciales y puede generar multiples servicios y facturas a lo largo del tiempo.

### CONTACTO
Representa a las personas fisicas dentro de una empresa cliente con las que la operadora
se relaciona en el dia a dia (responsables de logistica, compras, administracion, etc.).
Un cliente puede tener varios contactos y es necesario saber a quien dirigirse segun
el tipo de gestion.

### DIRECCION_OPERATIVA
Representa las ubicaciones fisicas desde las que opera un cliente: almacenes, plantas de
produccion, delegaciones y centros de distribucion. Estas direcciones se utilizan como
puntos de origen o destino habituales en los servicios de transporte. Un cliente puede
tener varias direcciones operativas registradas.

---

## 3. Area 2: Servicios y seguimiento

### SERVICIO
Es la entidad central del sistema. Representa cada operacion de transporte contratada por
un cliente, desde su solicitud hasta su cierre y facturacion. Integra la informacion
operativa del encargo: quien lo contrata, cuando, con que nivel de urgencia y en que estado
se encuentra. Todo el resto del sistema orbita alrededor de esta entidad.

### PUNTO_SERVICIO
Representa cada parada individual dentro de un servicio de transporte: puede ser una
recogida o una entrega. Un servicio puede tener uno o varios puntos de cada tipo. Cada
punto tiene su propia direccion, tipo de operacion (recogida/entrega), orden en la ruta,
ventana horaria acordada y estado de ejecucion. Es una entidad independiente porque
los servicios multipunto son habituales en el sector.

### EVENTO_SEGUIMIENTO
Representa cada evento relevante registrado durante el ciclo de vida de un servicio:
cambios de estado, confirmaciones de recogida, llegadas a puntos intermedios, entregas
realizadas y cualquier otro hito de seguimiento. Constituye el historial de trazabilidad
del servicio, permitiendo reconstruir su evolucion en cualquier momento.

---

## 4. Area 3: Mercancia y requisitos

### MERCANCIA
Representa la descripcion de la carga asociada a un servicio: tipo, cantidad, peso,
volumen y caracteristicas generales. No es un catalogo de productos sino la descripcion
operativa de lo que se transporta en cada servicio concreto. Un servicio puede tener
una o varias descripciones de mercancia: en servicios FTL habitualmente hay un unico
tipo de carga, pero en servicios LTL el vehiculo puede transportar mercancia de tipos
distintos perteneciente a diferentes expedidores. Se identifica como entidad independiente
de SERVICIO para mantener separada la informacion del encargo operativo de la descripcion
fisica de la carga, y para permitir multiples registros de carga por servicio.

### REQUISITO_ESPECIAL
Representa los condicionantes operativos especificos que afectan a la ejecucion de un
servicio: rangos de temperatura de transporte, instrucciones de manipulacion especial,
seguros adicionales, restricciones de acceso o cualquier condicion particular documentada.
La propuesta contempla explicitamente los requisitos operativos especiales como parte
del alcance de la base de datos, vinculados directamente al servicio de transporte.
Un servicio puede tener cero o varios requisitos especiales de tipos distintos.

---

## 5. Area 4: Incidencias

### INCIDENCIA
Representa cualquier evento no planificado que afecta al desarrollo normal de un servicio
durante su ejecucion: averias mecanicas, retenciones en frontera, problemas en la carga
o descarga, mercancia danada, negativas de recepcion, etc. Las incidencias tienen su
propio ciclo de vida (apertura, gestion, resolucion, cierre) con trazabilidad de cada
cambio de estado, tal como exige la propuesta oficial.

---

## 6. Area 5: Recursos

### VEHICULO
Representa cada unidad de motor de la flota propia: cabezas tractoras y vehiculos rigidos.
La empresa necesita conocer su estado operativo, disponibilidad para asignacion y
documentacion vigente. Es un recurso clave de la operativa diaria.

### REMOLQUE
Representa los elementos de carga que se acoplan a las cabezas tractoras: semirremolques
de lona, frigorificos, cisternas, portacoches, etc. Se gestionan de forma independiente
a los vehiculos tractores porque la combinacion puede variar en cada servicio y cada uno
tiene su propia documentacion con fechas de caducidad independientes.

### CONDUCTOR
Representa a cada conductor profesional de la plantilla de la empresa. La empresa necesita
gestionar su disponibilidad, su documentacion habilitante con fechas de caducidad y su
vinculacion a los servicios realizados.

### ASIGNACION
Representa el acto formal de vincular un conductor y un vehiculo (y opcionalmente un
remolque) a un servicio concreto. Se identifica como entidad independiente porque
registra datos propios (fecha de asignacion, estado activa/historica) y puede haber
varias asignaciones historicas para un mismo servicio si se producen cambios de recursos.
La propuesta menciona explicitamente las "asignaciones operativas" como parte del
contenido de la base de datos.

### CATEGORIA_PERMISO
Representa cada tipo de habilitacion de conduccion reconocida oficialmente para el
transporte por carretera: C (camiones rigidos), CE (vehiculo articulado), C1, C1E, D
(autobuses), B+E, etc. Un conductor puede poseer varias categorias y una misma categoria
puede pertenecer a muchos conductores. Esto crea una relacion muchos a muchos entre
CONDUCTOR y CATEGORIA_PERMISO que no puede representarse correctamente con un simple
campo de texto en CONDUCTOR. Se identifica como entidad de catalogo para poder consultar,
por ejemplo, todos los conductores habilitados para una categoria concreta.

---

## 7. Area 6: Costes operativos

### COSTE_OPERATIVO
Representa cada gasto directo imputable a un servicio especifico: combustible, peajes,
dietas del conductor, reparaciones urgentes en ruta, etc. Se identifica como entidad
independiente porque cada servicio puede generar multiples costes de distintos tipos y
su registro permite calcular la rentabilidad real de cada operacion.

---

## 8. Area 7: Facturacion y cobros

### FACTURA
Representa el documento de cobro emitido a un cliente por uno o varios servicios
completados. Tiene su propio ciclo de vida economico (pendiente, cobrada, vencida,
en mora) y sus datos fiscales propios. La propuesta contempla explicitamente la
facturacion de servicios y el seguimiento de cobros como parte del alcance.

---

## 9. Area 8: Documentacion y control interno

### DOCUMENTO_SERVICIO
Representa los documentos de transporte vinculados a un servicio: carta de porte CMR,
albaranes de entrega firmados, partes de incidencia formalizados, evidencias adicionales
(fotos, registros de temperatura, certificados). La propuesta contempla explicitamente
la "documentacion asociada a servicios" y las "evidencias" como parte del control interno.

### DOCUMENTO_RECURSO
Representa la documentacion con fecha de caducidad vinculada a vehiculos, remolques
y conductores: permisos de circulacion, seguros, ITV, calibracion de tacografo, permiso
de conducir, tarjeta de cualificacion del conductor (CAP), tarjeta de tacografo digital.
La propuesta menciona explicitamente las "vigencias/caducidades" como elemento del
control interno de la empresa.

### REGISTRO_AUDITORIA
Representa los registros de control de las operaciones criticas realizadas sobre el
sistema: creacion y modificacion de servicios, cambios de estado, asignacion de recursos,
registro de facturas y costes. Cada registro identifica la operacion, la entidad afectada,
el usuario responsable y la fecha y hora. La propuesta contempla explicitamente los
"registros de auditoria interna" como parte del control interno.

---

## 10. Resumen de entidades candidatas

| # | Entidad | Area funcional (propuesta) |
|:---:|---|---|
| 1 | CLIENTE | Clientes y terceros |
| 2 | CONTACTO | Clientes y terceros |
| 3 | DIRECCION_OPERATIVA | Clientes y terceros |
| 4 | SERVICIO | Servicios y seguimiento |
| 5 | PUNTO_SERVICIO | Servicios y seguimiento |
| 6 | EVENTO_SEGUIMIENTO | Servicios y seguimiento |
| 7 | MERCANCIA | Mercancia y requisitos |
| 8 | REQUISITO_ESPECIAL | Mercancia y requisitos |
| 9 | INCIDENCIA | Incidencias |
| 10 | VEHICULO | Recursos |
| 11 | REMOLQUE | Recursos |
| 12 | CONDUCTOR | Recursos |
| 13 | ASIGNACION | Recursos (entidad asociativa) |
| 14 | CATEGORIA_PERMISO | Recursos (catalogo habilitaciones) |
| 15 | COSTE_OPERATIVO | Costes operativos |
| 16 | FACTURA | Facturacion y cobros |
| 17 | DOCUMENTO_SERVICIO | Documentacion y control interno |
| 18 | DOCUMENTO_RECURSO | Documentacion y control interno |
| 19 | REGISTRO_AUDITORIA | Documentacion y control interno |

---

## 11. Relaciones narrativas preliminares

Sin entrar en cardinalidades formales (que se definen en FASE 2):

- Un **CLIENTE** puede tener varios **CONTACTOS** y varias **DIRECCIONES_OPERATIVAS**.
- Un **CLIENTE** puede generar varios **SERVICIOS** y varias **FACTURAS**.
- Un **SERVICIO** tiene uno o varios **PUNTOS_SERVICIO**.
- Un **SERVICIO** genera uno o varios **EVENTOS_SEGUIMIENTO** (historial).
- Un **SERVICIO** puede tener una o varias **MERCANCIAS** asociadas (en servicios LTL pueden coexistir varios tipos de carga distintos).
- Un **SERVICIO** puede tener cero o varios **REQUISITOS_ESPECIALES** vinculados directamente al servicio.
- Un **SERVICIO** puede generar varias **INCIDENCIAS**.
- Un **SERVICIO** puede tener varios **COSTES_OPERATIVOS** imputados.
- Un **SERVICIO** puede tener varios **DOCUMENTOS_SERVICIO** vinculados.
- Un **SERVICIO** puede tener varias **ASIGNACIONES** (activa e historicas).
- Una **ASIGNACION** vincula un **CONDUCTOR**, un **VEHICULO** y opcionalmente un **REMOLQUE**.
- Un **CONDUCTOR** puede tener varias **CATEGORIAS_PERMISO** y una misma categoria puede pertenecer a muchos conductores (relacion muchos a muchos: POSEE_CATEGORIA).
- Una **FACTURA** puede agrupar varios **SERVICIOS** de un mismo cliente (relacion AGRUPA_SERVICIOS).
- **VEHICULOS**, **REMOLQUES** y **CONDUCTORES** pueden tener varios **DOCUMENTOS_RECURSO** con caducidad.
- El sistema genera **REGISTROS_AUDITORIA** para las operaciones criticas sobre los datos.