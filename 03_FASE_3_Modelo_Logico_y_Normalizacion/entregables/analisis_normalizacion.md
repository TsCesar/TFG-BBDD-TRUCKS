# Análisis de Normalización

**Proyecto:** Diseño, creación y explotación de una base de datos para la gestión integral
de una empresa de transporte intracomunitario por carretera (UE)
**Fase:** 3 - Modelo Lógico y Normalización
**Módulo:** Proyecto 2 DAM - Centro FP María Auxiliadora - Curso 2024-26

---

## 1. Marco teórico

La normalización es el proceso de organizar los atributos de las tablas de una base de
datos relacional con el objetivo de reducir la redundancia y evitar las anomalías de
inserción, actualización y eliminación. Se basa en el concepto de **dependencia funcional**:

> El atributo B depende funcionalmente de A (A → B) si, conocido el valor de A, el valor
> de B queda determinado de forma única.

Este modelo se normaliza hasta **Tercera Forma Normal (3FN)**, estándar habitual en
bases de datos de gestión empresarial y requisito explícito de la propuesta oficial del TFG.

### 1.1 Definiciones aplicadas

**Primera Forma Normal (1FN):** Una tabla está en 1FN si:
- Todos los atributos contienen valores atómicos (no divisibles en partes con significado independiente para el sistema).
- No existen grupos repetitivos de columnas.
- Existe una clave primaria que identifica de forma única cada fila.

**Segunda Forma Normal (2FN):** Una tabla está en 2FN si:
- Está en 1FN.
- Todos los atributos no clave dependen funcionalmente de **la totalidad** de la clave primaria (sin dependencias parciales).
- Las dependencias parciales sólo son posibles cuando la PK es compuesta (dos o más columnas). Con PK simple, la 2FN es automáticamente satisfecha.

**Tercera Forma Normal (3FN):** Una tabla está en 3FN si:
- Está en 2FN.
- No existen **dependencias transitivas**: ningún atributo no clave depende de otro atributo no clave.
- Es decir: para todo atributo no clave X, no existe un atributo no clave Y tal que PK → Y → X.

---

## 2. Análisis de Primera Forma Normal (1FN)

### 2.1 Evaluación general

Todas las tablas del modelo cumplen los requisitos estructurales de 1FN:

- Cada tabla tiene una clave primaria artificial de tipo entero autoincrementable, que garantiza la unicidad de cada fila.
- Todos los atributos son monovalorados en su definición: cada celda almacena un único valor del tipo declarado.
- No existe ninguna columna que represente un grupo repetitivo (como `telefono1`, `telefono2`, `telefono3`).

### 2.2 Caso resuelto: CONDUCTOR.categorias_permiso y la relación N:M POSEE_CATEGORIA

**Problema de 1FN identificado en FASE 2:** El atributo `categorias_permiso` almacenaba las categorías habilitantes del permiso como un texto único (por ejemplo, `"C, CE"`), lo que constituye un valor no atómico: contiene múltiples valores del mismo dominio semántico en un solo campo. Esto viola la Primera Forma Normal.

**Decisión tomada en FASE 2 (aplicada en FASE 3):** El atributo `categorias_permiso` fue **eliminado** de CONDUCTOR. En su lugar se modela la relación N:M POSEE_CATEGORIA (R-21) entre CONDUCTOR y CATEGORIA_PERMISO, que en FASE 3 se transforma en:

- **Tabla catálogo CATEGORIA_PERMISO:** almacena cada tipo de habilitación reconocida oficialmente (C, CE, C1, C1E, D, B+E, etc.) con su descripción y estado vigente.
- **Tabla intermedia CONDUCTOR_CATEGORIA_PERMISO:** materializa la N:M; cada fila indica que un conductor concreto posee una categoría concreta. Puede incluir opcionalmente `fecha_obtencion`.

**Justificación de la necesidad del modelo N:M:**

1. **Violación de 1FN sin el cambio:** Un campo `"C, CE"` contiene dos valores del mismo dominio semántico. Si un conductor tiene C, CE y C1, el campo crece indefinidamente. No es atómico.
2. **Consultas reales:** El sistema debe poder consultar "todos los conductores habilitados con categoría CE" para planificar vehículos articulados. Con un campo de texto esto requiere búsquedas LIKE frágiles; con la tabla N:M es un JOIN simple.
3. **Integridad referencial:** La tabla CATEGORIA_PERMISO garantiza que solo se registran categorías válidas y homogéneas; los errores tipográficos ("CE," vs "CE") son imposibles.
4. **Coherencia con RA1:** El control de habilitaciones de conductores es un requisito explícito del RA1 (RF-014).

**Conclusión:** La tabla CONDUCTOR cumple 1FN porque `categorias_permiso` fue eliminado. Las habilitaciones se gestionan en CONDUCTOR_CATEGORIA_PERMISO donde cada fila tiene exactamente un conductor y una categoría: valores atómicos.

### 2.3 Resultado de 1FN para todas las tablas

| Tabla | Cumple 1FN | Observación |
|---|:---:|---|
| CLIENTE | ✓ | Todos los atributos son atómicos |
| CONTACTO | ✓ | |
| DIRECCION_OPERATIVA | ✓ | |
| SERVICIO | ✓ | Los enumerados son atómicos por definición |
| PUNTO_SERVICIO | ✓ | |
| EVENTO_SEGUIMIENTO | ✓ | |
| MERCANCIA | ✓ | |
| REQUISITO_ESPECIAL | ✓ | |
| INCIDENCIA | ✓ | |
| VEHICULO | ✓ | |
| REMOLQUE | ✓ | |
| CONDUCTOR | ✓ | `categorias_permiso` eliminado; categorías gestionadas mediante N:M POSEE_CATEGORIA |
| ASIGNACION | ✓ | |
| CATEGORIA_PERMISO | ✓ | Entidad catálogo nueva; todos los atributos son atómicos |
| CONDUCTOR_CATEGORIA_PERMISO | ✓ | Tabla intermedia N:M; PK compuesta — cada celda es un valor atómico |
| COSTE_OPERATIVO | ✓ | |
| FACTURA | ✓ | |
| DOCUMENTO_SERVICIO | ✓ | |
| DOCUMENTO_RECURSO | ✓ | |
| REGISTRO_AUDITORIA | ✓ | |

---

## 3. Análisis de Segunda Forma Normal (2FN)

### 3.1 Principio de análisis

La 2FN sólo es relevante cuando la clave primaria es **compuesta** (formada por dos o
más columnas). Con una clave primaria simple (un solo atributo), no puede existir ninguna
dependencia parcial, ya que no hay parte de la clave que sea un subconjunto propio de ella.

### 3.2 Resultado

**Todas las tablas del modelo tienen PK simple** (un entero autoincrementable artificial:
`id_cliente`, `id_servicio`, `id_asignacion`, etc.). Esta es una decisión de diseño
documentada en la Sección 4.1 de la justificación del modelo en FASE 2:

> *"Todas las entidades usan un identificador artificial autoincrementable como PK en lugar
> de identificadores naturales [...] Los identificadores artificiales son inmutables y
> garantizan la estabilidad de todas las relaciones del modelo."*

**Consecuencia:** La 2FN es automáticamente satisfecha en la totalidad del modelo.
No existe ninguna dependencia parcial posible, ya que todas las PKs son de una sola columna.

| Tabla | PK | PK compuesta | Posible dep. parcial | Cumple 2FN |
|---|---|:---:|:---:|:---:|
| 19 tablas con PK simple | `id_*` entero simple | No | No | ✓ |
| CONDUCTOR_CATEGORIA_PERMISO | `(id_conductor, id_categoria)` compuesta | Sí — ver sec. 3.3 | No | ✓ |

### 3.3 Excepción: CONDUCTOR_CATEGORIA_PERMISO (PK compuesta)

La tabla CONDUCTOR_CATEGORIA_PERMISO es la única del modelo con clave primaria compuesta:
`PK = (id_conductor, id_categoria)`.

Dependencias funcionales:
- `(id_conductor, id_categoria)` → fecha_obtencion

Análisis de dependencias parciales:
- ¿Depende `fecha_obtencion` solo de `id_conductor`? No: la fecha en que un conductor obtuvo una categoría depende de cuál conductor y cuál categoría.
- ¿Depende `fecha_obtencion` solo de `id_categoria`? No: distintos conductores pueden haber obtenido la misma categoría en fechas distintas.
- Conclusión: `fecha_obtencion` depende de la totalidad de la PK compuesta, no de ninguna parte por separado.

**Resultado: 2FN ✓** La tabla cumple 2FN. No existe ninguna dependencia parcial.

---

## 4. Análisis de Tercera Forma Normal (3FN)

### 4.1 Metodología

Para verificar la 3FN, se identifican todas las dependencias funcionales no triviales de
cada tabla y se comprueba que ningún atributo no clave determine a otro atributo no clave.

**Dependencia funcional transitiva:** PK → A → B, donde A y B son atributos no clave.
Si existe, B debe extraerse a una tabla propia con A como clave.

### 4.2 Análisis tabla por tabla

---

#### CLIENTE

Dependencias funcionales:
- `id_cliente` → nombre_razon_social, cif_nif, pais, ciudad, direccion_sede, telefono, email, condiciones_pago, activo

Análisis: Todos los atributos dependen directa y exclusivamente de `id_cliente`. No existe ningún atributo no clave que determine a otro. El campo `condiciones_pago` describe las condiciones acordadas con ese cliente concreto, no un catálogo de condiciones independiente.

**Resultado: 3FN ✓**

---

#### CONTACTO

Dependencias funcionales:
- `id_contacto` → id_cliente, nombre, apellidos, cargo, telefono, email, es_principal

Análisis: Todos los atributos dependen de `id_contacto`. `id_cliente` es una FK, no un atributo que determine a otros. No existen dependencias transitivas.

**Resultado: 3FN ✓**

---

#### DIRECCION_OPERATIVA

Dependencias funcionales:
- `id_direccion` → id_cliente, descripcion, direccion, ciudad, pais, telefono, horario, activa

Análisis: Todos los atributos dependen directamente de `id_direccion`. No existen dependencias transitivas.

**Resultado: 3FN ✓**

---

#### SERVICIO

Dependencias funcionales:
- `id_servicio` → id_cliente, id_factura, numero_servicio, fecha_solicitud, fecha_prevista_recogida, tipo_servicio, nivel_urgencia, estado_actual, documentacion_completa, observaciones

Análisis: Todos los atributos describen propiedades directas del servicio. Las FK `id_cliente` e `id_factura` son referencias, no intermediarios que generen dependencias transitivas. El campo `estado_actual` no determina a ningún otro atributo de la tabla.

**Resultado: 3FN ✓**

---

#### PUNTO_SERVICIO

Dependencias funcionales:
- `id_punto` → id_servicio, id_direccion, tipo, orden, direccion, ciudad, pais, ventana_inicio, ventana_fin, fecha_ejecucion_real, estado, observaciones

Análisis: Todos los atributos dependen directamente del punto de servicio. El campo `ciudad` podría parecer derivable de `id_direccion`, pero se almacena de forma independiente porque: (a) el punto puede ser ad hoc sin `id_direccion`; (b) la dirección operativa puede modificarse posteriormente sin que el dato histórico del punto deba cambiar. No hay dependencia transitiva.

**Resultado: 3FN ✓**

---

#### EVENTO_SEGUIMIENTO

Dependencias funcionales:
- `id_evento` → id_servicio, tipo_evento, descripcion, fecha_hora, estado_resultante, usuario_responsable, observaciones

Análisis: Todos los atributos describen propiedades del evento. `estado_resultante` es un atributo del evento en sí, no una derivación de otro atributo no clave de la tabla.

**Resultado: 3FN ✓**

---

#### MERCANCIA

Dependencias funcionales:
- `id_mercancia` → id_servicio, descripcion, tipo_carga, num_bultos_palets, peso_kg, volumen_m3, valor_declarado, observaciones

Análisis: Todos los atributos son propiedades físicas de la carga concreta de ese servicio. No existe ningún atributo que dependa funcionalmente de otro no clave.

**Resultado: 3FN ✓**

---

#### REQUISITO_ESPECIAL

Dependencias funcionales:
- `id_requisito` → id_servicio, tipo, descripcion, temperatura_min, temperatura_max, instrucciones, verificacion_obligatoria

Análisis: Los campos `temperatura_min` y `temperatura_max` sólo tienen valor cuando `tipo = Temperatura_controlada`. Esto podría interpretarse como una dependencia condicional, pero no es una dependencia transitiva en sentido formal: `tipo` no determina los valores de temperatura (pueden variar entre requisitos del mismo tipo para distintos servicios). Son atributos opcionales del requisito, no derivados de él.

**Resultado: 3FN ✓**

---

#### INCIDENCIA

Dependencias funcionales:
- `id_incidencia` → id_servicio, tipo, descripcion, fecha_apertura, prioridad, estado, fecha_ultima_actualizacion, responsable_gestion, fecha_cierre, descripcion_resolucion, genera_coste_adicional

Análisis: Todos los atributos dependen directamente de `id_incidencia`. El campo `fecha_cierre` sólo tiene valor cuando `estado = Cerrada`, pero esto es una restricción de negocio (valor NULL condicional), no una dependencia funcional entre atributos no clave.

**Resultado: 3FN ✓**

---

#### VEHICULO

Dependencias funcionales:
- `id_vehiculo` → matricula, tipo, marca, modelo, anio_matriculacion, capacidad_carga_kg, estado_operativo

Análisis: Todos los atributos son propiedades directas del vehículo. `marca` y `modelo` describen ese vehículo concreto; no se gestiona un catálogo de modelos.

**Resultado: 3FN ✓**

---

#### REMOLQUE

Dependencias funcionales:
- `id_remolque` → matricula, tipo, capacidad_carga_kg, longitud_m, apto_temperatura, estado_operativo

Análisis: Todos los atributos son propiedades del remolque concreto. No existen dependencias transitivas.

**Resultado: 3FN ✓**

---

#### CONDUCTOR

Dependencias funcionales:
- `id_conductor` → numero_empleado, nombre, apellidos, fecha_nacimiento, telefono, email, numero_permiso, estado_disponibilidad

Análisis: Todos los atributos dependen directamente de `id_conductor`. `numero_permiso` es un identificador natural alternativo del conductor, no un determinante de otros atributos. El atributo `categorias_permiso` fue eliminado de CONDUCTOR en FASE 2; las habilitaciones se gestionan en CONDUCTOR_CATEGORIA_PERMISO.

**Resultado: 3FN ✓**

---

#### ASIGNACION

Dependencias funcionales:
- `id_asignacion` → id_servicio, id_conductor, id_vehiculo, id_remolque, fecha_asignacion, es_activa, motivo_cambio, observaciones

Análisis: Todos los atributos son propios de la asignación concreta. Las FK son referencias, no intermediarios que creen dependencias transitivas. El campo `es_activa` no determina a ningún otro.

**Resultado: 3FN ✓**

---

#### COSTE_OPERATIVO

Dependencias funcionales:
- `id_coste` → id_servicio, tipo_coste, importe, fecha, descripcion, justificante_disponible

Análisis: Todos los atributos dependen directamente del coste concreto. No existen dependencias transitivas.

**Resultado: 3FN ✓**

---

#### FACTURA — caso de análisis detallado

Dependencias funcionales identificadas:
- `id_factura` → id_cliente, numero_factura, fecha_emision, fecha_vencimiento, importe_base, porcentaje_iva, importe_total, estado_cobro, fecha_cobro, metodo_cobro

**Dependencia funcional a analizar:**

```
importe_base, porcentaje_iva → importe_total
```

`importe_total` puede calcularse como `importe_base * (1 + porcentaje_iva / 100)`.
`importe_base` y `porcentaje_iva` son atributos no clave, y `importe_total` depende de ellos.
Esto es técnicamente una dependencia transitiva: PK → importe_base → importe_total.

**Decisión justificada: se mantiene `importe_total` como atributo almacenado.**

Razones:

1. **Inmutabilidad contable:** El importe total facturado es un dato legal registrado en el momento de la emisión de la factura. Los tipos impositivos pueden cambiar en el futuro; si `importe_total` fuera calculado dinámicamente, un cambio de tipo alteraría el registro histórico de facturas emitidas, lo cual sería incorrecto contablemente.

2. **Posibles ajustes:** En la práctica, el importe total puede diferir del cálculo matemático exacto debido a redondeos, descuentos negociados o correcciones manuales. Almacenarlo como valor fijo captura el importe real acordado.

3. **Práctica habitual:** El almacenamiento del total en tablas de facturación es una práctica estándar en bases de datos de gestión empresarial, aceptada como excepción justificada a 3FN en el ámbito contable.

**Conclusión:** La tabla FACTURA se considera en 3FN con excepción documentada y justificada para `importe_total`. Esta excepción está motivada por requisitos de integridad contable, no por un descuido de diseño.

**Resultado: 3FN ✓ (con excepción documentada)**

---

#### DOCUMENTO_SERVICIO

Dependencias funcionales:
- `id_documento_srv` → id_servicio, tipo_documento, descripcion, fecha_documento, recibido, fecha_recepcion, referencia_archivo

Análisis: Todos los atributos dependen directamente del documento concreto. `fecha_recepcion` puede ser NULL cuando `recibido = FALSE`, pero esto es una restricción de negocio, no una dependencia funcional entre atributos no clave.

**Resultado: 3FN ✓**

---

#### DOCUMENTO_RECURSO

Dependencias funcionales:
- `id_documento_rec` → id_vehiculo (nullable), id_remolque (nullable), id_conductor (nullable), tipo_documento, numero_documento, fecha_emision, fecha_caducidad, organismo_emisor, referencia_archivo

Análisis: Todos los atributos son propiedades del documento concreto. Las tres FK opcionales son referencias externas, no intermediarios que generen dependencias transitivas entre atributos de la tabla. La restricción "exactamente una FK no nula" es una restricción de integridad, no una dependencia funcional.

**Resultado: 3FN ✓**

---

#### REGISTRO_AUDITORIA

Dependencias funcionales:
- `id_auditoria` → tipo_operacion, entidad_afectada, id_registro_afectado, usuario, fecha_hora, descripcion

Análisis: Todos los atributos son propiedades del registro de auditoría concreto. No existen dependencias entre atributos no clave.

**Resultado: 3FN ✓**

---

### 4.3 Resumen del análisis de 3FN

| Tabla | Dependencias transitivas detectadas | Acción tomada | Cumple 3FN |
|---|---|---|:---:|
| CLIENTE | Ninguna | — | ✓ |
| CONTACTO | Ninguna | — | ✓ |
| DIRECCION_OPERATIVA | Ninguna | — | ✓ |
| SERVICIO | Ninguna | — | ✓ |
| PUNTO_SERVICIO | Ninguna | — | ✓ |
| EVENTO_SEGUIMIENTO | Ninguna | — | ✓ |
| MERCANCIA | Ninguna | — | ✓ |
| REQUISITO_ESPECIAL | Ninguna | — | ✓ |
| INCIDENCIA | Ninguna | — | ✓ |
| VEHICULO | Ninguna | — | ✓ |
| REMOLQUE | Ninguna | — | ✓ |
| CONDUCTOR | Ninguna | — | ✓ |
| ASIGNACION | Ninguna | — | ✓ |
| CATEGORIA_PERMISO | Ninguna | — | ✓ |
| CONDUCTOR_CATEGORIA_PERMISO | Ninguna (único atributo no clave `fecha_obtencion` depende de la PK compuesta completa) | — | ✓ |
| COSTE_OPERATIVO | Ninguna | — | ✓ |
| FACTURA | importe_base + porcentaje_iva → importe_total | Excepción documentada por integridad contable | ✓* |
| DOCUMENTO_SERVICIO | Ninguna | — | ✓ |
| DOCUMENTO_RECURSO | Ninguna | — | ✓ |
| REGISTRO_AUDITORIA | Ninguna | — | ✓ |

---

## 5. Transformaciones aplicadas durante FASE 3

El modelo conceptual de FASE 2 es de alta calidad: no requiere transformaciones disruptivas
de normalización. Las únicas adaptaciones realizadas en FASE 3 son la materialización de
las reglas de transformación E/R → Relacional, no correcciones de anomalías de normalización.

### 5.1 Transformaciones aplicadas

| ID | Transformación | Tabla afectada | Motivo |
|:---:|---|---|---|
| T-01 | FK `id_cliente` añadida a CONTACTO | CONTACTO | Materialización de R-01 (1:N) |
| T-02 | FK `id_cliente` añadida a DIRECCION_OPERATIVA | DIRECCION_OPERATIVA | Materialización de R-02 (1:N) |
| T-03 | FK `id_cliente` añadida a SERVICIO | SERVICIO | Materialización de R-03 (1:N) |
| T-04 | FK `id_cliente` añadida a FACTURA | FACTURA | Materialización de R-04 (1:N) |
| T-05 | FK `id_factura` (nullable) añadida a SERVICIO | SERVICIO | Materialización de R-05 (1:N, participación parcial en SERVICIO) |
| T-06 | FK `id_servicio` añadida a PUNTO_SERVICIO | PUNTO_SERVICIO | Materialización de R-06 (1:N) |
| T-07 | FK `id_direccion` (nullable) añadida a PUNTO_SERVICIO | PUNTO_SERVICIO | Materialización de R-07 (N:1, participación parcial en PUNTO_SERVICIO) |
| T-08 | FK `id_servicio` añadida a EVENTO_SEGUIMIENTO | EVENTO_SEGUIMIENTO | Materialización de R-08 (1:N) |
| T-09 | FK `id_servicio` añadida a MERCANCIA (sin UNIQUE; relación 1:N) | MERCANCIA | Materialización de R-09 CONTIENE_MERCANCIA (1:N, corregida de 1:1 en revisión FASE 2) |
| T-10 | FK `id_servicio` añadida a REQUISITO_ESPECIAL | REQUISITO_ESPECIAL | Materialización de R-10 (1:N) |
| T-11 | FK `id_servicio` añadida a INCIDENCIA | INCIDENCIA | Materialización de R-11 (1:N) |
| T-12 | FK `id_servicio` añadida a COSTE_OPERATIVO | COSTE_OPERATIVO | Materialización de R-12 (1:N) |
| T-13 | FK `id_servicio` añadida a DOCUMENTO_SERVICIO | DOCUMENTO_SERVICIO | Materialización de R-13 (1:N) |
| T-14 | FKs `id_servicio`, `id_conductor`, `id_vehiculo`, `id_remolque` en ASIGNACION | ASIGNACION | Materialización de R-14, R-15, R-16, R-17 |
| T-15 | FK `id_vehiculo` (nullable) en DOCUMENTO_RECURSO | DOCUMENTO_RECURSO | Materialización de R-18 |
| T-16 | FK `id_remolque` (nullable) en DOCUMENTO_RECURSO | DOCUMENTO_RECURSO | Materialización de R-19 |
| T-17 | FK `id_conductor` (nullable) en DOCUMENTO_RECURSO | DOCUMENTO_RECURSO | Materialización de R-20 |

### 5.2 Decisiones sin transformación requerida

- **Todas las relaciones 1:N** del modelo quedan resueltas con una FK en la tabla del lado N.
No fue necesario crear ninguna tabla intermedia adicional porque el modelo de FASE 2 no
contiene relaciones N:M directas entre entidades simples.

- **ASIGNACION** ya actuaba en FASE 2 como entidad asociativa con atributos propios.
No requiere ninguna transformación: se convierte directamente en tabla con sus cuatro FK.

- **REGISTRO_AUDITORIA** ya fue diseñada en FASE 2 como entidad sin FK directas.
Se mantiene exactamente así en el modelo relacional.

---

## 6. Conclusión

El modelo relacional resultante de esta FASE 3 cumple la Tercera Forma Normal (3FN) en
la totalidad de sus 20 tablas:

- **1FN:** Satisfecha. Todos los atributos son atómicos; no existen grupos repetitivos.
  Caso resuelto: el atributo multivaluado `categorias_permiso` fue eliminado de CONDUCTOR
  en FASE 2 porque almacenaba varios valores en un único campo, violando 1FN. En FASE 3
  se materializa la relación N:M mediante CATEGORIA_PERMISO y CONDUCTOR_CATEGORIA_PERMISO,
  donde cada fila contiene exactamente un conductor y una categoría.

- **2FN:** Satisfecha. 19 de las 20 tablas tienen PK simple (un único atributo entero
  autoincrementable), por lo que las dependencias parciales son estructuralmente imposibles
  en ellas. La única tabla con PK compuesta es CONDUCTOR_CATEGORIA_PERMISO; su único
  atributo no clave (`fecha_obtencion`) depende de la totalidad de la PK, no de ninguna
  parte, por lo que también cumple 2FN.

- **3FN:** Satisfecha. No existen dependencias transitivas entre atributos no clave.
  Excepción documentada y justificada: `importe_total` en FACTURA se almacena como valor
  fijo por razones de integridad contable, práctica estándar en sistemas de gestión.

El modelo está libre de redundancias estructurales y de anomalías de inserción,
actualización y eliminación, y queda listo para su implementación física en FASE 4.
