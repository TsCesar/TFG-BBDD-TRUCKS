# Casos de Uso por Departamento

**Proyecto:** Diseno, creacion y explotacion de una base de datos para la gestion integral
de una empresa de transporte intracomunitario por carretera (UE) en MySQL (phpMyAdmin)
**Fase:** 1 - Descripcion del dominio y requerimientos del cliente
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora - Curso 2023-24

---

## 1. Departamento de Operaciones / Trafico

Es el departamento con mayor intensidad de uso de la base de datos. Su actividad diaria
gira en torno a la planificacion de servicios, la asignacion de recursos, el seguimiento
operativo en tiempo real y la gestion de incidencias.

**Crear un nuevo servicio**
Cuando un cliente solicita un transporte, el agente de trafico registra el servicio con
todos los datos de la solicitud: cliente, nivel de urgencia, puntos de recogida y entrega
con sus ventanas horarias, y requisitos especiales si los hay.

**Consultar disponibilidad de recursos**
Antes de asignar un servicio, el agente consulta que vehiculos, remolques y conductores
estan disponibles para la fecha requerida y con la documentacion en vigor.

**Asignar conductor, vehiculo y remolque a un servicio**
Registra la asignacion de recursos al servicio. El estado del servicio pasa de planificado
a asignado.

**Actualizar estados y registrar eventos de seguimiento**
A medida que el servicio avanza (inicio del trayecto, recogida completada, llegada a
destino, entrega realizada), el agente actualiza el estado y registra el evento de
seguimiento correspondiente. Cada evento queda en el historial del servicio.

**Registrar y gestionar incidencias**
Cuando el conductor comunica un problema, el agente crea la incidencia vinculada al
servicio con el tipo y la descripcion del problema, actualiza su estado durante la gestion
y registra la resolucion cuando el problema queda cerrado.

**Consultar historial completo de un servicio**
Para resolver dudas operativas o responder a reclamaciones, el agente consulta el
historial completo de un servicio: todos sus eventos de seguimiento, incidencias y
asignaciones.

**Control de caducidades de documentos de recursos**
El agente consulta periodicamente los documentos de vehiculos y conductores proximos
a caducar para iniciar las gestiones de renovacion con antelacion.

---

## 2. Departamento de Atencion al Cliente / Comercial

Es el punto de contacto entre la empresa y sus clientes. Necesita acceso rapido a
informacion actualizada sobre el estado de los servicios y el historial del cliente.

**Consultar el estado de un servicio**
Cuando un cliente consulta por el estado de un envio, el agente accede al servicio y
obtiene el estado actual, el ultimo evento de seguimiento registrado, la ventana horaria
del proximo punto y cualquier incidencia activa.

**Registrar y mantener clientes**
Al incorporar un nuevo cliente, el agente registra sus datos, contactos y direcciones
operativas. Actualiza estos datos cuando el cliente comunica cambios.

**Consultar el historial de servicios de un cliente**
Para revisiones comerciales, renovaciones de contrato o respuesta a reclamaciones,
el agente consulta todos los servicios realizados para un cliente en un periodo, incluyendo
incidencias, cumplimiento de ventanas horarias y resultados.

**Gestionar reclamaciones de clientes**
Ante una reclamacion, el agente consulta el historial del servicio: eventos de seguimiento,
incidencias con su resolucion y documentacion vinculada (CMR, albaranes) para dar una
respuesta fundamentada.

---

## 3. Departamento de Flota / Mantenimiento

Responsable de la gestion tecnica y documental de vehiculos y remolques, y del control
de costes asociados a la flota.

**Registrar y mantener vehiculos y remolques**
El responsable da de alta nuevos activos con sus datos tecnicos y documentacion inicial.
Actualiza el estado operativo segun se necesite (disponible, en mantenimiento, baja).

**Registrar intervenciones de mantenimiento**
Cuando un vehiculo o remolque pasa por taller (preventivo o correctivo), registra la
intervencion con su fecha, tipo y coste, vinculandola al recurso correspondiente.

**Controlar documentacion con caducidad de vehiculos y remolques**
Consulta periodicamente los documentos de vehiculos y remolques proximos a caducar
(ITV, seguro, tacografo) y registra los nuevos documentos cuando se renuevan.

**Consultar el estado operativo de la flota**
Obtiene un listado de los vehiculos y remolques disponibles, asignados o en
mantenimiento para apoyar la planificacion del departamento de trafico.

**Imputar costes de mantenimiento a servicios**
Cuando una reparacion urgente se produce durante un servicio, registra el coste
operativo imputado al servicio correspondiente.

---

## 4. Departamento de Finanzas

Responsable del control economico de la empresa: facturacion a clientes, registro
de costes y seguimiento de cobros.

**Consultar servicios completados pendientes de facturar**
Finanzas consulta los servicios completados y aun no facturados para emitir las
facturas segun los ciclos de facturacion acordados con cada cliente.

**Registrar facturas emitidas**
Registra cada factura vinculada a los servicios incluidos, con su numero, importe,
impuestos, fecha de emision y vencimiento.

**Gestionar el seguimiento de cobros**
Actualiza el estado de cobro de las facturas (cobrada, vencida, en mora) y registra
la fecha y metodo de cobro cuando el cliente paga.

**Analizar costes y rentabilidad por servicio**
Consulta los costes operativos imputados a cada servicio y los compara con el ingreso
de la factura para calcular el margen real de cada operacion.

**Analizar facturacion por cliente y periodo**
Genera informes de facturacion total por cliente en un periodo determinado y supervisa
el estado de cobro de sus facturas para el cierre contable.

---

## 5. Departamento de RR. HH.

Gestiona la informacion laboral y operativa de los conductores.

**Registrar nuevos conductores**
Al incorporar un conductor a la plantilla, RR. HH. registra sus datos personales,
numero de empleado y documentacion habilitante inicial (permiso de conducir, CAP,
tarjeta de tacografo).

**Controlar documentacion y caducidades de conductores**
Consulta periodicamente los documentos de conductores proximos a caducar y registra
los nuevos documentos cuando se renuevan.

**Gestionar la disponibilidad de conductores**
Registra periodos de vacaciones, bajas medicas, formaciones o cualquier situacion
que limite la disponibilidad de un conductor para que el departamento de trafico
no lo asigne por error.

**Consultar el historial operativo de un conductor**
Consulta los servicios realizados por un conductor en un periodo para informes de
actividad o analisis de productividad.

**Gestionar bajas de conductores**
Cuando un conductor causa baja, actualiza su estado para que no aparezca como recurso
disponible, conservando su historial operativo.

---

## 6. Departamento de Cumplimiento / Calidad

Responsable del control documental, el cumplimiento normativo y la auditoria interna.

**Verificar la documentacion completa de servicios**
Comprueba que los servicios completados tienen todos sus documentos vinculados
(CMR firmado, albaranes de entrega, partes de incidencia si los hubiera) y marca
los que tienen documentacion incompleta para su subsanacion.

**Supervisar los requisitos especiales de servicios**
Verifica que los servicios con requisitos especiales (temperatura, manipulacion,
seguros) tienen correctamente registrados y acreditados dichos requisitos.

**Consultar el historial de incidencias**
Analiza las incidencias registradas en un periodo para identificar patrones,
evaluar la calidad del servicio y proponer mejoras en los procesos operativos.

**Consultar los registros de auditoria interna**
Revisa el registro de operaciones criticas para verificar que los procesos se siguen
correctamente y detectar posibles irregularidades o accesos no autorizados.

**Controlar el cumplimiento documental de vehiculos y conductores**
Verifica que todos los vehiculos y conductores tienen la documentacion obligatoria
en vigor y que no hay recursos activos con documentacion caducada.

**Generar informes de calidad**
A partir de los datos de la base de datos (incidencias por periodo, tipos de incidencia,
tiempos de resolucion, cumplimiento de ventanas horarias, servicios con documentacion
incompleta) elabora informes de calidad para la direccion.

---

## 7. Resumen por departamento

| Departamento | Operaciones principales |
|---|---|
| Operaciones / Trafico | Crear servicios, asignar recursos, seguimiento de estados, eventos de trazabilidad, incidencias, alertas de caducidades |
| Atencion al cliente / Comercial | Consultar estado e historial de servicios, gestionar clientes, resolver reclamaciones |
| Flota / Mantenimiento | Gestionar vehiculos y remolques, registrar mantenimientos, controlar documentacion, imputar costes |
| Finanzas | Facturar servicios, gestionar cobros, analizar costes y rentabilidad |
| RR. HH. | Gestionar conductores, controlar documentacion habilitante, gestionar disponibilidad |
| Cumplimiento / Calidad | Control documental de servicios y recursos, requisitos especiales, auditoria interna, informes de calidad |