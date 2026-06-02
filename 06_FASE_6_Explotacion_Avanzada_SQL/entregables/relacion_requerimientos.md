# Relacion de Consultas con Requerimientos del Proyecto -- FASE 6

**Proyecto:** TFG - Base de Datos Empresa de Transporte Intracomunitario (UE)
**Actividad:** Actividad 9 -- Relacionar las consultas con los requerimientos del proyecto
**Requerimientos fuente:** FASE 1 -- `requerimientos_cliente.md`

---

## Objetivo

Demostrar que las consultas avanzadas de FASE 6 responden a los requerimientos funcionales
definidos al inicio del proyecto. Esto prueba que el diseño de la BD tiene coherencia de
principio a fin: los requerimientos de negocio se convirtieron en entidades (FASE 2-3),
luego en tablas fisicas (FASE 4) y ahora en consultas que extraen informacion util (FASE 6).

---

## Tabla de trazabilidad

| Consulta / Actividad | Requerimiento relacionado | Justificacion |
|---|---|---|
| Servicios con cliente, conductor y vehiculo (Act. 1+2) | RF-004 Registrar servicios de transporte | La consulta demuestra que para cada servicio se puede obtener el cliente que lo contrato, el conductor asignado y el vehiculo utilizado, integrando la informacion de varias entidades del modelo |
| Servicios con cliente, conductor y vehiculo (Act. 1+2) | RF-016 Asignar recursos a servicios | El LEFT JOIN sobre la tabla asignacion (es_activa=1) recupera exactamente la asignacion vigente de conductor, vehiculo y remolque para cada servicio |
| Servicios con cliente, conductor y vehiculo (Act. 1+2) | RF-015 Gestionar disponibilidad de recursos | La columna estado_conductor del resultado permite ver de un vistazo si el conductor asignado esta disponible, asignado o de vacaciones |
| Incidencias relacionadas con servicios (Act. 3) | RF-018 Registrar incidencias de servicios | La consulta muestra todas las incidencias vinculadas a servicios y clientes, confirmando que el sistema registra correctamente que servicio tuvo problemas y de que tipo |
| Incidencias relacionadas con servicios (Act. 3) | RF-019 Gestionar el ciclo de vida de las incidencias | La columna estado de la consulta refleja en que punto del ciclo (Abierta, En_gestion, Resuelta, Cerrada) se encuentra cada incidencia |
| Costes totales y margen por servicio (Act. 4) | RF-021 Registrar costes operativos imputados a servicios | La consulta agrega todos los costes (combustible, peajes, dietas, reparaciones) vinculados a cada servicio mediante SUM sobre coste_operativo |
| Costes totales y margen por servicio (Act. 4) | RF-022 Consultar el coste total de un servicio | Esta consulta implementa exactamente el requerimiento: suma todos los costes del servicio y los compara con el ingreso de la factura para calcular el margen estimado |
| Facturacion por cliente y periodo (Act. 5) | RF-023 Registrar facturas emitidas a clientes | La consulta agrupa las facturas por cliente mostrando el total facturado, confirmando que el sistema registra y permite consultar la facturacion por cliente |
| Facturacion por cliente y periodo (Act. 5) | RF-024 Gestionar el seguimiento de cobros | Las columnas cobrado_eur y pendiente_eur desglosan el estado de cobro de cada cliente en el periodo, usando CASE WHEN sobre estado_cobro |
| Facturacion por cliente y periodo (Act. 5) | RF-025 Consultar la facturacion por cliente y periodo | Esta consulta implementa directamente el requerimiento: devuelve el importe total facturado a cada cliente en un periodo determinado con el estado de cobro |
| Servicios sin facturar (Act. 6a) | RF-023 Registrar facturas emitidas a clientes | Detectar servicios sin id_factura permite identificar operaciones completadas o en curso que aun no tienen factura generada, facilitando el control del ciclo de facturacion |
| Servicios sin facturar (Act. 6a) | RF-025 Consultar la facturacion por cliente y periodo | Complementa RF-025: no solo muestra lo facturado sino tambien lo que falta por facturar |
| Servicios con documentacion incompleta (Act. 6b) | RF-026 Registrar documentacion asociada a servicios | La consulta identifica servicios con documentacion_completa=0, lo que señala que alguno de los documentos esperados (CMR, albaran, registro de temperatura) aun no ha sido recibido |
| Servicios con documentacion incompleta (Act. 6b) | RF-010 Registrar eventos de seguimiento e historial | Un servicio sin documentacion completa no puede cerrarse correctamente. Esta consulta es el mecanismo de control que asegura la trazabilidad documental antes del cierre |
| Documentos caducados (Act. 7a) | RF-027 Registrar documentacion con vigencia de recursos | La consulta accede a documento_recurso (vehiculos, remolques, conductores) y filtra por fecha_caducidad < CURDATE(), listando todos los documentos que han vencido |
| Documentos caducados (Act. 7a) | RF-028 Alertas y control de caducidades | Esta consulta implementa la funcion de alerta de caducidades: permite identificar los documentos vencidos que deben renovarse de inmediato |
| Documentos proximos a caducar (Act. 7b) | RF-027 Registrar documentacion con vigencia de recursos | Usa el mismo modelo de datos que 7a pero filtra los documentos que caducan en los proximos 90 dias para anticipar las renovaciones |
| Documentos proximos a caducar (Act. 7b) | RF-028 Alertas y control de caducidades | Implementa la funcion preventiva del requerimiento: avisa con antelacion antes de que el documento caduque, permitiendo actuar sin urgencia |
| Trigger de auditoria (Act. 8) | RF-030 Registrar eventos de auditoria interna | El trigger automatiza exactamente lo descrito en RF-030: cuando se modifica el estado de un servicio, se registra automaticamente en registro_auditoria con operacion, entidad, id_registro, usuario y fecha_hora |
| Trigger de auditoria (Act. 8) | RNF-010 Trazabilidad de operaciones criticas | El trigger garantiza la trazabilidad de los cambios de estado de servicios sin depender de que el usuario recuerde registrar manualmente cada cambio |
| Dashboard operativo resumen | RF-009 Gestionar el estado actual de un servicio | La consulta de resumen agrupa los servicios por estado y señala cuantos tienen pendientes criticos (sin facturar, documentacion incompleta), apoyando la gestion del estado operativo global |
| Dashboard operativo resumen | RF-011 Consultar el estado e historial de un servicio | El resumen es la vista mas rapida del estado global de todas las operaciones, complementando las consultas individuales por servicio |

---

## Cobertura de requerimientos funcionales

| Requerimiento | Cubierto por |
|---|---|
| RF-004 | Consulta servicios JOIN cliente/conductor/vehiculo (Act. 1+2) |
| RF-009 | Dashboard resumen por estado |
| RF-010 | Control documentacion incompleta (Act. 6b) |
| RF-011 | Dashboard resumen + consultas de estado |
| RF-015 | Consulta disponibilidad en JOIN de servicios (Act. 1+2) |
| RF-016 | Consulta asignacion activa (Act. 1+2) |
| RF-018 | Consulta incidencias con servicios (Act. 3) |
| RF-019 | Ciclo de vida de incidencias visible en consulta (Act. 3) |
| RF-021 | Costes totales por servicio (Act. 4) |
| RF-022 | Calculo de coste total + margen (Act. 4) |
| RF-023 | Facturacion por cliente (Act. 5) + deteccion sin facturar (Act. 6a) |
| RF-024 | Desglose cobrado/pendiente por cliente (Act. 5) |
| RF-025 | Facturacion por cliente y periodo (Act. 5) |
| RF-026 | Control documentacion de servicios (Act. 6b) |
| RF-027 | Documentos caducados y proximos a caducar (Act. 7a y 7b) |
| RF-028 | Alertas de caducidad preventiva y correctiva (Act. 7a y 7b) |
| RF-030 | Trigger de auditoria automatica (Act. 8) |
| RNF-010 | Trigger garantiza trazabilidad de cambios de estado (Act. 8) |
