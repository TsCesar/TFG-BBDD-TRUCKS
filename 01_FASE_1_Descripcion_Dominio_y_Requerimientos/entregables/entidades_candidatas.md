# Entidades Candidatas

**Proyecto:** Base de Datos para Empresa de Transporte Intracomunitario por Carretera (UE)
**Fase:** 1 - Descripcion del Dominio y Requerimientos
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora

> **Nota metodologica:** Este documento identifica de forma narrativa las entidades candidatas del sistema. No contiene atributos, claves ni relaciones formales. Ese nivel de detalle se desarrollara en la FASE 2 mediante el Diagrama Entidad-Relacion.

---

## 1. Criterio de Identificacion

Una entidad candidata es un objeto, concepto o actor del mundo real sobre el que la empresa necesita almacenar informacion de forma persistente. Para identificarlas se han analizado el flujo operativo descrito en descripcion_dominio.md, los requerimientos funcionales de requerimientos_cliente.md y los actores y recursos que intervienen en la operativa diaria.

---

## 2. Listado de Entidades Candidatas

### CLIENTE
Representa a cada empresa o persona que contrata servicios de transporte con la operadora. Es el actor externo principal del sistema. Un cliente puede generar multiples servicios a lo largo del tiempo.

### CONTACTO
Representa a las personas fisicas dentro de una empresa cliente con las que la operadora se relaciona en el dia a dia. Un cliente puede tener varios contactos.

### DIRECCION_OPERATIVA
Representa las ubicaciones fisicas desde las que opera un cliente: almacenes, plantas de produccion, delegaciones, centros de distribucion. Un cliente puede tener varias direcciones operativas.

### SERVICIO
Es la entidad central del sistema. Representa cada operacion de transporte contratada por un cliente, desde su solicitud hasta su cierre y facturacion. Todo el resto del sistema orbita alrededor de esta entidad.

### PUNTO_SERVICIO
Representa cada parada individual dentro de un servicio: puede ser una recogida o una entrega. Un servicio puede tener uno o varios puntos de cada tipo. Se identifica como entidad independiente porque un servicio puede ser multipunto.

### MERCANCIA
Representa las caracteristicas de la carga asociada a un servicio. No es un inventario de productos, sino una descripcion operativa de la carga de cada servicio.

### VEHICULO
Representa cada unidad de motor de la flota propia: cabezas tractoras y vehiculos rigidos. Es un recurso clave de la operativa.

### REMOLQUE
Representa los elementos de carga que se acoplan a las cabezas tractoras. Se gestionan de forma independiente a los vehiculos de motor porque la combinacion tractora-remolque puede variar en cada servicio.

### CONDUCTOR
Representa a cada conductor profesional de la plantilla. La empresa necesita gestionar su disponibilidad, su documentacion habilitante con fechas de caducidad y su vinculacion a los servicios que realiza.

### ASIGNACION
Representa el acto formal de vincular un conductor y un vehiculo a un servicio concreto. Se identifica como entidad independiente porque puede haber varias asignaciones historicas para un mismo servicio y registra datos propios como la fecha de asignacion.

### INCIDENCIA
Representa cualquier evento no planificado que afecta al desarrollo normal de un servicio durante su ejecucion. Un servicio puede tener cero o varias incidencias, cada una con su propia trazabilidad.

### COSTE_OPERATIVO
Representa cada gasto directo imputable a un servicio especifico. Se identifica como entidad independiente porque cada servicio puede generar multiples costes de distintos tipos.

### FACTURA
Representa el documento de cobro emitido a un cliente por uno o varios servicios completados. Tiene su propio ciclo de vida economico y sus propios datos fiscales.

### DOCUMENTO_SERVICIO
Representa los documentos de transporte asociados a un servicio: cartas de porte CMR, albaranes de entrega firmados, partes de incidencia formalizados.

### REQUISITO_ESPECIAL
Representa los condicionantes operativos especificos que afectan a determinados servicios: temperatura de transporte, seguros adicionales, procedimientos especiales de carga.

### HISTORIAL_ESTADO_SERVICIO
Representa el registro cronologico de los cambios de estado de un servicio. Permite reconstruir el ciclo de vida completo del servicio a efectos de trazabilidad y auditoria.

### HISTORIAL_ESTADO_INCIDENCIA
Representa el registro cronologico de los cambios de estado de cada incidencia. Permite reconstruir como se gestiono cada incidencia.

### DOCUMENTO_RECURSO
Representa la documentacion con fecha de caducidad vinculada a vehiculos, remolques o conductores: permisos, seguros, ITV, tarjetas de tacografo, certificados CAP.

---

## 3. Resumen de Entidades Candidatas

| # | Entidad | Area funcional |
|:---:|---|---|
| 1 | CLIENTE | Gestion de clientes |
| 2 | CONTACTO | Gestion de clientes |
| 3 | DIRECCION_OPERATIVA | Gestion de clientes |
| 4 | SERVICIO | Operativa central |
| 5 | PUNTO_SERVICIO | Operativa central |
| 6 | MERCANCIA | Operativa central |
| 7 | VEHICULO | Gestion de flota |
| 8 | REMOLQUE | Gestion de flota |
| 9 | CONDUCTOR | Gestion de conductores |
| 10 | ASIGNACION | Planificacion |
| 11 | INCIDENCIA | Gestion de incidencias |
| 12 | COSTE_OPERATIVO | Control economico |
| 13 | FACTURA | Facturacion |
| 14 | DOCUMENTO_SERVICIO | Control documental |
| 15 | REQUISITO_ESPECIAL | Control documental |
| 16 | HISTORIAL_ESTADO_SERVICIO | Trazabilidad |
| 17 | HISTORIAL_ESTADO_INCIDENCIA | Trazabilidad |
| 18 | DOCUMENTO_RECURSO | Control documental / Caducidades |

---

## 4. Relaciones Narrativas Preliminares

Sin entrar en cardinalidades formales (FASE 2), se describen las relaciones principales:

- Un **CLIENTE** puede tener varios **CONTACTOS** y varias **DIRECCIONES_OPERATIVAS**.
- Un **CLIENTE** puede generar varios **SERVICIOS** a lo largo del tiempo.
- Un **SERVICIO** tiene uno o varios **PUNTOS_SERVICIO** (recogidas y entregas).
- Un **SERVICIO** tiene asociada informacion de **MERCANCIA**.
- Un **SERVICIO** puede tener uno o varios **REQUISITOS_ESPECIALES**.
- Un **SERVICIO** puede generar una o varias **INCIDENCIAS**.
- Un **SERVICIO** genera uno o varios registros de **HISTORIAL_ESTADO_SERVICIO**.
- Un **SERVICIO** puede tener asociados varios **COSTES_OPERATIVOS**.
- Un **SERVICIO** puede tener asociados varios **DOCUMENTOS_SERVICIO**.
- Un **SERVICIO** puede vincularse a una **FACTURA**.
- Un **SERVICIO** tiene una **ASIGNACION** activa que vincula un **CONDUCTOR** y un **VEHICULO**.
- Un **VEHICULO**, un **REMOLQUE** y un **CONDUCTOR** pueden tener varios **DOCUMENTOS_RECURSO**.
- Una **INCIDENCIA** genera uno o varios registros de **HISTORIAL_ESTADO_INCIDENCIA**.