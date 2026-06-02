# Explicacion de Consultas Basicas -- FASE 5

**Proyecto:** TFG - Base de Datos Empresa de Transporte Intracomunitario (UE)
**Script:** `consultas_basicas.sql`
**Fecha:** 2026-06-02

---

## Actividad 1 -- INSERT: Añadir nuevos registros

### INSERT 1a -- Nuevo contacto en Pharma Distribution GmbH

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 1 -- Añadir nuevos registros con INSERT |
| Tablas usadas | `contacto` (FK a `cliente`) |
| Que hace | Inserta una nueva persona de contacto para el cliente id=2 (Pharma Distribution GmbH) |
| Resultado esperado | 1 fila insertada. El contacto Petra Schreiber queda vinculado al cliente 2 |
| Utilidad para la empresa | Cuando un cliente cambia de personal o añade un nuevo responsable, la empresa registra el nuevo contacto para mantener la comunicacion actualizada |

### INSERT 1b -- Nuevo coste operativo en SRV-2026-0002

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 1 -- Añadir nuevos registros con INSERT |
| Tablas usadas | `coste_operativo` (FK a `servicio`) |
| Que hace | Imputa una dieta de 55 EUR al servicio farmaceutico SRV-2026-0002, correspondiente a la noche del conductor en ruta |
| Resultado esperado | 1 fila insertada en coste_operativo para id_servicio=2 |
| Utilidad para la empresa | Los costes operativos se registran conforme se producen durante la ejecucion. Esto permite calcular el coste total real del servicio para compararlo con el ingreso de la factura |

### INSERT 1c -- Cliente de prueba para DELETE

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 1 -- Añadir nuevos registros con INSERT (registro de prueba) |
| Tablas usadas | `cliente` |
| Que hace | Inserta un cliente ficticio con CIF='TEST-DELETE-01' para usar como registro de prueba en la actividad de DELETE |
| Resultado esperado | 1 fila insertada. El cliente aparece en la tabla con activo=1 |
| Utilidad para la empresa | Demuestra que la tabla cliente acepta nuevas altas y que el esquema es correcto. El registro se borra en la Actividad 3 |

---

## Actividad 2 -- UPDATE: Modificar datos existentes

### UPDATE 2a -- Corregir email de Auto Parts Poland

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 2 -- Modificar datos existentes con UPDATE |
| Tablas usadas | `cliente` |
| Que hace | Actualiza el email de Auto Parts Poland (id_cliente=4) al dominio .eu correcto |
| Resultado esperado | 1 fila afectada. El campo email de id_cliente=4 queda como 'transporte@autoparts-pl.eu' |
| Utilidad para la empresa | Los datos de contacto de los clientes cambian con el tiempo. La empresa puede corregirlos en cualquier momento sin afectar al historial de servicios |

### UPDATE 2b -- Marcar documentacion de SRV-2026-0004 como completa

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 2 -- Modificar datos existentes con UPDATE |
| Tablas usadas | `servicio` |
| Que hace | Pone `documentacion_completa = 1` en el servicio SRV-2026-0004 (Auto Parts Poland, Warszawa->Barcelona) al confirmar la recepcion del CMR |
| Resultado esperado | 1 fila afectada. El campo documentacion_completa pasa de 0 a 1 |
| Utilidad para la empresa | Trafico y administracion controlan si la documentacion de cada servicio esta recibida y archivada. Cuando se completa, el servicio puede avanzar hacia cierre y facturacion |

### UPDATE 2c -- Actualizar estado de incidencia id=2

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 2 -- Modificar datos existentes con UPDATE |
| Tablas usadas | `incidencia` |
| Que hace | Pasa la incidencia id=2 (Demora significativa en frontera francesa, SRV-2026-0002 Pharma) de 'Abierta' a 'En_gestion', registra el responsable y la fecha de actualizacion |
| Resultado esperado | 1 fila afectada. El estado de la incidencia cambia y queda el responsable 'trafico.lopez' asignado |
| Utilidad para la empresa | Las incidencias tienen un ciclo de vida (Abierta -> En_gestion -> Resuelta -> Cerrada). Actualizarlo en tiempo real permite al departamento de trafico saber quien esta gestionando cada problema |

---

## Actividad 3 -- DELETE: Borrar registros de prueba

### DELETE 3 -- Eliminar cliente de prueba TEST-DELETE-01

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 3 -- Borrar registros de prueba con DELETE |
| Tablas usadas | `cliente` |
| Que hace | Elimina el cliente ficticio insertado en la Actividad 1 usando el CIF unico como filtro seguro |
| Resultado esperado | 1 fila eliminada. El cliente TEST-DELETE-01 desaparece de la tabla |
| Por que es seguro | El cliente de prueba no tiene servicios, contactos ni direcciones vinculados, por lo que no hay restricciones de FK que impidan el borrado |
| Utilidad para la empresa | Demuestra que la BD permite dar de baja registros que ya no son necesarios. En produccion se usaria para eliminar clientes de prueba, duplicados o altas erroneas sin historico |

---

## Actividad 4 -- SELECT: Consultar clientes activos

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 4 -- Consultar clientes activos |
| Tablas usadas | `cliente` |
| Que hace | Filtra los clientes con `activo = 1` y los ordena por nombre |
| Resultado esperado | 5 filas: Auto Parts Poland, Boulangerie Du Nord, Elettronica Italiana, Industrias Textiles Lenz, Pharma Distribution |
| Utilidad para la empresa | El departamento comercial y de trafico consulta rapidamente la cartera de clientes operativos. Los clientes inactivos (activo=0) no aparecen y no pueden generar nuevos servicios |

---

## Actividad 5 -- SELECT: Consultar servicios por estado

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 5 -- Consultar servicios por estado |
| Tablas usadas | `servicio` |
| Que hace | Lista todos los servicios ordenados por estado actual y fecha de recogida |
| Resultado esperado | 8 filas con todos los servicios agrupados visualmente por estado: Asignado, Cancelado, Cerrado (x2), En_transito, Entregado, Pendiente, Planificado |
| Utilidad para la empresa | El responsable de trafico puede ver de un vistazo en que punto se encuentra cada operacion sin necesidad de abrir expedientes individuales. Es la consulta de dashboard operativo mas basica |

---

## Actividad 6 -- SELECT: Consultar vehiculos y conductores disponibles

### SELECT 6a -- Vehiculos disponibles

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 6 -- Consultar vehiculo o conductores disponibles |
| Tablas usadas | `vehiculo` |
| Que hace | Filtra los vehiculos con `estado_operativo = 'Disponible'` |
| Resultado esperado | 2 vehiculos: Scania R500 (3345-BCN) y Renault T High 430 (2267-VAL) |
| Utilidad para la empresa | Evita errores de planificacion. Solo se pueden asignar vehiculos disponibles a nuevos servicios. Los que estan en mantenimiento o asignados no aparecen |

### SELECT 6b -- Conductores disponibles

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 6 -- Consultar vehiculo o conductores disponibles |
| Tablas usadas | `conductor` |
| Que hace | Filtra los conductores con `estado_disponibilidad = 'Disponible'` |
| Resultado esperado | 2 conductores: Jan Kowalski (EMP-0055) y Pedro Ramos (EMP-0033) |
| Utilidad para la empresa | Trafico puede asignar conductores solo entre los disponibles. Los asignados, de vacaciones o de baja no se muestran, lo que elimina el riesgo de doble asignacion |

---

## Actividad 7 -- SELECT: Facturas pendientes e incidencias abiertas

### SELECT 7a -- Facturas pendientes o vencidas

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 7 -- Consultar facturas pendientes o incidencias abiertas |
| Tablas usadas | `factura` |
| Que hace | Filtra facturas con estado 'Pendiente', 'Vencida' o 'En_mora', ordenadas por fecha de vencimiento |
| Resultado esperado | 2 facturas: FAC-2026-0002 (Pharma, 2.380 EUR, Pendiente) y FAC-2026-0004 (Boulangerie, 820 EUR, Vencida) |
| Utilidad para la empresa | El departamento financiero controla los cobros pendientes para reclamar a tiempo. Las facturas vencidas requieren atencion inmediata para evitar morosidad |

### SELECT 7b -- Incidencias abiertas o en gestion

| Campo | Detalle |
|---|---|
| Actividad oficial | Actividad 7 -- Consultar facturas pendientes o incidencias abiertas |
| Tablas usadas | `incidencia` |
| Que hace | Filtra incidencias con estado 'Abierta' o 'En_gestion', ordenadas por prioridad descendente |
| Resultado esperado | 2-3 incidencias activas segun el UPDATE previo: id=2 (Pharma, Alta, En_gestion), id=4 (Electronica, Alta, En_gestion) |
| Utilidad para la empresa | Operaciones hace seguimiento en tiempo real de los problemas sin resolver. Las de prioridad Alta aparecen primero para que no se pasen por alto |

---

## Actividad 8 -- Capturas

Ver `capturas_consultas_basicas.md` para la plantilla de capturas de phpMyAdmin.

Las capturas se añaden despues de ejecutar el script en la BD real.
