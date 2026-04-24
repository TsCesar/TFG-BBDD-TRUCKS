# Esquema Relacional

**Proyecto:** Diseño, creación y explotación de una base de datos para la gestión integral
de una empresa de transporte intracomunitario por carretera (UE) en MySQL (phpMyAdmin)
**Fase:** 3 - Modelo Lógico y Normalización
**Módulo:** Proyecto 2 DAM - Centro FP María Auxiliadora - Curso 2024-26

---

## 1. Metodología de transformación E/R → Relacional

El esquema relacional se obtiene aplicando sistemáticamente las siguientes reglas de
transformación sobre el modelo E/R de FASE 2:

| Regla | Tipo de construcción E/R | Resultado en el modelo relacional |
|:---:|---|---|
| R1 | Entidad regular | Una tabla con todos sus atributos; la clave primaria conceptual se convierte en PK |
| R2 | Relación 1:N | FK en la tabla del lado N, referenciando la PK del lado 1 |
| R3 | Relación 1:N con participación parcial en N | FK nullable en el lado N |
| R4 | Relación 1:1 con participación total en ambas | FK en la tabla dependiente con restricción UNIQUE |
| R5 | Entidad asociativa con atributos propios | Tabla propia con PK artificial + FKs a todas las entidades participantes |
| R6 | Entidad transversal sin FK semánticas | Tabla propia; referencias por nombre de entidad e identificador numérico |

**Relaciones N:M en el modelo de FASE 2:** No existen relaciones N:M directas entre entidades simples en el modelo conceptual cerrado. La única relación que podría interpretarse como N:M (conductor-vehículo-remolque-servicio) ya fue resuelta en FASE 2 mediante la entidad asociativa ASIGNACION, que tiene atributos propios y ciclo de vida independiente. No se generan nuevas tablas intermedias en FASE 3.

---

## 2. Convenciones de este documento

- **PK** = Clave primaria
- **FK** = Clave foránea
- **NN** = NOT NULL (valor obligatorio)
- **UQ** = UNIQUE (valor único en la tabla)
- Los tipos de dato son **lógicos** (independientes de MySQL), notación:
  - `ENTERO` — número entero; los PKs son autoincrementables
  - `TEXTO(n)` — cadena de longitud variable, máximo n caracteres recomendado
  - `DECIMAL(p,s)` — número exacto con p dígitos totales y s decimales
  - `FECHA` — fecha sin hora
  - `FECHAHORA` — fecha con hora y minutos
  - `BOOLEANO` — verdadero / falso
  - `ENUMERADO(v1, v2, ...)` — conjunto cerrado de valores permitidos

---

## Área 1 — Clientes y terceros

### Tabla CLIENTE

**Descripción:** Empresa o persona que contrata servicios de transporte. Actor externo
principal del sistema; es el origen de servicios, de facturas y de los contactos y
direcciones operativas asociadas.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_cliente** | ENTERO | PK, NN | Identificador único autoincrementable |
| nombre_razon_social | TEXTO(200) | NN | Nombre completo o razón social |
| cif_nif | TEXTO(20) | NN, UQ | Identificador fiscal |
| pais | TEXTO(60) | NN | País de registro o sede principal |
| ciudad | TEXTO(100) | | Ciudad de la sede principal |
| direccion_sede | TEXTO(250) | | Dirección postal de la sede principal |
| telefono | TEXTO(30) | | Teléfono de contacto principal |
| email | TEXTO(150) | | Correo electrónico de contacto principal |
| condiciones_pago | TEXTO(100) | | Plazo y forma de pago acordados comercialmente |
| activo | BOOLEANO | NN, DEFAULT TRUE | Indica si el cliente está activo en el sistema |

**Clave primaria:** `id_cliente`
**Claves foráneas:** Ninguna
**Restricciones adicionales:** `cif_nif` es único a nivel global; garantiza que no se duplica ningún cliente por error de introducción de datos.

---

### Tabla CONTACTO

**Descripción:** Persona física dentro de una empresa cliente con la que la operadora
se relaciona en el día a día (responsables de logística, compras, administración, etc.).
Un cliente puede tener varios contactos; cada contacto pertenece a exactamente un cliente.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_contacto** | ENTERO | PK, NN | Identificador único autoincrementable |
| id_cliente | ENTERO | NN, FK → CLIENTE.id_cliente | Cliente al que pertenece el contacto |
| nombre | TEXTO(100) | NN | Nombre del contacto |
| apellidos | TEXTO(150) | NN | Apellidos del contacto |
| cargo | TEXTO(100) | | Cargo o puesto en la empresa cliente |
| telefono | TEXTO(30) | | Teléfono directo del contacto |
| email | TEXTO(150) | | Correo electrónico del contacto |
| es_principal | BOOLEANO | NN | Indica si es el contacto principal del cliente |

**Clave primaria:** `id_contacto`
**Claves foráneas:** `id_cliente` → CLIENTE.id_cliente (R-01)
**Restricciones adicionales:** Puede haber a lo sumo un contacto con `es_principal = TRUE` por cliente; restricción de integridad a verificar a nivel de aplicación.

---

### Tabla DIRECCION_OPERATIVA

**Descripción:** Ubicación física desde la que opera un cliente: almacenes, plantas de
producción, delegaciones o centros de distribución. Se reutiliza como referencia en los
puntos de servicio para evitar introducir la misma dirección repetidamente.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_direccion** | ENTERO | PK, NN | Identificador único autoincrementable |
| id_cliente | ENTERO | NN, FK → CLIENTE.id_cliente | Cliente propietario de la dirección |
| descripcion | TEXTO(150) | | Nombre o denominación de la instalación |
| direccion | TEXTO(250) | NN | Calle, número y código postal |
| ciudad | TEXTO(100) | NN | Ciudad de la instalación |
| pais | TEXTO(60) | NN | País de la instalación |
| telefono | TEXTO(30) | | Teléfono de contacto de la instalación |
| horario | TEXTO(100) | | Horario habitual de carga y descarga |
| activa | BOOLEANO | NN, DEFAULT TRUE | Indica si la dirección está operativa |

**Clave primaria:** `id_direccion`
**Claves foráneas:** `id_cliente` → CLIENTE.id_cliente (R-02)

---

## Área 2 — Servicios y seguimiento

### Tabla SERVICIO

**Descripción:** Entidad central del sistema. Representa cada operación de transporte
desde la solicitud hasta el cierre y la facturación. Todo el modelo orbita en torno
a esta tabla.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_servicio** | ENTERO | PK, NN | Identificador único autoincrementable |
| id_cliente | ENTERO | NN, FK → CLIENTE.id_cliente | Cliente que contrata el servicio |
| id_factura | ENTERO | FK → FACTURA.id_factura | Factura en la que se agrupa el servicio (NULL si aún no facturado) |
| numero_servicio | TEXTO(20) | NN, UQ | Código interno legible (ej: SRV-2026-0001) |
| fecha_solicitud | FECHA | NN | Fecha en que el cliente realiza el encargo |
| fecha_prevista_recogida | FECHA | NN | Fecha planificada para la primera recogida |
| tipo_servicio | ENUMERADO(FTL, LTL, Especial) | NN | Tipo de carga y operativa del servicio |
| nivel_urgencia | ENUMERADO(Estandar, Urgente, Fecha_garantizada, Nocturno) | NN | Nivel de urgencia o compromiso de entrega |
| estado_actual | ENUMERADO(Pendiente, Planificado, Asignado, En_transito, Entregado, Cerrado, Cancelado, Con_incidencia) | NN | Estado operativo actual del servicio |
| documentacion_completa | BOOLEANO | NN, DEFAULT FALSE | Indica si todos los documentos del servicio han sido recibidos |
| observaciones | TEXTO(500) | | Notas adicionales sobre el encargo |

**Clave primaria:** `id_servicio`
**Claves foráneas:**
- `id_cliente` → CLIENTE.id_cliente (R-03, NOT NULL: todo servicio tiene cliente)
- `id_factura` → FACTURA.id_factura (R-05, nullable: un servicio puede estar pendiente de facturar)

**Justificación de `id_factura` en SERVICIO:** La relación R-05 es 1:N (FACTURA agrupa varios SERVICIOS). La FK se coloca en SERVICIO para representar que muchos servicios apuntan a una factura. El valor NULL indica que el servicio aún no ha sido facturado, cubriendo la participación parcial definida en FASE 2.

---

### Tabla PUNTO_SERVICIO

**Descripción:** Cada parada individual dentro de un servicio: recogida o entrega.
Permite gestionar servicios multipunto con ventanas horarias y estados de ejecución
independientes por parada.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_punto** | ENTERO | PK, NN | Identificador único autoincrementable |
| id_servicio | ENTERO | NN, FK → SERVICIO.id_servicio | Servicio al que pertenece el punto |
| id_direccion | ENTERO | FK → DIRECCION_OPERATIVA.id_direccion | Dirección operativa registrada del cliente (NULL si es ad hoc) |
| tipo | ENUMERADO(Recogida, Entrega) | NN | Tipo de operación en este punto |
| orden | ENTERO | NN | Posición de esta parada dentro de la ruta del servicio |
| direccion | TEXTO(250) | NN | Dirección exacta del punto (se introduce siempre, incluso si id_direccion no es NULL) |
| ciudad | TEXTO(100) | NN | Ciudad del punto |
| pais | TEXTO(60) | NN | País del punto |
| ventana_inicio | FECHAHORA | | Inicio de la ventana horaria acordada |
| ventana_fin | FECHAHORA | | Fin de la ventana horaria acordada |
| fecha_ejecucion_real | FECHAHORA | | Fecha y hora real de ejecución (NULL hasta que se ejecute) |
| estado | ENUMERADO(Pendiente, En_proceso, Completado, Fallido) | NN | Estado de ejecución del punto |
| observaciones | TEXTO(500) | | Instrucciones de acceso, contacto local, restricciones |

**Clave primaria:** `id_punto`
**Claves foráneas:**
- `id_servicio` → SERVICIO.id_servicio (R-06, NOT NULL: todo punto pertenece a un servicio)
- `id_direccion` → DIRECCION_OPERATIVA.id_direccion (R-07, nullable: punto puede ser ad hoc)

**Justificación de `direccion` siempre informada:** Aunque `id_direccion` apunte a una dirección registrada, se almacena también el texto de la dirección como campo independiente. Esto garantiza que el dato quede preservado incluso si la dirección operativa se modifica o desactiva posteriormente.

---

### Tabla EVENTO_SEGUIMIENTO

**Descripción:** Registro cronológico de cada evento relevante en el ciclo de vida de
un servicio. Constituye el historial de trazabilidad completo: permite reconstruir en
cualquier momento la evolución del servicio con fecha, tipo de evento y responsable.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_evento** | ENTERO | PK, NN | Identificador único autoincrementable |
| id_servicio | ENTERO | NN, FK → SERVICIO.id_servicio | Servicio al que pertenece el evento |
| tipo_evento | ENUMERADO(Servicio_creado, Planificado, Asignado, Recogida_completada, En_transito, Llegada_punto, Entrega_completada, Incidencia_registrada, Cerrado, Cancelado, Otro) | NN | Tipo de evento registrado |
| descripcion | TEXTO(500) | NN | Descripción del evento registrado |
| fecha_hora | FECHAHORA | NN | Fecha y hora exacta del evento |
| estado_resultante | ENUMERADO(Pendiente, Planificado, Asignado, En_transito, Entregado, Cerrado, Cancelado, Con_incidencia) | NN | Estado del servicio tras este evento |
| usuario_responsable | TEXTO(100) | NN | Usuario que registró el evento |
| observaciones | TEXTO(500) | | Información adicional sobre el evento |

**Clave primaria:** `id_evento`
**Claves foráneas:** `id_servicio` → SERVICIO.id_servicio (R-08)

---

## Área 3 — Mercancía y requisitos

### Tabla MERCANCIA

**Descripción:** Descripción física de la carga asociada a un servicio: tipo, cantidad,
peso, volumen y valor declarado. Separada de SERVICIO para mantener la información
del encargo operativo independiente de la descripción física de la carga.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_mercancia** | ENTERO | PK, NN | Identificador único autoincrementable |
| id_servicio | ENTERO | NN, UQ, FK → SERVICIO.id_servicio | Servicio al que describe la carga (UQ impone la relación 1:1) |
| descripcion | TEXTO(500) | NN | Descripción general de la carga |
| tipo_carga | ENUMERADO(Paletizada, Bultos, Granel, Maquinaria, Piezas_especiales, Otro) | NN | Tipo de carga |
| num_bultos_palets | ENTERO | | Número de bultos, palés o unidades |
| peso_kg | DECIMAL(10,2) | | Peso total de la carga en kilogramos |
| volumen_m3 | DECIMAL(8,3) | | Volumen total de la carga en metros cúbicos |
| valor_declarado | DECIMAL(12,2) | | Valor declarado de la carga en euros |
| observaciones | TEXTO(500) | | Características adicionales de la carga |

**Clave primaria:** `id_mercancia`
**Claves foráneas:** `id_servicio` → SERVICIO.id_servicio (R-09)

**Justificación de la relación 1:1 mediante UNIQUE:** La relación R-09 es 1:1 con participación total en ambos lados. Se implementa colocando la FK `id_servicio` en MERCANCIA con restricción UNIQUE, lo que garantiza que un servicio no puede tener más de una mercancía y cada mercancía pertenece a un único servicio.

---

### Tabla REQUISITO_ESPECIAL

**Descripción:** Condicionante operativo específico vinculado a un servicio: control de
temperatura, manipulación especial, seguros adicionales, restricciones de acceso u otras
condiciones que afectan a la ejecución. Un servicio puede tener cero o varios.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_requisito** | ENTERO | PK, NN | Identificador único autoincrementable |
| id_servicio | ENTERO | NN, FK → SERVICIO.id_servicio | Servicio al que aplica el requisito |
| tipo | ENUMERADO(Temperatura_controlada, Manipulacion_especial, Seguro_adicional, Restriccion_acceso, Documentacion_adicional, Otro) | NN | Tipo de requisito especial |
| descripcion | TEXTO(500) | NN | Descripción detallada del requisito |
| temperatura_min | DECIMAL(5,1) | | Temperatura mínima requerida en grados Celsius (sólo si tipo = Temperatura_controlada) |
| temperatura_max | DECIMAL(5,1) | | Temperatura máxima requerida en grados Celsius (sólo si tipo = Temperatura_controlada) |
| instrucciones | TEXTO(1000) | | Instrucciones operativas para el conductor o el destinatario |
| verificacion_obligatoria | BOOLEANO | NN | Indica si el requisito debe ser verificado y acreditado documentalmente |

**Clave primaria:** `id_requisito`
**Claves foráneas:** `id_servicio` → SERVICIO.id_servicio (R-10)

---

## Área 4 — Incidencias

### Tabla INCIDENCIA

**Descripción:** Evento no planificado que afecta al desarrollo normal de un servicio
durante su ejecución. Tiene su propio ciclo de vida (abierta → en gestión → resuelta →
cerrada) con trazabilidad de cada cambio de estado, tal como exige la propuesta oficial.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_incidencia** | ENTERO | PK, NN | Identificador único autoincrementable |
| id_servicio | ENTERO | NN, FK → SERVICIO.id_servicio | Servicio en el que se produce la incidencia |
| tipo | ENUMERADO(Averia_vehiculo, Accidente, Demora_significativa, Mercancia_danada, Rechazo_entrega, Problema_documentacion, Problema_acceso, Otro) | NN | Tipo de incidencia |
| descripcion | TEXTO(1000) | NN | Descripción detallada del evento ocurrido |
| fecha_apertura | FECHAHORA | NN | Fecha y hora de apertura de la incidencia |
| prioridad | ENUMERADO(Baja, Media, Alta, Critica) | NN | Nivel de prioridad de la incidencia |
| estado | ENUMERADO(Abierta, En_gestion, Resuelta, Cerrada) | NN | Estado actual de la incidencia |
| fecha_ultima_actualizacion | FECHAHORA | | Fecha y hora del último cambio de estado |
| responsable_gestion | TEXTO(150) | | Persona o departamento que gestiona la incidencia |
| fecha_cierre | FECHAHORA | | Fecha y hora de cierre (NULL mientras esté abierta) |
| descripcion_resolucion | TEXTO(1000) | | Descripción de la solución adoptada |
| genera_coste_adicional | BOOLEANO | NN | Indica si la incidencia generó un coste extra imputable al servicio |

**Clave primaria:** `id_incidencia`
**Claves foráneas:** `id_servicio` → SERVICIO.id_servicio (R-11)

---

## Área 5 — Recursos

### Tabla VEHICULO

**Descripción:** Unidad de motor de la flota propia: cabeza tractora o vehículo rígido.
Recurso clave de la operativa con estado de disponibilidad y documentación propia sujeta
a caducidades.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_vehiculo** | ENTERO | PK, NN | Identificador único autoincrementable |
| matricula | TEXTO(15) | NN, UQ | Matrícula oficial del vehículo |
| tipo | ENUMERADO(Cabeza_tractora, Rigido) | NN | Tipo de vehículo |
| marca | TEXTO(60) | | Marca del fabricante |
| modelo | TEXTO(80) | | Modelo específico del vehículo |
| anio_matriculacion | ENTERO | | Año de matriculación |
| capacidad_carga_kg | DECIMAL(10,2) | | Capacidad máxima de carga en kilogramos |
| estado_operativo | ENUMERADO(Disponible, Asignado, Mantenimiento, Baja) | NN | Estado operativo del vehículo |

**Clave primaria:** `id_vehiculo`
**Claves foráneas:** Ninguna

---

### Tabla REMOLQUE

**Descripción:** Elemento de carga acoplable a las cabezas tractoras. Gestionado de
forma independiente porque la combinación tractora-remolque varía por servicio y cada
remolque tiene su propia documentación y fechas de caducidad.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_remolque** | ENTERO | PK, NN | Identificador único autoincrementable |
| matricula | TEXTO(15) | NN, UQ | Matrícula oficial del remolque |
| tipo | ENUMERADO(Lona, Frigorifico, Cisterna, Portacoches, Caja_cerrada, Otro) | NN | Tipo de remolque |
| capacidad_carga_kg | DECIMAL(10,2) | | Capacidad máxima de carga en kilogramos |
| longitud_m | DECIMAL(5,2) | | Longitud del remolque en metros |
| apto_temperatura | BOOLEANO | | Indica si está preparado para control de temperatura |
| estado_operativo | ENUMERADO(Disponible, Asignado, Mantenimiento, Baja) | NN | Estado operativo del remolque |

**Clave primaria:** `id_remolque`
**Claves foráneas:** Ninguna

---

### Tabla CONDUCTOR

**Descripción:** Conductor profesional de la plantilla. Se gestiona su disponibilidad,
la documentación habilitante con fechas de caducidad y su vinculación a los servicios
realizados mediante la entidad ASIGNACION.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_conductor** | ENTERO | PK, NN | Identificador único autoincrementable |
| numero_empleado | TEXTO(20) | NN, UQ | Número de empleado interno de la empresa |
| nombre | TEXTO(100) | NN | Nombre del conductor |
| apellidos | TEXTO(150) | NN | Apellidos del conductor |
| fecha_nacimiento | FECHA | | Fecha de nacimiento |
| telefono | TEXTO(30) | | Teléfono de contacto |
| email | TEXTO(150) | | Correo electrónico |
| numero_permiso | TEXTO(30) | NN, UQ | Número del permiso de conducir |
| categorias_permiso | TEXTO(20) | NN | Categorías habilitantes del permiso (ej: C, CE) |
| estado_disponibilidad | ENUMERADO(Disponible, Asignado, Vacaciones, Baja_temporal, Baja_definitiva) | NN | Estado de disponibilidad del conductor |

**Clave primaria:** `id_conductor`
**Claves foráneas:** Ninguna
**Nota sobre `categorias_permiso`:** Se mantiene como campo de texto descriptivo tal como está definido en FASE 2. El campo almacena las categorías habilitantes del conductor (p. ej. "C, CE") y se consulta principalmente como información de contexto, no como criterio de filtrado granular. La discusión de 1FN se desarrolla en el análisis de normalización.

---

### Tabla ASIGNACION

**Descripción:** Entidad asociativa que formaliza la vinculación de un conductor y un
vehículo (y opcionalmente un remolque) a un servicio concreto. Tiene atributos propios
y puede existir historial de asignaciones por servicio cuando se cambian recursos.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_asignacion** | ENTERO | PK, NN | Identificador único autoincrementable |
| id_servicio | ENTERO | NN, FK → SERVICIO.id_servicio | Servicio al que se asignan los recursos |
| id_conductor | ENTERO | NN, FK → CONDUCTOR.id_conductor | Conductor asignado al servicio |
| id_vehiculo | ENTERO | NN, FK → VEHICULO.id_vehiculo | Vehículo asignado al servicio |
| id_remolque | ENTERO | FK → REMOLQUE.id_remolque | Remolque asignado (NULL si no se usa remolque) |
| fecha_asignacion | FECHAHORA | NN | Fecha y hora en que se formalizó la asignación |
| es_activa | BOOLEANO | NN | TRUE: asignación vigente; FALSE: registro histórico sustituido |
| motivo_cambio | TEXTO(500) | | Motivo de reasignación si ésta sustituye a una anterior |
| observaciones | TEXTO(500) | | Notas adicionales sobre la asignación |

**Clave primaria:** `id_asignacion`
**Claves foráneas:**
- `id_servicio` → SERVICIO.id_servicio (R-14)
- `id_conductor` → CONDUCTOR.id_conductor (R-15)
- `id_vehiculo` → VEHICULO.id_vehiculo (R-16)
- `id_remolque` → REMOLQUE.id_remolque (R-17, nullable)

---

## Área 6 — Costes operativos

### Tabla COSTE_OPERATIVO

**Descripción:** Gasto directo imputable a un servicio específico: combustible, peajes,
dietas del conductor, reparaciones urgentes en ruta, seguros adicionales u otros costes.
Permite calcular la rentabilidad real de cada operación comparando costes con ingresos.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_coste** | ENTERO | PK, NN | Identificador único autoincrementable |
| id_servicio | ENTERO | NN, FK → SERVICIO.id_servicio | Servicio al que se imputa el coste |
| tipo_coste | ENUMERADO(Combustible, Peajes, Dietas, Reparacion, Seguro_adicional, Mantenimiento, Otro) | NN | Tipo de gasto operativo |
| importe | DECIMAL(10,2) | NN | Importe del coste en euros |
| fecha | FECHA | NN | Fecha en que se incurrió en el coste |
| descripcion | TEXTO(500) | | Descripción adicional del gasto |
| justificante_disponible | BOOLEANO | NN | Indica si se dispone de factura o justificante del gasto |

**Clave primaria:** `id_coste`
**Claves foráneas:** `id_servicio` → SERVICIO.id_servicio (R-12)

---

## Área 7 — Facturación y cobros

### Tabla FACTURA

**Descripción:** Documento de cobro emitido a un cliente por uno o varios servicios
completados. Tiene su propio ciclo de vida económico independiente del ciclo operativo
del servicio: pendiente, cobrada, vencida, en mora.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_factura** | ENTERO | PK, NN | Identificador único autoincrementable |
| id_cliente | ENTERO | NN, FK → CLIENTE.id_cliente | Cliente al que se emite la factura |
| numero_factura | TEXTO(20) | NN, UQ | Número oficial de la factura (ej: FAC-2026-0001) |
| fecha_emision | FECHA | NN | Fecha en que se emite la factura |
| fecha_vencimiento | FECHA | NN | Fecha límite de pago según condiciones del cliente |
| importe_base | DECIMAL(12,2) | NN | Importe sin impuestos en euros |
| porcentaje_iva | DECIMAL(5,2) | NN | Porcentaje de IVA aplicado |
| importe_total | DECIMAL(12,2) | NN | Importe total con impuestos en euros |
| estado_cobro | ENUMERADO(Pendiente, Cobrada, Vencida, En_mora, Anulada) | NN | Estado actual del cobro |
| fecha_cobro | FECHA | | Fecha en que se recibió el pago (NULL hasta que se cobre) |
| metodo_cobro | TEXTO(100) | | Forma de cobro efectuada (transferencia, cheque, etc.) |

**Clave primaria:** `id_factura`
**Claves foráneas:** `id_cliente` → CLIENTE.id_cliente (R-04)
**Nota sobre `importe_total`:** El importe total puede calcularse como `importe_base * (1 + porcentaje_iva / 100)`. Se almacena como valor explícito para preservar la integridad contable: el importe facturado en el momento de la emisión es un dato inmutable que no debe variar aunque cambien los tipos impositivos. Se discute en el análisis de normalización.

---

## Área 8 — Documentación y control interno

### Tabla DOCUMENTO_SERVICIO

**Descripción:** Documentación vinculada a un servicio: carta de porte CMR, albaranes
de entrega firmados, partes de incidencia formalizados, registros de temperatura,
certificados y otras evidencias. La propuesta exige el control documental de cada servicio.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_documento_srv** | ENTERO | PK, NN | Identificador único autoincrementable |
| id_servicio | ENTERO | NN, FK → SERVICIO.id_servicio | Servicio al que pertenece el documento |
| tipo_documento | ENUMERADO(CMR, Albaran_entrega, Parte_incidencia, Registro_temperatura, Certificado, Foto, Otro) | NN | Tipo de documento de transporte |
| descripcion | TEXTO(500) | | Descripción del contenido del documento |
| fecha_documento | FECHA | NN | Fecha del documento |
| recibido | BOOLEANO | NN | Indica si el documento ha sido recibido y archivado |
| fecha_recepcion | FECHA | | Fecha en que se recibió el documento (NULL si aún no recibido) |
| referencia_archivo | TEXTO(250) | | Referencia al archivo físico o digital del documento |

**Clave primaria:** `id_documento_srv`
**Claves foráneas:** `id_servicio` → SERVICIO.id_servicio (R-13)

---

### Tabla DOCUMENTO_RECURSO

**Descripción:** Documentación con fecha de caducidad vinculada a vehículos, remolques
o conductores: permisos de circulación, seguros, ITV, calibración de tacógrafo, permiso
de conducir, tarjeta de cualificación del conductor (CAP), tarjeta de tacógrafo digital.
La propuesta contempla explícitamente las vigencias/caducidades como parte del control interno.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_documento_rec** | ENTERO | PK, NN | Identificador único autoincrementable |
| id_vehiculo | ENTERO | FK → VEHICULO.id_vehiculo | Vehículo al que pertenece el documento (NULL si no aplica) |
| id_remolque | ENTERO | FK → REMOLQUE.id_remolque | Remolque al que pertenece el documento (NULL si no aplica) |
| id_conductor | ENTERO | FK → CONDUCTOR.id_conductor | Conductor al que pertenece el documento (NULL si no aplica) |
| tipo_documento | ENUMERADO(Permiso_circulacion, Seguro, ITV, Tacografo_calibracion, Permiso_conducir, CAP, Tarjeta_tacografo, Autorizacion_especial, Otro) | NN | Tipo de documento de recurso |
| numero_documento | TEXTO(60) | | Número o referencia del documento |
| fecha_emision | FECHA | | Fecha de emisión del documento |
| fecha_caducidad | FECHA | NN | Fecha hasta la que el documento es válido |
| organismo_emisor | TEXTO(150) | | Organismo o entidad que emite el documento |
| referencia_archivo | TEXTO(250) | | Referencia al archivo físico o digital del documento |

**Clave primaria:** `id_documento_rec`
**Claves foráneas:**
- `id_vehiculo` → VEHICULO.id_vehiculo (R-18, nullable)
- `id_remolque` → REMOLQUE.id_remolque (R-19, nullable)
- `id_conductor` → CONDUCTOR.id_conductor (R-20, nullable)

**Restricción lógica crítica:** Exactamente uno de los tres campos (`id_vehiculo`, `id_remolque`, `id_conductor`) debe contener un valor en cada registro. Los otros dos deben ser NULL. Esta restricción garantiza que cada documento esté vinculado a exactamente un recurso, sin ambigüedad. En FASE 4 se materializará como un `CHECK` en MySQL.

**Justificación del diseño con tres FK opcionales:** Se mantiene la solución adoptada en FASE 2, que opta por este enfoque pragmático frente a la alternativa de una superentidad RECURSO con herencia de subtipos, de mayor complejidad para el nivel del proyecto y sin ventajas prácticas en este dominio.

---

### Tabla REGISTRO_AUDITORIA

**Descripción:** Registro de las operaciones críticas realizadas sobre el sistema:
creación y modificación de servicios, cambios de estado, asignaciones, facturas y costes.
Garantiza la trazabilidad de operaciones y el control interno exigido por la propuesta oficial.

| Columna | Tipo lógico | Restricciones | Descripción |
|---|---|---|---|
| **id_auditoria** | ENTERO | PK, NN | Identificador único autoincrementable |
| tipo_operacion | ENUMERADO(Crear, Modificar, Eliminar, Cambio_estado, Asignar, Facturar, Cobrar) | NN | Tipo de operación realizada |
| entidad_afectada | TEXTO(60) | NN | Nombre de la tabla/entidad sobre la que se realizó la operación |
| id_registro_afectado | ENTERO | NN | Identificador del registro afectado por la operación |
| usuario | TEXTO(100) | NN | Usuario que realizó la operación |
| fecha_hora | FECHAHORA | NN | Fecha y hora exacta de la operación |
| descripcion | TEXTO(1000) | | Descripción del cambio; valores anteriores y nuevos si aplica |

**Clave primaria:** `id_auditoria`
**Claves foráneas:** Ninguna

**Justificación de la ausencia de FK:** REGISTRO_AUDITORIA es una entidad transversal que registra operaciones sobre cualquier tabla del sistema. Añadir FK a cada entidad auditada haría el diseño rígido y dificultaría auditar entidades eliminadas (registro huérfano). Las referencias se mantienen mediante `entidad_afectada` (nombre de tabla en texto) y `id_registro_afectado` (clave numérica), diseño coherente con el modelo conceptual de FASE 2 y con los patrones habituales de tablas de auditoría.

---

## 3. Resumen del esquema relacional

### 3.1 Relación de tablas por área

| # | Tabla | Área funcional | PK | FKs obligatorias | FKs opcionales |
|:---:|---|---|---|---|---|
| 1 | CLIENTE | Clientes y terceros | id_cliente | — | — |
| 2 | CONTACTO | Clientes y terceros | id_contacto | id_cliente | — |
| 3 | DIRECCION_OPERATIVA | Clientes y terceros | id_direccion | id_cliente | — |
| 4 | SERVICIO | Servicios y seguimiento | id_servicio | id_cliente | id_factura |
| 5 | PUNTO_SERVICIO | Servicios y seguimiento | id_punto | id_servicio | id_direccion |
| 6 | EVENTO_SEGUIMIENTO | Servicios y seguimiento | id_evento | id_servicio | — |
| 7 | MERCANCIA | Mercancía y requisitos | id_mercancia | id_servicio (UQ) | — |
| 8 | REQUISITO_ESPECIAL | Mercancía y requisitos | id_requisito | id_servicio | — |
| 9 | INCIDENCIA | Incidencias | id_incidencia | id_servicio | — |
| 10 | VEHICULO | Recursos | id_vehiculo | — | — |
| 11 | REMOLQUE | Recursos | id_remolque | — | — |
| 12 | CONDUCTOR | Recursos | id_conductor | — | — |
| 13 | ASIGNACION | Recursos | id_asignacion | id_servicio, id_conductor, id_vehiculo | id_remolque |
| 14 | COSTE_OPERATIVO | Costes operativos | id_coste | id_servicio | — |
| 15 | FACTURA | Facturación y cobros | id_factura | id_cliente | — |
| 16 | DOCUMENTO_SERVICIO | Documentación y control | id_documento_srv | id_servicio | — |
| 17 | DOCUMENTO_RECURSO | Documentación y control | id_documento_rec | — | id_vehiculo / id_remolque / id_conductor (exactamente 1) |
| 18 | REGISTRO_AUDITORIA | Documentación y control | id_auditoria | — | — |

### 3.2 Orden de creación en FASE 4 (respeta dependencias)

El siguiente orden garantiza que las FK siempre referencian tablas ya existentes:

```
1.  CLIENTE
2.  VEHICULO
3.  REMOLQUE
4.  CONDUCTOR
5.  DIRECCION_OPERATIVA       → depende de CLIENTE
6.  CONTACTO                  → depende de CLIENTE
7.  FACTURA                   → depende de CLIENTE
8.  SERVICIO                  → depende de CLIENTE, FACTURA (nullable)
9.  PUNTO_SERVICIO            → depende de SERVICIO, DIRECCION_OPERATIVA (nullable)
10. EVENTO_SEGUIMIENTO        → depende de SERVICIO
11. MERCANCIA                 → depende de SERVICIO
12. REQUISITO_ESPECIAL        → depende de SERVICIO
13. INCIDENCIA                → depende de SERVICIO
14. ASIGNACION                → depende de SERVICIO, CONDUCTOR, VEHICULO, REMOLQUE (nullable)
15. COSTE_OPERATIVO           → depende de SERVICIO
16. DOCUMENTO_SERVICIO        → depende de SERVICIO
17. DOCUMENTO_RECURSO         → depende de VEHICULO, REMOLQUE, CONDUCTOR (todas nullable)
18. REGISTRO_AUDITORIA        → sin dependencias
```

> **Nota:** La referencia circular aparente entre SERVICIO (→ FACTURA) y FACTURA (← SERVICIO
> vía los servicios que agrupa) se resuelve porque `SERVICIO.id_factura` es nullable.
> SERVICIO se crea con `id_factura = NULL`; la FK se actualiza cuando se emite la factura.
