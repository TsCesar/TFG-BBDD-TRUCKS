# Requerimientos del Cliente

**Proyecto:** Diseno, creacion y explotacion de una base de datos para la gestion integral
de una empresa de transporte intracomunitario por carretera (UE) en MySQL (phpMyAdmin)
**Fase:** 1 - Descripcion del dominio y requerimientos del cliente
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora - Curso 2024-26

---

## 1. Requerimientos Funcionales

Los requerimientos funcionales describen las funciones que debe proporcionar la base de datos.
Se derivan directamente del alcance aprobado en la propuesta oficial del TFG.

---

### Gestion de clientes y terceros

**RF-001 - Registrar clientes**
El sistema debe permitir registrar la informacion de cada cliente: identificacion fiscal,
razon social, pais, datos de contacto principal y condiciones comerciales.

**RF-002 - Gestionar contactos de clientes**
Un cliente puede tener varios contactos vinculados (responsables de logistica, compras,
administracion). El sistema debe permitir registrar y gestionar estos contactos con sus
datos de identificacion y cargo.

**RF-003 - Gestionar direcciones operativas de clientes**
Un cliente puede operar desde multiples ubicaciones (almacenes, plantas, delegaciones).
El sistema debe permitir registrar estas direcciones operativas y asociarlas a los
puntos de recogida y entrega de los servicios.

---

### Gestion de servicios y seguimiento

**RF-004 - Registrar servicios de transporte**
El sistema debe permitir crear un registro por cada servicio de transporte con su
identificador interno, fecha de solicitud, cliente, tipo de servicio y estado actual.

**RF-005 - Registrar puntos de recogida y entrega con ventanas horarias**
Cada servicio puede tener uno o varios puntos de recogida y uno o varios puntos de
entrega. Cada punto debe registrar su direccion, tipo (recogida o entrega), orden en
la ruta, ventana horaria acordada (inicio y fin) y estado de ejecucion.

**RF-006 - Gestionar niveles de urgencia y compromisos de servicio**
El sistema debe permitir registrar el nivel de urgencia o compromiso de entrega asociado
a cada servicio (estandar, urgente, fecha garantizada, etc.) para que el departamento de
trafico pueda priorizar la planificacion.

**RF-007 - Registrar informacion de la mercancia**
Para cada servicio se debe registrar la descripcion general de la mercancia: tipo, numero
de bultos o palets, peso estimado, volumen y cualquier caracteristica relevante para la
operacion de transporte.

**RF-008 - Registrar requisitos operativos especiales**
Algunos servicios requieren condiciones operativas especificas. El sistema debe permitir
registrar y asociar estos requisitos a cada servicio: control de temperatura (rangos min/max),
manipulacion especial, seguros adicionales, restricciones de acceso o cualquier otro
requisito operativo que afecte a la ejecucion del servicio.

**RF-009 - Gestionar el estado actual de un servicio**
El sistema debe registrar el estado en curso de cada servicio (pendiente, planificado,
asignado, en transito, entregado, cerrado, cancelado) y permitir su actualizacion por
el personal autorizado.

**RF-010 - Registrar eventos de seguimiento e historial de un servicio**
El sistema debe mantener un historial cronologico de todos los eventos relevantes de
cada servicio (cambios de estado, confirmacion de recogida, llegada a destino, etc.),
con fecha, hora, tipo de evento y usuario responsable, garantizando la trazabilidad
completa del ciclo de vida del servicio.

**RF-011 - Consultar el estado e historial de un servicio**
Debe ser posible consultar en cualquier momento el estado actual e historial completo
de un servicio, incluyendo sus eventos de seguimiento, incidencias asociadas y
documentacion vinculada.

---

### Gestion de recursos

**RF-012 - Registrar vehiculos de la flota**
El sistema debe registrar cada vehiculo con su matricula, tipo, marca, modelo, capacidad
de carga y estado operativo.

**RF-013 - Registrar remolques**
Los remolques se gestionan de forma independiente a los vehiculos tractores. El sistema
debe registrar cada remolque con su matricula, tipo (lona, frigorifico, cisterna, etc.),
capacidad y estado operativo.

**RF-014 - Registrar conductores**
El sistema debe registrar la informacion de cada conductor: datos personales, numero de
empleado, numero de permiso de conducir y estado de disponibilidad.

**RF-015 - Gestionar disponibilidad de vehiculos, remolques y conductores**
El sistema debe registrar el estado operativo de cada recurso (disponible, asignado,
en mantenimiento, baja) para evitar conflictos de planificacion y dobles asignaciones.

**RF-016 - Asignar recursos a servicios**
El sistema debe registrar la asignacion de un conductor, un vehiculo y, opcionalmente,
un remolque a cada servicio, con fecha y hora de la asignacion.

**RF-017 - Registrar el historial de asignaciones**
Debe ser posible mantener el historial de asignaciones de un servicio (por ejemplo, cuando
se cambia el conductor o el vehiculo por una incidencia), identificando cual es la
asignacion activa en cada momento.

---

### Gestion de incidencias

**RF-018 - Registrar incidencias de servicios**
El sistema debe permitir crear un registro de incidencia vinculado a un servicio, con su
tipo, descripcion, fecha y hora de apertura y departamento notificador.

**RF-019 - Gestionar el ciclo de vida de las incidencias**
Cada incidencia debe poder transicionar entre estados (abierta, en gestion, resuelta,
cerrada) con registro del responsable y la fecha de cada cambio de estado.

**RF-020 - Registrar la resolucion de incidencias**
Al cerrar una incidencia, el sistema debe registrar la descripcion de la solucion
adoptada, la fecha de cierre y si genero costes adicionales imputables al servicio.

---

### Gestion de costes operativos

**RF-021 - Registrar costes operativos imputados a servicios**
El sistema debe permitir registrar los gastos directos asociados a cada servicio:
combustible, peajes, dietas, reparaciones urgentes en ruta, seguros adicionales
y otros costes operativos. Cada coste debe incluir tipo, importe, fecha y descripcion.

**RF-022 - Consultar el coste total de un servicio**
Debe ser posible obtener el coste operativo total de un servicio a partir de la suma
de todos los costes imputados, para su comparacion con el ingreso de la factura.

---

### Facturacion y cobros

**RF-023 - Registrar facturas emitidas a clientes**
Por cada ciclo de facturacion, el sistema debe registrar las facturas emitidas a los
clientes, vinculandolas a los servicios incluidos: numero de factura, fecha de emision,
importe, impuestos y fecha de vencimiento.

**RF-024 - Gestionar el seguimiento de cobros**
El sistema debe registrar el estado de cobro de cada factura (pendiente, cobrada, vencida,
en mora) y la fecha y metodo de cobro efectivo cuando se produzca.

**RF-025 - Consultar la facturacion por cliente y periodo**
Debe ser posible consultar el importe total facturado a un cliente en un periodo
determinado y el estado de cobro de sus facturas, para el control financiero.

---

### Documentacion y control interno

**RF-026 - Registrar documentacion asociada a servicios**
Para cada servicio el sistema debe permitir registrar los documentos de transporte
generados (carta de porte CMR, albaranes de entrega firmados, partes de incidencia,
evidencias adicionales), con indicacion de tipo, fecha y estado de recepcion.

**RF-027 - Registrar documentacion con vigencia de recursos**
El sistema debe registrar los documentos con fecha de caducidad vinculados a vehiculos,
remolques y conductores: permisos, seguros, ITV, calibracion de tacografo, permiso
de conducir, tarjeta de cualificacion del conductor (CAP), tarjeta de tacografo digital.

**RF-028 - Alertas y control de caducidades**
El sistema debe permitir identificar documentos de recursos cuya fecha de caducidad
sea proxima o haya vencido, para que los departamentos responsables inicien las
gestiones de renovacion con antelacion.

**RF-029 - Registrar requisitos operativos especiales con vigencia**
Algunos requisitos especiales de los servicios tienen vigencia acotada o condiciones
de cumplimiento que deben quedar documentadas y trazadas para el control interno.

**RF-030 - Registrar eventos de auditoria interna**
El sistema debe mantener un registro de las operaciones criticas: creacion y modificacion
de servicios, cambios de estado, asignacion de recursos, modificacion de costes y
factuacion. Cada registro debe incluir la operacion realizada, la entidad afectada,
el usuario responsable y la fecha y hora.

---

## 2. Requerimientos No Funcionales

### Integridad de datos

**RNF-001 - Integridad referencial**
La base de datos debe garantizar la coherencia entre entidades relacionadas mediante
restricciones de integridad referencial. No pueden existir registros huerfanos.

**RNF-002 - Restricciones de valor**
Los campos que aceptan un conjunto cerrado de valores (estados, tipos, categorias)
deben validarse para impedir la insercion de valores no definidos.

**RNF-003 - Obligatoriedad de datos esenciales**
Los datos minimos imprescindibles para que un registro sea operativamente coherente
deben marcarse como obligatorios y no pueden quedar sin valor.

### Consistencia

**RNF-004 - Consistencia transaccional**
Las operaciones que modifican varios registros de forma relacionada deben tratarse
de forma atomica: si parte de la operacion falla, no deben quedar datos en estado
inconsistente.

**RNF-005 - Coherencia del historial cronologico**
Los registros de eventos de seguimiento, historial de incidencias y auditoria deben
mantener una secuencia cronologica coherente y no modificable.

### Rendimiento

**RNF-006 - Eficiencia en consultas operativas**
Las consultas mas frecuentes (estado de un servicio, disponibilidad de recursos,
facturacion pendiente) deben responder en un tiempo razonable incluso con volumen
acumulado de datos de varios anos de operativa.

### Escalabilidad

**RNF-007 - Capacidad de crecimiento**
La estructura de la base de datos debe acomodar el crecimiento natural de la operativa
sin necesidad de redisenos estructurales: mas clientes, servicios, vehiculos, conductores.

**RNF-008 - Diseno normalizado**
La normalizacion del esquema hasta 3FN garantiza la ausencia de redundancias y
anomalias de actualizacion, condicion necesaria para la escalabilidad a largo plazo.

### Seguridad basica

**RNF-009 - Control de acceso por perfil**
El sistema debe implementar distintos niveles de acceso segun el departamento, de forma
que cada usuario solo pueda acceder a los datos que corresponden a su funcion.

**RNF-010 - Trazabilidad de operaciones criticas**
Las operaciones sobre datos sensibles (cambios de estado, facturacion, modificacion de
recursos) deben quedar registradas con usuario y fecha para garantizar la auditabilidad.