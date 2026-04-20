# Casos de Uso por Departamento

**Proyecto:** Base de Datos para Empresa de Transporte Intracomunitario por Carretera (UE)
**Fase:** 1 - Descripcion del Dominio y Requerimientos
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora

> **Nota metodologica:** Este documento describe a nivel funcional que operaciones realiza cada departamento sobre la base de datos en su actividad diaria. No constituye un diagrama de casos de uso UML formal. Su objetivo es validar que los requerimientos funcionales cubren todas las necesidades reales de los usuarios del sistema.

---

## 1. Departamento de Operaciones / Trafico

Es el departamento con mayor intensidad de uso de la base de datos. Su actividad gira en torno a la planificacion de servicios, la asignacion de recursos y el seguimiento operativo.

**Crear un nuevo servicio**
Registra el servicio con todos los datos de la solicitud: cliente, puntos de recogida y entrega con sus ventanas horarias, caracteristicas de la mercancia y requisitos especiales. El servicio queda en estado "pendiente de asignar".

**Consultar disponibilidad de recursos**
Antes de asignar un servicio, consulta que vehiculos y conductores estan disponibles para la fecha requerida y con la documentacion en vigor.

**Asignar conductor y vehiculo a un servicio**
Registra la asignacion en la base de datos, vinculando el servicio con el conductor, el vehiculo y, si procede, el remolque. El estado del servicio pasa a "asignado".

**Actualizar el estado de un servicio**
A medida que el servicio avanza, actualiza el estado en la base de datos. Cada cambio queda registrado en el historial con fecha y hora.

**Registrar una incidencia**
Cuando el conductor comunica un problema, crea un registro de incidencia vinculado al servicio con el tipo y la descripcion del problema.

**Gestionar y cerrar incidencias**
Realiza el seguimiento de las incidencias abiertas, actualiza su estado y registra la resolucion cuando el problema queda resuelto.

**Consultar el historico de servicios**
Para reuniones operativas, analisis de rendimiento o resolucion de disputas, consulta el historial por cliente, conductor, vehiculo o periodo.

**Alertas de documentacion proxima a caducar**
Consulta periodicamente que documentos de vehiculos o conductores estan proximos a caducar para iniciar las gestiones de renovacion.

---

## 2. Departamento de Atencion al Cliente / Comercial

Punto de contacto entre la empresa y sus clientes. Necesita acceso rapido a informacion actualizada sobre el estado de los servicios y el historial del cliente.

**Consultar el estado de un servicio**
Cuando un cliente consulta por el estado de un envio, accede al servicio en la base de datos e informa sobre su estado actual, ultimo punto completado y cualquier incidencia activa.

**Registrar un nuevo cliente**
Al cerrar un acuerdo comercial nuevo, registra los datos de la empresa, contactos y direcciones operativas.

**Actualizar informacion de clientes**
Cuando un cliente cambia de direccion, contacto o condiciones comerciales, actualiza los datos en la base de datos.

**Consultar el historial de servicios de un cliente**
Para revisiones comerciales o respuesta a reclamaciones, consulta todos los servicios realizados para un cliente en un periodo determinado.

**Gestionar reclamaciones de clientes**
Vincula la reclamacion al servicio correspondiente, consultando el historial de estados, las incidencias y la documentacion de entrega para dar una respuesta fundamentada.

---

## 3. Departamento de Flota y Mantenimiento

Responsable de la gestion tecnica y documental de vehiculos y remolques.

**Consultar el estado de cada vehiculo y remolque**
Comprueba que vehiculos estan en servicio, en mantenimiento o disponibles para planificar revisiones sin afectar a la operativa.

**Registrar intervenciones de mantenimiento**
Registra cada intervencion de taller con su fecha, tipo y coste, vinculandola al vehiculo correspondiente.

**Actualizar documentacion de vehiculos y remolques**
Cuando se renueva un seguro, se supera una ITV o se calibra un tacografo, actualiza el documento con la nueva fecha de caducidad.

**Consultar alertas de documentacion proxima a caducar**
Revisa periodicamente que documentos de vehiculos o remolques caducan proximamente para programar las gestiones de renovacion.

**Registrar alta y baja de vehiculos y remolques**
Registra los nuevos activos incorporados a la flota y actualiza el estado de los que salen (venta, baja definitiva), conservando su historial.

---

## 4. Departamento de Recursos Humanos

Gestiona la informacion laboral y operativa de los conductores.

**Registrar un conductor nuevo**
Al incorporar un nuevo conductor, registra sus datos personales y su documentacion habilitante inicial.

**Actualizar documentacion de conductores**
Cuando un conductor renueva un documento, actualiza el registro con la nueva fecha de caducidad.

**Consultar alertas de documentacion proxima a caducar**
Revisa que documentos de conductores caducan proximamente para iniciar los tramites de renovacion con antelacion.

**Gestionar la disponibilidad de conductores**
Registra periodos de vacaciones, bajas medicas u otras situaciones de no disponibilidad para que el departamento de trafico no los asigne por error.

**Gestionar bajas de conductores**
Cuando un conductor causa baja, actualiza su estado para que no aparezca como recurso disponible, conservando su historial operativo.

---

## 5. Departamento de Finanzas y Administracion

Responsable del control economico: facturacion, costes y cobros.

**Consultar servicios completados pendientes de facturar**
Consulta periodicamente que servicios estan completados y pendientes de generar factura.

**Registrar facturas emitidas**
Registra las facturas vinculandolas a los servicios correspondientes, con numero, importe, fecha de emision y vencimiento.

**Actualizar el estado de cobro de facturas**
Registra el cobro de las facturas pagadas y marca como vencidas o en mora las que superan su fecha de vencimiento.

**Consultar la facturacion por cliente y periodo**
Para analisis financieros o cierre contable, consulta el total facturado por cliente y el estado de cobro de sus facturas.

**Consultar costes operativos por servicio**
Para calcular el margen de cada servicio, consulta los costes imputados y los compara con el importe facturado al cliente.

**Analizar rentabilidad**
Cruzando facturacion y costes, obtiene informacion sobre la rentabilidad de cada cliente o tipo de servicio para apoyar decisiones estrategicas.

---

## 6. Departamento de Cumplimiento y Calidad

Responsable del control documental, el cumplimiento normativo y la auditoria interna.

**Verificar documentacion completa de servicios**
Comprueba que los servicios completados tienen asociados todos los documentos requeridos, marcando los que tienen documentacion incompleta.

**Consultar el historial de incidencias**
Analiza las incidencias de un periodo para identificar patrones, evaluar la calidad del servicio y proponer mejoras.

**Consultar el registro de auditoria**
Revisa el registro de operaciones criticas del sistema para verificar que los procesos se siguen correctamente.

**Controlar el cumplimiento documental de flota y conductores**
Verifica que todos los vehiculos y conductores tienen la documentacion obligatoria en vigor.

**Generar informes de calidad**
A partir de los datos de la base de datos (incidencias, tiempos de resolucion, cumplimiento de ventanas horarias) elabora informes de calidad para la direccion.

---

## 7. Sintesis: Operaciones por Departamento

| Departamento | Operaciones principales |
|---|---|
| Operaciones / Trafico | Crear servicios, asignar recursos, actualizar estados, gestionar incidencias, alertas de caducidades |
| Atencion al cliente / Comercial | Consultar estado de servicios, gestionar clientes, resolver reclamaciones |
| Flota / Mantenimiento | Gestionar vehiculos y remolques, registrar mantenimientos, controlar documentacion |
| Recursos Humanos | Gestionar conductores, controlar documentacion y disponibilidad |
| Finanzas / Administracion | Facturar servicios, controlar cobros, analizar costes y rentabilidad |
| Cumplimiento / Calidad | Verificar documentacion, auditar procesos, analizar incidencias, informes de calidad |