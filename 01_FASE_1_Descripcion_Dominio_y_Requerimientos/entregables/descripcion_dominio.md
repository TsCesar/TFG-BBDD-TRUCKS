# Descripcion del Dominio

**Proyecto:** Base de Datos para Empresa de Transporte Intracomunitario por Carretera (UE)
**Fase:** 1 - Descripcion del Dominio y Requerimientos
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora

---

## 1. Descripcion de la Empresa

### 1.1 Actividad principal

La empresa objeto de este proyecto es una **operadora logistica de transporte internacional por carretera** dedicada al movimiento de mercancias entre paises miembros de la Union Europea. Su actividad principal consiste en organizar, planificar y ejecutar servicios de transporte para clientes industriales, comerciales y operadores logisticos que necesitan trasladar mercancias desde un punto de origen a uno o varios puntos de destino dentro del espacio comunitario.

La empresa actua como **transportista directo**, gestionando su propia flota de vehiculos y su propio equipo de conductores, lo que le permite controlar de forma integral la calidad del servicio y los costes operativos.

### 1.2 Tipo de empresa

Se trata de una empresa mediana del sector del transporte por carretera, con una flota de entre 20 y 50 vehiculos entre cabezas tractoras y vehiculos rigidos, y un numero equivalente de conductores profesionales con licencias habilitantes para el transporte internacional (permiso C+E y tarjeta de cualificacion del conductor).

Organizativamente, la empresa cuenta con los siguientes departamentos funcionales:

- **Operaciones / Trafico:** planificacion y asignacion de servicios, seguimiento de envios e incidencias.
- **Flota / Mantenimiento:** gestion de vehiculos, remolques y mantenimientos.
- **Recursos Humanos:** gestion de conductores, disponibilidades y documentacion laboral.
- **Comercial / Atencion al cliente:** relacion con clientes, captacion y resolucion de consultas.
- **Finanzas / Administracion:** facturacion, cobros, costes y contabilidad.
- **Cumplimiento / Calidad:** control documental, requisitos legales y auditoria interna.

### 1.3 Ambito geografico

La empresa opera exclusivamente dentro de la **Union Europea**, cubriendo principalmente los corredores de mayor trafico de mercancias por carretera: Peninsula Iberica, Francia, Benelux, Alemania, Italia y paises del norte y este de Europa. Todos los servicios son de caracter **intracomunitario**, lo que implica el cumplimiento de la normativa europea de transporte por carretera (Reglamento CE 1071/2009, Reglamento CE 1072/2009, normativa de tiempos de conduccion y descanso, etc.).

---

## 2. Servicios que Ofrece la Empresa

### 2.1 Carga completa (FTL - Full Truck Load)

El vehiculo se destina en exclusiva a la mercancia de un unico cliente. Es el servicio estandar para grandes volumenes de carga. El cliente contrata el uso completo del camion o semirremolque independientemente de si lo llena al 100%.

### 2.2 Carga parcial (LTL - Less than Truck Load)

El vehiculo transporta mercancias de varios clientes en el mismo trayecto. Requiere una planificacion mas compleja de rutas y puntos de recogida y entrega, y una gestion cuidadosa de la documentacion asociada a cada carga.

### 2.3 Servicios con requisitos especiales

Determinados envios requieren condiciones operativas especificas:

- **Control de temperatura:** mercancias que deben transportarse en rangos termicos determinados (productos farmaceuticos, alimentacion, etc.).
- **Mercancias de alto valor:** que requieren seguros adicionales o procedimientos de custodia especificos.
- **Cargas con condicionantes de manipulacion:** mercancias fragiles, apilables bajo condiciones, o con restricciones de carga y descarga.

### 2.4 Servicios con recogidas y/o entregas multiples

Algunos servicios implican recoger mercancia en varios puntos de origen o entregar en varios puntos de destino dentro de un mismo trayecto. Esto se conoce como servicio **multipunto** y requiere la gestion de ventanas horarias y el control del orden de paradas.

---

## 3. Flujo Operativo de un Servicio de Transporte

### Etapa 1 - Solicitud del cliente

El cliente (empresa cargadora, operador logistico o distribuidor) contacta con el departamento comercial o de trafico para solicitar un servicio. Proporciona la informacion basica: origen, destino, fecha prevista de recogida, tipo y volumen de mercancia, y cualquier requisito especial.

### Etapa 2 - Valoracion y aceptacion

El departamento de trafico evalua la disponibilidad de vehiculos y conductores para la fecha solicitada, comprueba que el trayecto es viable y que no hay conflictos de planificacion. Si se acepta el servicio, se genera un numero de servicio interno y se confirma al cliente.

### Etapa 3 - Planificacion y asignacion de recursos

Una vez aceptado el servicio, el departamento de trafico asigna:

- Un **conductor** disponible con la documentacion en vigor.
- Un **vehiculo** disponible y en buen estado de mantenimiento.
- Un **remolque o semirremolque** si el tipo de carga lo requiere.

Tambien se define la ruta prevista, los puntos de carga y descarga con sus ventanas horarias, y se entrega la documentacion de transporte al conductor (carta de porte CMR, instrucciones de carga, etc.).

### Etapa 4 - Ejecucion del servicio

El conductor realiza el servicio. Durante esta etapa:

- Se produce la **recogida** de la mercancia en el punto de origen, con firma de la carta de porte.
- El vehiculo realiza el trayecto, respetando la normativa de tiempos de conduccion y descanso.
- Se producen las **entregas** en los puntos de destino, con firma del receptor.
- El departamento de trafico puede realizar seguimiento del estado del servicio.

### Etapa 5 - Incidencias

Durante la ejecucion pueden surgir incidencias que afectan al normal desarrollo del servicio: averias mecanicas, retenciones, problemas en la carga o descarga, mercancia danada, negativas de recepcion, etc. Estas incidencias deben registrarse, gestionarse y resolverse con trazabilidad.

### Etapa 6 - Cierre del servicio

Una vez realizadas todas las entregas, el servicio se considera completado. Se archiva la documentacion de entrega y el servicio queda listo para facturar.

### Etapa 7 - Facturacion y cobro

Finanzas emite la factura correspondiente al cliente segun las condiciones acordadas. Se registra el cobro cuando el cliente realiza el pago.

---

## 4. Tipos de Mercancia

- **Mercancia general paletizada:** el tipo mas habitual. Mercancias agrupadas sobre palets, aptas para carga en cualquier vehiculo de caja cerrada o lona.
- **Mercancia a granel / no paletizada:** bultos, rollos, piezas de gran formato u objetos que no pueden paletizarse de forma estandar.
- **Carga completa de vehiculo:** mercancias que ocupan la totalidad del semirremolque, habitualmente en servicios FTL.
- **Mercancias con temperatura controlada:** requieren vehiculos frigorificos o isotermos.
- **Mercancias de alto valor o sensibles:** requieren medidas de seguridad adicionales y documentacion especifica.

---

## 5. Elementos Clave de la Operativa

### 5.1 Clientes
Las empresas o personas que contratan los servicios de transporte. Pueden tener multiples contactos y multiples direcciones operativas.

### 5.2 Servicios de transporte
Cada servicio es la unidad basica de la operativa. Agrupa toda la informacion relativa a un movimiento de mercancia: quien lo encarga, donde se recoge, donde se entrega, en que fechas, con que vehiculo y conductor, y cual es el estado actual.

### 5.3 Vehiculos
La flota propia esta compuesta por cabezas tractoras y vehiculos rigidos. Cada vehiculo tiene una matricula, un tipo, una capacidad de carga, un estado operativo y un historial de mantenimientos.

### 5.4 Remolques y semirremolques
Son los elementos de carga que se acoplan a las cabezas tractoras. Su gestion es independiente de la cabeza tractora.

### 5.5 Conductores
Personal propio habilitado para conducir vehiculos de transporte internacional, con documentacion profesional con fechas de caducidad.

### 5.6 Rutas y puntos operativos
Un servicio puede implicar una o varias paradas. Cada parada tiene una direccion, tipo, ventana horaria y estado de ejecucion.

### 5.7 Incidencias
Cualquier evento no planificado que afecta al desarrollo normal de un servicio.

### 5.8 Costes operativos
Cada servicio genera costes directos imputables: combustible, peajes, dietas, reparaciones urgentes.

### 5.9 Facturacion y cobros
Por cada servicio completado se genera una factura al cliente con control de cobro.

### 5.10 Documentacion e historial
Cada servicio genera documentacion asociada y requiere un historial de estados.

---

## 6. Problemas Actuales sin Base de Datos

### 6.1 Duplicidad e inconsistencia de datos
La informacion de clientes, vehiculos y conductores se almacena en distintos ficheros mantenidos por diferentes departamentos sin fuente unica de verdad.

### 6.2 Ausencia de trazabilidad en los servicios
No existe un registro historico del ciclo de vida de un servicio, lo que dificulta la resolucion de reclamaciones y la auditoria interna.

### 6.3 Errores de planificacion y dobles asignaciones
Al no existir un sistema centralizado de disponibilidad, un vehiculo o conductor puede quedar asignado a dos servicios solapados en el tiempo.

### 6.4 Dificultad para controlar documentacion caducada
Sin un control centralizado, documentos caducados de vehiculos y conductores pasan desapercibidos hasta que generan un problema legal.

### 6.5 Falta de visibilidad sobre costes y rentabilidad
No es posible conocer con precision el coste total de un servicio ni calcular su margen de beneficio.

### 6.6 Ineficiencia en la atencion al cliente
Responder a consultas sobre el estado de un envio requiere consultar multiples fuentes, siendo un proceso lento y propenso a errores.

### 6.7 Dificultad para escalar la operativa
Cualquier incremento de la actividad implica un aumento proporcional de carga administrativa manual, limitando el crecimiento sostenible.

---

## 7. Conclusion

La empresa dispone de una operativa compleja con multiples elementos interrelacionados que requiere un sistema de informacion centralizado y coherente. La base de datos que se disenara en este proyecto debera gestionar toda esta informacion de forma integrada, eliminando los problemas actuales y proporcionando una base solida para la toma de decisiones operativas, economicas y estrategicas.