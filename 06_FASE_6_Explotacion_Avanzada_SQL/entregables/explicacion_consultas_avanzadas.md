# Explicacion de Consultas Avanzadas -- FASE 6

**Proyecto:** TFG - Base de Datos Empresa de Transporte Intracomunitario (UE)
**Scripts:** `consultas_avanzadas.sql` + `trigger_auditoria.sql`
**Fecha:** 2026-06-02

---

## Actividades 1 + 2 -- Servicios con cliente, conductor y vehiculo

| Campo | Detalle |
|---|---|
| Actividades oficiales | Actividad 1 (JOIN multitabla) + Actividad 2 (servicios con cliente/conductor/vehiculo) |
| Tablas usadas | `servicio`, `cliente`, `asignacion`, `conductor`, `vehiculo`, `remolque` |
| JOINs | INNER JOIN cliente -- LEFT JOIN asignacion, conductor, vehiculo, remolque |
| Que hace | Muestra cada servicio con el nombre del cliente, el conductor actualmente asignado (si existe), el estado de disponibilidad del conductor, la matricula del vehiculo y la del remolque |
| Por que LEFT JOIN | Hay servicios sin asignacion activa (Pendiente, Planificado). Con LEFT JOIN se muestran todos; con INNER JOIN los sin asignar desaparecerian |
| Resultado esperado | 8 filas (uno por servicio). Los servicios sin conductor asignado muestran NULL en esas columnas |
| Utilidad para la empresa | El responsable de trafico ve de una sola consulta que conductor y vehiculo tiene cada operacion activa, sin necesidad de cruzar varias tablas manualmente |

---

## Actividad 3 -- Incidencias relacionadas con servicios

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 3 -- Consultar incidencias relacionadas con servicios |
| Tablas usadas | `incidencia`, `servicio`, `cliente` |
| JOINs | INNER JOIN servicio, INNER JOIN cliente |
| Que hace | Lista todas las incidencias con el numero de servicio y el nombre del cliente al que pertenecen, ordenadas por prioridad descendente |
| Por que INNER JOIN | Solo interesan las incidencias que tienen un servicio real asociado (FK NOT NULL garantizada por el esquema) |
| Resultado esperado | 4 filas con las incidencias registradas en FASE 4. Las de prioridad Alta aparecen primero |
| Utilidad para la empresa | Operaciones y atencion al cliente pueden ver rapidamente que servicios han tenido problemas, a que cliente afectan y en que estado esta la resolucion |

---

## Actividad 4 -- Costes totales y margen estimado por servicio

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 4 -- Calcular costes totales de un servicio |
| Tablas usadas | `servicio`, `cliente`, `coste_operativo`, `factura` |
| JOINs | INNER JOIN cliente -- LEFT JOIN coste_operativo, factura |
| Funciones | COUNT, SUM, COALESCE, GROUP BY |
| Que hace | Por cada servicio suma todos los costes operativos imputados, los compara con el importe base de la factura emitida y calcula el margen estimado |
| COALESCE | Se usa para tratar servicios sin costes (SUM=NULL) y sin factura (importe_base=NULL), devolviendo 0 en lugar de NULL |
| Resultado esperado | 8 filas. Los servicios sin factura (sin facturar) muestran ingreso 0 y margen negativo igual al coste total |
| Utilidad para la empresa | Finanzas y direccion pueden ver si cada servicio es rentable. Un margen negativo señala que los costes superan el ingreso o que el servicio aun no esta facturado |

---

## Actividad 5 -- Facturacion por cliente y periodo

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 5 -- Consultar facturacion por cliente y periodo |
| Tablas usadas | `factura`, `cliente` |
| JOINs | INNER JOIN cliente |
| Funciones | COUNT, SUM, CASE WHEN, GROUP BY |
| Filtro de periodo | WHERE fecha_emision BETWEEN '2026-01-01' AND '2026-12-31' (todo el año 2026) |
| Que hace | Agrupa las facturas por cliente, sumando el total facturado, lo ya cobrado y lo pendiente de cobro |
| Resultado esperado | 3 filas (Industrias Textiles Lenz, Pharma Distribution, Boulangerie Du Nord). Solo los clientes con facturas en 2026 aparecen |
| Utilidad para la empresa | Control financiero: el director sabe cuanto ha facturado a cada cliente en el periodo, cuanto ha cobrado y cuanto sigue pendiente. Base para analisis de morosidad |

---

## Actividad 6a -- Servicios sin facturar

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 6 -- Detectar servicios sin facturar o con documentacion incompleta |
| Tablas usadas | `servicio`, `cliente` |
| JOINs | INNER JOIN cliente |
| Filtro | id_factura IS NULL AND estado_actual NOT IN ('Cancelado', 'Pendiente') |
| Que hace | Lista los servicios que ya estan en ejecucion o entregados pero aun no tienen factura emitida |
| Resultado esperado | Servicios SRV-0002 (En_transito, Pharma), SRV-0004 (Planificado, Auto Parts), SRV-0005 (Asignado, Elettronica), SRV-0007 (Pendiente especial, excluido por el filtro) |
| Utilidad para la empresa | Administracion detecta que servicios realizados quedan pendientes de facturar para evitar ingresos no registrados |

---

## Actividad 6b -- Servicios con documentacion incompleta

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 6 -- Detectar servicios sin facturar o con documentacion incompleta |
| Tablas usadas | `servicio`, `cliente` |
| JOINs | INNER JOIN cliente |
| Filtro | documentacion_completa = 0 AND estado_actual NOT IN ('Cancelado') |
| Que hace | Lista los servicios activos o finalizados en los que la documentacion no esta recibida en su totalidad |
| Resultado esperado | Varios servicios pendientes de CMR, registros de temperatura o certificados |
| Utilidad para la empresa | Control de calidad y trafico comprueban que ningun servicio se cierra sin toda la documentacion archivada, lo que es requisito legal para el transporte intracomunitario |

---

## Actividad 7a -- Documentos caducados

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 7 -- Localizar documentos caducados o proximos a caducar |
| Tablas usadas | `documento_recurso`, `vehiculo`, `remolque`, `conductor` |
| JOINs | LEFT JOIN vehiculo, LEFT JOIN remolque, LEFT JOIN conductor |
| Funciones | DATEDIFF, CURDATE, COALESCE, CASE WHEN |
| Que hace | Lista todos los documentos cuya fecha_caducidad es anterior a la fecha actual, indicando cuantos dias llevan vencidos y a que recurso pertenecen |
| Resultado esperado | 7+ documentos vencidos incluyendo: Tacografo Veh1 (vencio 2025-07-10), ITV Rem3 (vencio 2025-11-08), Permiso conducir Carlos Martinez (vencio 2025-06-20), Tarjeta tacografo Carlos (vencio 2024-04-01), Permiso conducir Ana Garcia (vencio 2025-11-15), CAP Pedro Ramos (vencio 2025-05-10), Permiso conducir Jan Kowalski (vencio 2026-04-22) |
| Utilidad para la empresa | Cumplimiento y flota detectan infracciones potenciales. Un vehiculo o conductor con documentacion vencida no puede circular legalmente |

---

## Actividad 7b -- Documentos proximos a caducar (90 dias)

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 7 -- Localizar documentos caducados o proximos a caducar |
| Tablas usadas | `documento_recurso`, `vehiculo`, `remolque`, `conductor` |
| JOINs | LEFT JOIN vehiculo, LEFT JOIN remolque, LEFT JOIN conductor |
| Funciones | DATEDIFF, CURDATE, DATE_ADD, COALESCE, CASE WHEN |
| Filtro | fecha_caducidad BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 90 DAY) |
| Que hace | Lista los documentos que caducan en los proximos 90 dias para iniciar las renovaciones con antelacion |
| Resultado esperado (desde 2026-06-02) | ITV Veh5 MAN 9901-BIL (caduca 2026-06-15, 13 dias), ITV Veh3 Scania 3345-BCN (caduca 2026-08-22, ~81 dias) |
| Utilidad para la empresa | La empresa inicia los tramites de renovacion con tiempo, evitando que un vehiculo quede inmovilizado por falta de ITV o un conductor no pueda trabajar por el CAP caducado |

---

## Actividad 8 -- Trigger de auditoria

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 8 -- Crear algun trigger o automatismo sencillo |
| Nombre | `trg_auditoria_cambio_estado_servicio` |
| Tipo | AFTER UPDATE ON servicio |
| Tabla objetivo | `registro_auditoria` |
| Condicion | Solo se activa si NEW.estado_actual <> OLD.estado_actual |
| Que hace | Cuando alguien actualiza el estado de un servicio, el trigger inserta automaticamente un registro en registro_auditoria con el cambio de estado, el servicio afectado, la fecha y la hora |
| Resultado de la prueba | Despues de ejecutar `UPDATE servicio SET estado_actual='Asignado' WHERE id_servicio=4`, aparece una nueva fila en registro_auditoria con descripcion "Estado: Planificado -> Asignado" |
| Utilidad para la empresa | La auditoria es automatica y no depende de que los usuarios recuerden registrarla. Cualquier cambio de estado queda trazado con fecha, hora y el servicio afectado |

---

## Consulta Resumen -- Dashboard operativo

| Campo | Detalle |
|---|---|
| Tablas usadas | `servicio` |
| Funciones | COUNT, CASE, GROUP BY, ORDER BY FIELD |
| Que hace | Agrupa los servicios por estado y cuenta cuantos tienen documentacion incompleta o sin factura, usando un orden logico de estados (no alfabetico) |
| Resultado esperado | Una fila por cada estado activo. Sirve como pantalla de resumen ejecutivo |
| Utilidad para la empresa | Un solo vistazo muestra cuantos servicios hay en cada etapa y cuales tienen pendientes criticos (sin facturar, sin documentar) |

---

## Actividad 9 -- Trazabilidad con requerimientos

Ver `relacion_requerimientos.md` para la tabla completa de correspondencia entre consultas y requerimientos funcionales RF-XXX de FASE 1.
