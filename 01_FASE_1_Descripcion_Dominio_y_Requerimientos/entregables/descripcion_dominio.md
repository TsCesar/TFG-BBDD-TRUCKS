# Descripcion del Dominio

**Proyecto:** Diseno, creacion y explotacion de una base de datos para la gestion integral
de una empresa de transporte intracomunitario por carretera (UE) en MySQL (phpMyAdmin)
**Fase:** 1 - Descripcion del dominio y requerimientos del cliente
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora - Curso 2024-26

---

## 1. La empresa y su actividad

La empresa objeto de este proyecto es una **operadora logistica de transporte internacional
por carretera** que realiza servicios de reparto y transporte de mercancias entre paises de la
Union Europea mediante camiones y, cuando corresponda, remolques.

Su actividad principal consiste en **organizar y ejecutar servicios de transporte** para
clientes (empresas, operadores logisticos o industrias) que necesitan trasladar mercancia
desde un punto de origen a uno o varios puntos de destino dentro del espacio comunitario.
La empresa actua como transportista directo, gestionando su propia flota de vehiculos y su
equipo de conductores.

---

## 2. Ambito geografico

La empresa opera exclusivamente dentro de la **Union Europea (UE)**, lo que la encuadra
en el marco normativo comunitario del transporte por carretera. Sus operaciones abarcan los
principales corredores logisticos europeos: Peninsula Iberica, Francia, Benelux, Alemania,
Italia y paises del norte y este de Europa.

Al tratarse de transporte intracomunitario, la empresa debe cumplir la normativa europea
en materia de transporte por carretera (Reglamento CE 1071/2009 y 1072/2009), tiempos
de conduccion y descanso (Reglamento CE 561/2006) y documentacion legal asociada a cada
servicio, entre la que destaca la **Carta de Porte Internacional CMR**.

---

## 3. Operativa del transporte

### 3.1 El servicio de transporte como unidad operativa

La unidad basica de la operativa es el **servicio de transporte**, tambien denominado envio.
Cada servicio representa una operacion completa desde que el cliente realiza el encargo hasta
que la mercancia es entregada en destino y el servicio queda cerrado y facturado.

El ciclo de vida de un servicio pasa por los siguientes estados: solicitud recibida, planificado,
asignado a recursos, en transito, entregado, cerrado y, en su caso, cancelado o con incidencia.

### 3.2 Recogidas y entregas en uno o varios puntos

Un servicio puede implicar una unica recogida y una unica entrega (servicio directo), o
multiples puntos de recogida y/o entrega (**servicio multipunto**). En el caso de carga
parcial (LTL, Less than Truck Load), el vehiculo puede recoger mercancia de varios clientes
en distintos origenes y realizar entregas en distintos destinos en un mismo trayecto.

Cada punto del servicio tiene una **direccion especifica**, un tipo (recogida o entrega),
un **orden dentro de la ruta**, un estado de ejecucion y, en la mayoria de los casos, una
**ventana horaria** acordada con el cliente o el destinatario.

### 3.3 Ventanas horarias

Las ventanas horarias son rangos de tiempo dentro de los cuales el remitente o el
destinatario autoriza la operacion de carga o descarga. Su cumplimiento es un
**indicador de calidad del servicio** y su incumplimiento puede derivar en penalizaciones
contractuales o rechazos de entrega.

La base de datos debe registrar la ventana horaria acordada para cada punto del servicio
y la fecha y hora real de ejecucion, permitiendo calcular desviaciones y generar informes
de puntualidad.

### 3.4 Urgencias y compromisos de servicio

Algunos servicios tienen **niveles de urgencia diferenciados** o compromisos de entrega
especificos (fecha garantizada, entrega en el dia, servicio nocturno, etc.). Estos
compromisos deben quedar registrados para que el departamento de trafico priorice la
planificacion de recursos y para que el sistema de seguimiento permita detectar riesgos
de incumplimiento con antelacion.

---

## 4. Tipos de mercancia y condiciones especiales

### 4.1 Heterogeneidad de la carga

La empresa transporta mercancias heterogeneas. A efectos operativos y documentales,
se distinguen principalmente:

- **Mercancia general paletizada:** el tipo mas habitual. Mercancias sobre palets estandar,
  aptas para cualquier vehiculo de caja cerrada o lona.
- **Bultos y piezas sueltas:** mercancias no paletizables (rollos, piezas de gran formato,
  maquinaria, etc.) que requieren instrucciones de manipulacion especificas.
- **Carga completa (FTL, Full Truck Load):** el vehiculo se destina en exclusiva a la
  mercancia de un unico cliente.
- **Carga parcial (LTL):** el vehiculo agrupa mercancias de varios clientes en un mismo
  trayecto.

### 4.2 Condiciones especiales y requisitos operativos

Determinados envios requieren **condiciones operativas especificas** que deben quedar
registradas y vinculadas al servicio correspondiente:

- **Control de temperatura:** mercancias farmaceuticas, alimentarias o biologicas que
  exigen transporte en rangos termicos controlados (frio positivo, frio negativo, etc.).
- **Manipulacion especial:** mercancias fragiles, peligrosas, de alto valor o con
  restricciones de apilado o carga.
- **Seguros adicionales:** mercancias de alto valor que requieren coberturas especificas
  mas alla del seguro basico de transporte.
- **Requisitos documentales del servicio:** ciertos clientes o destinatarios exigen
  documentacion adicional (certificados sanitarios, declaraciones de conformidad, etc.).
- **Restricciones de acceso:** limitaciones de horario, matriculas o dimensiones de
  vehiculo en determinadas instalaciones o municipios.

Estos **requisitos operativos especiales** deben quedar asociados al servicio de forma
que los departamentos implicados (trafico, conductor, cliente) dispongan de la informacion
necesaria antes y durante la ejecucion del servicio.

---

## 5. Necesidad de evidencias internas y control documental

### 5.1 Evidencias vinculadas al servicio

En el sector del transporte internacional por carretera es obligatorio conservar evidencias
internas que acrediten la correcta ejecucion de cada servicio. Las principales son:

- **Carta de Porte CMR:** documento legal internacional que acredita el contrato de
  transporte, la recepcion de la mercancia y su entrega. Debe firmarse en origen y destino.
- **Albaranes de entrega:** documentos que acreditan la conformidad del receptor con la
  mercancia recibida.
- **Partes de incidencia:** documentos que acreditan y detallan cualquier anomalia ocurrida
  durante la ejecucion del servicio.
- **Evidencias adicionales:** fotos, registros de temperatura, certificados de conformidad
  u otros documentos especificos segun el tipo de mercancia o los requisitos del cliente.

La base de datos debe permitir registrar y controlar la recepcion de estos documentos
para cada servicio, garantizando que ningun servicio cerrado carezca de la documentacion
minima exigible.

### 5.2 Vigencias y caducidades de documentos de recursos

Los recursos operativos (vehiculos, remolques y conductores) requieren documentacion
habilitante que debe mantenerse vigente en todo momento:

- **Vehiculos y remolques:** permiso de circulacion, seguro obligatorio, inspeccion tecnica
  periodica (ITV), tacografo calibrado y, si procede, autorizaciones especiales de transporte.
- **Conductores:** permiso de conducir con las categorias habilitantes (C, C+E), tarjeta de
  cualificacion del conductor (CAP o CPC), tarjeta de tacografo digital.

El vencimiento de cualquiera de estos documentos **inhabilita el recurso** para la prestacion
de servicios de transporte internacional. La base de datos debe registrar todas las fechas de
caducidad y generar alertas que permitan a los departamentos responsables iniciar las
gestiones de renovacion con suficiente antelacion.

---

## 6. Auditoria interna

La propuesta contempla que la base de datos incorpore mecanismos de **auditoria interna**
que permitan:

- Registrar las operaciones criticas realizadas sobre los datos del sistema (creacion,
  modificacion o cierre de servicios, cambios de estado, modificaciones de asignaciones).
- Identificar al usuario responsable de cada operacion relevante y la fecha y hora en que
  se realizo.
- Garantizar la trazabilidad de los cambios en los datos operativos y economicos del sistema.

Estos registros de auditoria son esenciales para el **control interno** de la empresa y para
responder ante auditorias externas, reclamaciones de clientes o disputas contractuales.

---

## 7. Seguimiento y trazabilidad

La trazabilidad es uno de los elementos centrales de la propuesta. El sistema debe ser capaz
de reconstruir en cualquier momento el **historial completo de un servicio**: cuando se creo,
como evolucionaron sus estados, que eventos de seguimiento se registraron, si tuvo incidencias
y como se resolvieron, que recursos estuvieron asignados y cuando, y cual fue el resultado final.

Para ello, la base de datos mantiene:
- El **estado actual** de cada servicio (campo directo en la entidad SERVICIO).
- Un **registro historico de eventos de seguimiento** (entidad EVENTO_SEGUIMIENTO) que
  recoge cronologicamente cada cambio de estado y cada evento relevante del servicio.
- El historial de estados de cada **incidencia** dentro de su propio ciclo de vida.

---

## 8. Problemas que resuelve la base de datos

En el estado actual, la empresa gestiona su operativa con herramientas dispersas: hojas de
calculo, correos electronicos y documentos en papel no integrados entre si. Esta situacion
genera los siguientes problemas que la base de datos propuesta resuelve:

| Problema actual | Solucion aportada |
|---|---|
| Duplicidades e incoherencias en datos de clientes y direcciones | Entidades normalizadas con clave unica |
| Errores de planificacion por datos incompletos o incompatibilidades de asignacion | Control centralizado de disponibilidad de recursos |
| Dificultad para conocer el estado real de un envio y reconstruir su historial | Registro de eventos de seguimiento con trazabilidad completa |
| Control insuficiente de incidencias y costes asociados | Gestion estructurada de incidencias con ciclo de vida propio |
| Poca visibilidad de la rentabilidad por cliente, servicio o periodo | Imputacion de costes por servicio y facturacion relacionada |
| Complejidad para localizar evidencias documentales | Registro de documentacion asociada a cada servicio |
| Documentos de recursos que caducan sin aviso | Control de vigencias con fechas de caducidad por recurso |
| Ausencia de trazabilidad en operaciones criticas | Registros de auditoria interna con usuario y fecha |

---

## 9. Utilidad de la base de datos para la empresa

### 9.1 Gestion operativa diaria

- Registrar y planificar servicios de transporte con todos sus puntos, ventanas horarias y
  requisitos especiales.
- Realizar seguimiento mediante estados y eventos, manteniendo un historial consultable
  en todo momento.
- Gestionar incidencias y su resolucion con trazabilidad completa.

### 9.2 Coordinacion de recursos

- Organizar asignaciones de vehiculos, remolques y conductores de forma coherente en el tiempo.
- Controlar la disponibilidad real de cada recurso y evitar conflictos de planificacion.
- Gestionar la documentacion habilitante de cada recurso con alertas de caducidad.

### 9.3 Control economico y analisis

- Imputar costes operativos (combustible, peajes, mantenimiento) a cada servicio.
- Relacionar ingresos (facturacion) con costes para calcular rentabilidad.
- Analizar resultados por cliente, periodo, vehiculo o tipo de servicio.

### 9.4 Calidad de servicio y atencion al cliente

- Consultar rapidamente el estado e historial de cualquier servicio o envio.
- Responder con informacion estructurada ante consultas y reclamaciones de clientes.
- Controlar el cumplimiento de ventanas horarias y compromisos de servicio.

### 9.5 Control interno y evidencias

- Asociar documentacion y requisitos internos a cada servicio.
- Controlar vigencias y caducidades de documentos vinculados a la operativa.
- Mantener registros de auditoria interna para garantizar la trazabilidad de operaciones criticas.

---

## 10. Uso por departamentos

| Departamento | Uso principal de la base de datos |
|---|---|
| **Operaciones / Trafico** | Planificacion y creacion de servicios, asignacion de recursos, seguimiento de estados, gestion de incidencias, control de ventanas horarias |
| **Atencion al cliente / Comercial** | Consulta de estado e historial de servicios, respuesta a consultas y reclamaciones, gestion de datos de clientes y contactos |
| **Flota / Mantenimiento** | Gestion de vehiculos y remolques, control de disponibilidad, registro de mantenimientos, control de caducidades documentales |
| **Finanzas** | Registro de costes operativos por servicio, facturacion de servicios, seguimiento de cobros, analisis de rentabilidad |
| **RR. HH.** | Gestion de datos de conductores, control de disponibilidad, control de documentacion habilitante con fechas de caducidad |
| **Cumplimiento / Calidad** | Control documental de servicios (CMR, albaranes), supervision de requisitos especiales, consulta de registros de auditoria interna |