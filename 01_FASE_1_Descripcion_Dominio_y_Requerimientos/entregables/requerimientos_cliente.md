# Requerimientos del Cliente

**Proyecto:** Base de Datos para Empresa de Transporte Intracomunitario por Carretera (UE)
**Fase:** 1 - Descripcion del Dominio y Requerimientos
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora

---

## 1. Requerimientos Funcionales

### Gestion de Clientes

**RF-001 - Registrar clientes**
La base de datos debe permitir registrar la informacion de cada cliente: nombre o razon social, CIF/NIF, pais de registro, datos de contacto principal y condiciones comerciales generales.

**RF-002 - Gestionar contactos de clientes**
Cada cliente puede tener multiples personas de contacto. La base de datos debe permitir registrar y gestionar estos contactos indicando nombre, cargo, telefono y correo electronico.

**RF-003 - Gestionar direcciones operativas de clientes**
Un cliente puede operar desde multiples ubicaciones. La base de datos debe permitir registrar estas direcciones y asociarlas a los puntos de recogida o entrega de los servicios.

### Gestion de Servicios de Transporte

**RF-004 - Registrar servicios de transporte**
La base de datos debe permitir crear un registro por cada servicio de transporte, con su numero de servicio interno, fecha de solicitud, cliente solicitante, tipo de servicio y estado actual.

**RF-005 - Registrar puntos de recogida y entrega**
Cada servicio puede tener uno o varios puntos de recogida y uno o varios puntos de entrega. La base de datos debe registrar cada punto con su direccion, tipo, ventana horaria acordada y orden dentro de la ruta.

**RF-006 - Registrar informacion de la mercancia**
Para cada servicio se debe poder registrar la descripcion de la mercancia, el numero de bultos o palets, el peso estimado, el volumen aproximado y cualquier requisito especial.

**RF-007 - Gestionar el estado de un servicio**
La base de datos debe registrar el estado actual de cada servicio y mantener un historial de los cambios de estado con fecha y hora de cada transicion.

**RF-008 - Consultar servicios por cliente, fecha y estado**
Debe ser posible filtrar y consultar servicios por cliente, rango de fechas, estado actual y tipo de servicio.

### Gestion de Recursos

**RF-009 - Registrar vehiculos de la flota**
La base de datos debe registrar cada vehiculo con su matricula, tipo, marca, modelo, capacidad de carga maxima y estado operativo actual.

**RF-010 - Controlar documentacion y caducidades de vehiculos**
Para cada vehiculo se deben registrar los documentos con fecha de caducidad: permiso de circulacion, seguro, ITV, calibracion del tacografo.

**RF-011 - Registrar remolques y semirremolques**
La base de datos debe registrar cada remolque con su matricula, tipo, capacidad y estado.

**RF-012 - Registrar conductores**
La base de datos debe registrar la informacion de cada conductor: nombre, numero de empleado, numero de permiso de conducir, fecha de nacimiento y datos de contacto.

**RF-013 - Controlar documentacion y caducidades de conductores**
Para cada conductor se deben registrar los documentos con fecha de caducidad: permiso de conducir, tarjeta de cualificacion del conductor (CAP), tarjeta de tacografo digital.

**RF-014 - Gestionar disponibilidad de vehiculos y conductores**
La base de datos debe registrar si un vehiculo o conductor esta disponible, asignado, en mantenimiento o de baja, para evitar dobles asignaciones.

### Asignacion de Recursos a Servicios

**RF-015 - Asignar conductor y vehiculo a un servicio**
La base de datos debe registrar la asignacion de un conductor y un vehiculo a cada servicio, con la fecha y hora de asignacion.

**RF-016 - Registrar cambios de asignacion**
Debe ser posible modificar la asignacion de recursos a un servicio manteniendo un registro historico de todas las asignaciones realizadas.

### Gestion de Incidencias

**RF-017 - Registrar incidencias asociadas a servicios**
La base de datos debe permitir crear un registro de incidencia vinculado a un servicio, con su tipo, descripcion, fecha y hora de apertura.

**RF-018 - Gestionar el estado de las incidencias**
Cada incidencia debe poder transicionar entre estados con registro de quien realizo el cambio y cuando.

**RF-019 - Registrar la resolucion de incidencias**
Al cerrar una incidencia se debe registrar la descripcion de la resolucion adoptada y la fecha de cierre.

### Gestion de Costes Operativos

**RF-020 - Registrar costes asociados a servicios**
La base de datos debe permitir imputar costes operativos a cada servicio: combustible, peajes, dietas, reparaciones urgentes. Cada coste debe registrarse con su tipo, importe, fecha y descripcion.

**RF-021 - Consultar costes totales por servicio**
Debe ser posible obtener el coste operativo total de un servicio sumando todos los costes imputados.

### Facturacion y Cobros

**RF-022 - Registrar facturas emitidas a clientes**
Por cada servicio completado se debe poder registrar la factura emitida: numero, fecha de emision, importe, impuestos y fecha de vencimiento.

**RF-023 - Registrar el estado de cobro de facturas**
La base de datos debe permitir registrar si una factura ha sido cobrada, con la fecha de cobro, o si esta pendiente o en mora.

**RF-024 - Consultar facturacion por cliente y periodo**
Debe ser posible consultar el total facturado a un cliente en un periodo determinado y el estado de cobro de sus facturas.

### Control Documental y Auditoria

**RF-025 - Registrar documentos asociados a servicios**
Para cada servicio se debe poder registrar la existencia de los documentos de transporte asociados (CMR, albaranes) con indicacion de si estan recibidos y archivados.

**RF-026 - Registrar requisitos especiales de servicios**
La base de datos debe permitir registrar condicionantes operativos especificos de cada servicio y vincularlos a el.

**RF-027 - Registrar eventos de auditoria interna**
La base de datos debe mantener un registro de las operaciones criticas realizadas para permitir la trazabilidad y la auditoria interna.

---

## 2. Requerimientos No Funcionales

### Rendimiento

**RNF-001 - Tiempo de respuesta en consultas habituales**
Las consultas mas frecuentes del sistema deben resolverse en un tiempo razonable incluso con el volumen de datos propio de varios anos de operativa acumulada.

**RNF-002 - Eficiencia en consultas de planificacion**
Las consultas que determinan la disponibilidad de vehiculos y conductores para una fecha dada deben ser suficientemente eficientes para no ralentizar el proceso de planificacion diaria.

### Integridad de Datos

**RNF-003 - Integridad referencial**
La base de datos debe garantizar que no pueden existir registros huerfanos: cada entidad dependiente debe estar vinculada a una entidad padre existente.

**RNF-004 - Restricciones de valor en campos criticos**
Los campos que admiten un conjunto cerrado de valores deben validarse mediante restricciones a nivel de base de datos, impidiendo la insercion de valores no definidos.

**RNF-005 - Obligatoriedad de datos esenciales**
Los datos minimos imprescindibles para que un registro sea coherente deben marcarse como obligatorios.

### Consistencia

**RNF-006 - Consistencia transaccional**
Las operaciones que modifican varios registros de forma relacionada deben tratarse como transacciones atomicas.

**RNF-007 - Historial de estados coherente**
El historial de estados de un servicio o incidencia debe reflejar fielmente la secuencia real de eventos, sin saltos ni contradicciones cronologicas.

### Escalabilidad

**RNF-008 - Capacidad de crecimiento del volumen de datos**
La estructura de la base de datos debe acomodar el crecimiento natural de la operativa a lo largo de varios anos sin necesidad de redisenos estructurales.

**RNF-009 - Diseno normalizado como base de escalabilidad**
La normalizacion del esquema relacional hasta 3FN garantiza que el crecimiento de datos no introduzca redundancias ni anomalias de actualizacion.

### Seguridad Basica

**RNF-010 - Control de acceso por perfil de usuario**
El sistema debe implementar un control de acceso con distintos niveles de permisos segun el departamento.

**RNF-011 - Proteccion de datos personales**
La informacion personal de conductores y contactos de clientes debe tratarse conforme al RGPD.

**RNF-012 - Registro de operaciones criticas**
Las operaciones que modifican datos sensibles deben quedar registradas para permitir la trazabilidad.

---

## 3. Resumen de Requerimientos

| Codigo | Tipo | Area | Descripcion breve |
|---|---|---|---|
| RF-001 | Funcional | Clientes | Registrar clientes |
| RF-002 | Funcional | Clientes | Gestionar contactos de clientes |
| RF-003 | Funcional | Clientes | Gestionar direcciones operativas |
| RF-004 | Funcional | Servicios | Registrar servicios de transporte |
| RF-005 | Funcional | Servicios | Registrar puntos de recogida y entrega |
| RF-006 | Funcional | Servicios | Registrar informacion de mercancia |
| RF-007 | Funcional | Servicios | Gestionar estados de servicios |
| RF-008 | Funcional | Servicios | Consultar servicios por filtros |
| RF-009 | Funcional | Flota | Registrar vehiculos |
| RF-010 | Funcional | Flota | Controlar documentacion de vehiculos |
| RF-011 | Funcional | Flota | Registrar remolques |
| RF-012 | Funcional | Conductores | Registrar conductores |
| RF-013 | Funcional | Conductores | Controlar documentacion de conductores |
| RF-014 | Funcional | Recursos | Gestionar disponibilidad de recursos |
| RF-015 | Funcional | Planificacion | Asignar recursos a servicios |
| RF-016 | Funcional | Planificacion | Registrar cambios de asignacion |
| RF-017 | Funcional | Incidencias | Registrar incidencias |
| RF-018 | Funcional | Incidencias | Gestionar estados de incidencias |
| RF-019 | Funcional | Incidencias | Registrar resolucion de incidencias |
| RF-020 | Funcional | Costes | Registrar costes operativos |
| RF-021 | Funcional | Costes | Consultar costes por servicio |
| RF-022 | Funcional | Facturacion | Registrar facturas emitidas |
| RF-023 | Funcional | Facturacion | Registrar estado de cobros |
| RF-024 | Funcional | Facturacion | Consultar facturacion por cliente |
| RF-025 | Funcional | Documentacion | Registrar documentos de servicios |
| RF-026 | Funcional | Documentacion | Registrar requisitos especiales |
| RF-027 | Funcional | Auditoria | Registrar eventos de auditoria |
| RNF-001 | No funcional | Rendimiento | Tiempo de respuesta en consultas |
| RNF-002 | No funcional | Rendimiento | Eficiencia en planificacion |
| RNF-003 | No funcional | Integridad | Integridad referencial |
| RNF-004 | No funcional | Integridad | Restricciones de valor |
| RNF-005 | No funcional | Integridad | Obligatoriedad de datos esenciales |
| RNF-006 | No funcional | Consistencia | Consistencia transaccional |
| RNF-007 | No funcional | Consistencia | Historial de estados coherente |
| RNF-008 | No funcional | Escalabilidad | Capacidad de crecimiento |
| RNF-009 | No funcional | Escalabilidad | Diseno normalizado |
| RNF-010 | No funcional | Seguridad | Control de acceso por perfil |
| RNF-011 | No funcional | Seguridad | Proteccion de datos personales |
| RNF-012 | No funcional | Seguridad | Registro de operaciones criticas |