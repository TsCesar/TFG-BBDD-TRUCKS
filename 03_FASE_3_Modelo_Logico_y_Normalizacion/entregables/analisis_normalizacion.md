# Analisis de Normalizacion

**Proyecto:** Diseno, creacion y explotacion de una base de datos para la gestion integral
de una empresa de transporte intracomunitario por carretera (UE) en MySQL (phpMyAdmin)
**Fase:** 3 - Modelo Logico y Normalizacion
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora - Curso 2024-26

> Verificacion formal de que las 18 tablas del esquema relacional cumplen la
> Primera Forma Normal (1FN), la Segunda Forma Normal (2FN) y la Tercera Forma
> Normal (3FN). Incluye las dependencias funcionales de cada tabla y justificacion
> de las decisiones de diseno que podrian suscitar dudas.

---

## 1. Definiciones de referencia

### Primera Forma Normal (1FN)

Una tabla esta en 1FN cuando:
1. Todos los valores de sus columnas son atomicos (no divisibles: no listas, no grupos repetidos).
2. Todos los valores de una misma columna son del mismo tipo.
3. La tabla tiene una clave primaria que identifica unicamente cada fila.
4. No existen columnas que representen el mismo tipo de dato con nombres distintos (columnas repetidas).

### Segunda Forma Normal (2FN)

Una tabla en 1FN esta ademas en 2FN cuando:
- Todos los atributos no clave dependen de la **totalidad** de la clave primaria,
  no solo de una parte de ella.

> Nota: La 2FN solo puede violarse en tablas con clave primaria compuesta. Una tabla
> con clave primaria simple (de una sola columna) esta en 2FN automaticamente si
> esta en 1FN, porque no existe parte de la clave de la que pueda depender un subconjunto
> de atributos.

### Tercera Forma Normal (3FN)

Una tabla en 2FN esta ademas en 3FN cuando:
- Ningun atributo no clave depende de otro atributo no clave
  (no existen dependencias transitivas a traves de atributos no clave).

Formalmente: para toda dependencia funcional X → Y en la tabla, se debe cumplir
al menos una de estas condiciones:
- X es superclave de la tabla, o
- Y es parte de alguna clave candidata.

---

## 2. Notacion de dependencias funcionales

`A → B` : el atributo A determina funcionalmente el atributo B
`{A, B} → C` : los atributos A y B juntos determinan C
`PK → {todos}` : la clave primaria determina todos los demas atributos (trivial en toda tabla bien disenada)
`A →→ B via C` : A determina B de forma transitiva a traves de C (violacion de 3FN)

---

## 3. Analisis por tabla

---

### 3.1 CLIENTE

**Clave primaria:** id_cliente (simple)

**Dependencias funcionales:**
```
id_cliente → nombre_razon_social
id_cliente → cif_nif
id_cliente → pais
id_cliente → ciudad
id_cliente → direccion_sede
id_cliente → telefono
id_cliente → email
id_cliente → condiciones_pago
id_cliente → activo
cif_nif    → id_cliente   (clave candidata alternativa)
```

**1FN:** Todos los atributos son atomicos. cif_nif es un texto simple, no una lista. ✓
**2FN:** Clave primaria simple → 2FN automatica. ✓
**3FN:** Ninguno de los atributos depende de otro atributo no clave. Las condiciones_pago
son un texto libre asociado al cliente, no determinado por otro campo. ✓

**Conclusion: CLIENTE esta en 3FN.**

---

### 3.2 CONTACTO

**Clave primaria:** id_contacto (simple)

**Dependencias funcionales:**
```
id_contacto → nombre
id_contacto → apellidos
id_contacto → cargo
id_contacto → telefono
id_contacto → email
id_contacto → es_principal
id_contacto → id_cliente
```

**1FN:** Todos los atributos son atomicos. No hay listas de telefonos ni de cargos. ✓
**2FN:** Clave primaria simple → 2FN automatica. ✓
**3FN:** id_cliente es FK, no un atributo del que dependan otros atributos de esta tabla.
El nombre y apellidos del contacto no determinan el cargo ni viceversa. ✓

**Conclusion: CONTACTO esta en 3FN.**

---

### 3.3 DIRECCION_OPERATIVA

**Clave primaria:** id_direccion (simple)

**Dependencias funcionales:**
```
id_direccion → descripcion
id_direccion → direccion
id_direccion → ciudad
id_direccion → pais
id_direccion → telefono
id_direccion → horario
id_direccion → activa
id_direccion → id_cliente
```

**1FN:** Todos los atributos son atomicos. El horario es un texto descriptivo libre,
no una estructura compleja. ✓
**2FN:** Clave primaria simple → 2FN automatica. ✓
**3FN:** No hay dependencias transitivas. ciudad y pais son atributos directos de la
instalacion, no se deducen el uno del otro ni de ningun otro campo no clave. ✓

**Conclusion: DIRECCION_OPERATIVA esta en 3FN.**

---

### 3.4 SERVICIO

**Clave primaria:** id_servicio (simple)

**Dependencias funcionales:**
```
id_servicio    → numero_servicio
id_servicio    → fecha_solicitud
id_servicio    → fecha_prev_recogida
id_servicio    → tipo_servicio
id_servicio    → nivel_urgencia
id_servicio    → estado_actual
id_servicio    → documentacion_completa
id_servicio    → observaciones
id_servicio    → id_cliente
id_servicio    → id_factura
numero_servicio → id_servicio   (clave candidata alternativa)
```

**1FN:** Todos los atributos son atomicos. estado_actual es un enumerado de valor unico,
no una lista. ✓
**2FN:** Clave primaria simple → 2FN automatica. ✓
**3FN:** Podria plantearse si id_factura determina id_cliente (porque FACTURA ya tiene su
propio id_cliente). Sin embargo, esta no es una dependencia transitiva en SERVICIO porque:
- id_cliente en SERVICIO indica el cliente que contrato el servicio (relacion directa R-03).
- id_factura indica la factura en que se incluye el servicio (relacion R-05, opcional).
- Ambos son atributos propios del servicio, no derivados el uno del otro.
- Que el cliente de la factura coincida con el cliente del servicio es una regla de
  integridad de negocio, no una dependencia funcional interna de la tabla SERVICIO. ✓

**Conclusion: SERVICIO esta en 3FN.**

---

### 3.5 PUNTO_SERVICIO

**Clave primaria:** id_punto (simple)

**Dependencias funcionales:**
```
id_punto → tipo
id_punto → orden
id_punto → direccion
id_punto → ciudad
id_punto → pais
id_punto → ventana_inicio
id_punto → ventana_fin
id_punto → fecha_ejec_real
id_punto → estado
id_punto → observaciones
id_punto → id_servicio
id_punto → id_direccion
```

**1FN:** Todos los atributos son atomicos. La ventana horaria se almacena con dos
columnas separadas (inicio y fin), no como una estructura compleja. ✓
**2FN:** Clave primaria simple → 2FN automatica. ✓
**3FN:** ciudad y pais del punto son atributos del punto concreto (pueden diferir de la
ciudad/pais de la DIRECCION_OPERATIVA referenciada, por ejemplo cuando el punto no
tiene direccion operativa asociada). No hay transitividad. ✓

**Conclusion: PUNTO_SERVICIO esta en 3FN.**

---

### 3.6 EVENTO_SEGUIMIENTO

**Clave primaria:** id_evento (simple)

**Dependencias funcionales:**
```
id_evento → tipo_evento
id_evento → descripcion
id_evento → fecha_hora
id_evento → estado_resultante
id_evento → usuario_responsable
id_evento → observaciones
id_evento → id_servicio
```

**1FN:** Todos los atributos son atomicos. tipo_evento es un enumerado simple. ✓
**2FN:** Clave primaria simple → 2FN automatica. ✓
**3FN:** estado_resultante es el estado del servicio tras este evento especifico;
es un dato registrado en el momento del evento, no derivado de tipo_evento
(el mismo tipo de evento puede tener distintos estados resultantes segun el contexto). ✓

**Conclusion: EVENTO_SEGUIMIENTO esta en 3FN.**

---

### 3.7 MERCANCIA

**Clave primaria:** id_mercancia (simple)

**Dependencias funcionales:**
```
id_mercancia → descripcion
id_mercancia → tipo_carga
id_mercancia → num_bultos_palets
id_mercancia → peso_kg
id_mercancia → volumen_m3
id_mercancia → valor_declarado
id_mercancia → observaciones
id_mercancia → id_servicio
id_servicio  → id_mercancia   (clave candidata alternativa por la restriccion UQ)
```

**1FN:** Todos los atributos son atomicos. ✓
**2FN:** Clave primaria simple → 2FN automatica. ✓
**3FN:** Los atributos de medida (peso_kg, volumen_m3, num_bultos_palets) son
caracteristicas independientes de la carga; ninguno determina a los otros de forma
funcional. ✓

**Cardinalidad 1:1:** La restriccion UQ sobre id_servicio garantiza la relacion
uno a uno con SERVICIO (R-09 del modelo conceptual). id_servicio actua como
clave candidata alternativa en MERCANCIA.

**Conclusion: MERCANCIA esta en 3FN.**

---

### 3.8 REQUISITO_ESPECIAL

**Clave primaria:** id_requisito (simple)

**Dependencias funcionales:**
```
id_requisito → tipo
id_requisito → descripcion
id_requisito → temperatura_min
id_requisito → temperatura_max
id_requisito → instrucciones
id_requisito → verificacion_obligatoria
id_requisito → id_servicio
```

**1FN:** Todos los atributos son atomicos. temperatura_min y temperatura_max son
valores decimales simples. ✓
**2FN:** Clave primaria simple → 2FN automatica. ✓
**3FN:** Podria plantearse si temperatura_min y temperatura_max solo tienen sentido
cuando tipo = 'Temperatura_controlada'. Esto es una restriccion condicional de integridad,
no una dependencia funcional: no es que tipo determine temperatura_min, sino que cuando
tipo tiene cierto valor, temperatura_min puede tener valor o no. Las columnas son
atributos propios del requisito, no determinadas entre si. ✓

**Conclusion: REQUISITO_ESPECIAL esta en 3FN.**

---

### 3.9 INCIDENCIA

**Clave primaria:** id_incidencia (simple)

**Dependencias funcionales:**
```
id_incidencia → tipo
id_incidencia → descripcion
id_incidencia → fecha_apertura
id_incidencia → prioridad
id_incidencia → estado
id_incidencia → fecha_ultima_actualizacion
id_incidencia → responsable_gestion
id_incidencia → fecha_cierre
id_incidencia → descripcion_resolucion
id_incidencia → genera_coste_adicional
id_incidencia → id_servicio
```

**1FN:** Todos los atributos son atomicos. ✓
**2FN:** Clave primaria simple → 2FN automatica. ✓
**3FN:** fecha_cierre y descripcion_resolucion son nulos mientras estado != 'Cerrada';
sin embargo, esto es de nuevo una restriccion de integridad condicional, no una
dependencia funcional: estado no determina funcionalmente fecha_cierre (fecha_cierre
es un dato registrado en el momento del cierre, no calculable a partir de estado). ✓

**Conclusion: INCIDENCIA esta en 3FN.**

---

### 3.10 VEHICULO

**Clave primaria:** id_vehiculo (simple)

**Dependencias funcionales:**
```
id_vehiculo → matricula
id_vehiculo → tipo
id_vehiculo → marca
id_vehiculo → modelo
id_vehiculo → anio_matriculacion
id_vehiculo → capacidad_carga_kg
id_vehiculo → estado_operativo
matricula   → id_vehiculo   (clave candidata alternativa)
```

**1FN:** Todos los atributos son atomicos. ✓
**2FN:** Clave primaria simple → 2FN automatica. ✓
**3FN:** No hay dependencias entre atributos no clave. La marca no determina el modelo
(un mismo modelo existe en varias marcas) ni la capacidad de carga. ✓

**Conclusion: VEHICULO esta en 3FN.**

---

### 3.11 REMOLQUE

**Clave primaria:** id_remolque (simple)

**Dependencias funcionales:**
```
id_remolque → matricula
id_remolque → tipo
id_remolque → capacidad_carga_kg
id_remolque → longitud_m
id_remolque → apto_temperatura
id_remolque → estado_operativo
matricula   → id_remolque   (clave candidata alternativa)
```

**1FN:** Todos los atributos son atomicos. ✓
**2FN:** Clave primaria simple → 2FN automatica. ✓
**3FN:** apto_temperatura es una caracteristica propia del remolque, no determinada
por tipo (aunque en la practica los remolques de tipo Frigorifico suelen tener
apto_temperatura = true, esto es una correlacion practica, no una dependencia funcional
formal en el modelo). ✓

**Conclusion: REMOLQUE esta en 3FN.**

---

### 3.12 CONDUCTOR

**Clave primaria:** id_conductor (simple)

**Dependencias funcionales:**
```
id_conductor    → numero_empleado
id_conductor    → nombre
id_conductor    → apellidos
id_conductor    → fecha_nacimiento
id_conductor    → telefono
id_conductor    → email
id_conductor    → numero_permiso
id_conductor    → categorias_permiso
id_conductor    → estado_disponibilidad
numero_empleado → id_conductor   (clave candidata alternativa)
numero_permiso  → id_conductor   (clave candidata alternativa)
```

**1FN:** categorias_permiso almacena las categorias habilitantes como un texto simple
(ej: "C, CE"). En el modelo logico este dato se trata como un texto atomico en la
entidad CONDUCTOR; si en la fase de implementacion se requiriese consultar por categoria
individual, podria normalizarse a una tabla CATEGORIA_PERMISO. A nivel de modelo logico
de TFG se acepta como atributo atomico porque el alcance de la propuesta no contempla
consultas por categoria individual de permiso. ✓
**2FN:** Clave primaria simple → 2FN automatica. ✓
**3FN:** No hay dependencias entre atributos no clave. ✓

**Conclusion: CONDUCTOR esta en 3FN.**

---

### 3.13 ASIGNACION

**Clave primaria:** id_asignacion (simple)

**Dependencias funcionales:**
```
id_asignacion → fecha_asignacion
id_asignacion → es_activa
id_asignacion → motivo_cambio
id_asignacion → observaciones
id_asignacion → id_servicio
id_asignacion → id_conductor
id_asignacion → id_vehiculo
id_asignacion → id_remolque
```

**1FN:** Todos los atributos son atomicos. ✓
**2FN:** Clave primaria simple → 2FN automatica. ✓
**3FN:** Las cuatro FK son referencias a entidades externas; ninguna determina
funcionalmente a otra dentro de ASIGNACION. motivo_cambio es un texto libre que no
determina ningun otro campo. ✓

**Nota sobre la clave candidata compuesta:** podria argumentarse que la combinacion
{id_servicio, es_activa = true} deberia ser unica (solo una asignacion activa por
servicio). Esto es una restriccion de integridad de negocio, no una clave candidata
formal; se implementaria con un indice unico parcial o una restriccion CHECK en la
fase fisica.

**Conclusion: ASIGNACION esta en 3FN.**

---

### 3.14 COSTE_OPERATIVO

**Clave primaria:** id_coste (simple)

**Dependencias funcionales:**
```
id_coste → tipo_coste
id_coste → importe
id_coste → fecha
id_coste → descripcion
id_coste → justificante_disponible
id_coste → id_servicio
```

**1FN:** Todos los atributos son atomicos. ✓
**2FN:** Clave primaria simple → 2FN automatica. ✓
**3FN:** No hay dependencias entre atributos no clave. importe no es determinado por
tipo_coste (el importe es un dato registrado por el operador, no calculable). ✓

**Conclusion: COSTE_OPERATIVO esta en 3FN.**

---

### 3.15 FACTURA

**Clave primaria:** id_factura (simple)

**Dependencias funcionales:**
```
id_factura      → numero_factura
id_factura      → fecha_emision
id_factura      → fecha_vencimiento
id_factura      → importe_base
id_factura      → porcentaje_iva
id_factura      → importe_total
id_factura      → estado_cobro
id_factura      → fecha_cobro
id_factura      → metodo_cobro
id_factura      → id_cliente
numero_factura  → id_factura   (clave candidata alternativa)
```

**Dependencia a analizar:**
```
{importe_base, porcentaje_iva} → importe_total
```

Esta dependencia significa que importe_total es calculable a partir de dos atributos
no clave, lo que constituye formalmente una dependencia transitiva:
`id_factura → importe_base → (junto con porcentaje_iva) → importe_total`

**Analisis y decision:** La normalizacion estricta a 3FN exigiria eliminar importe_total
como atributo almacenado, dejandolo como valor derivado. Sin embargo, se mantiene como
atributo propio por las siguientes razones justificadas:

1. **Inmutabilidad legal:** Una factura emitida es un documento legal. Su importe total
   no puede recalcularse porque la formula podria cambiar; el importe facturado es el
   valor definitivo registrado en el momento de la emision.
2. **Redondeo y ajustes:** El importe total puede diferir del resultado matematico exacto
   por redondeos legales, descuentos aplicados en el momento de la emision o ajustes
   comerciales posteriores.
3. **Patron estandar:** Almacenar importe_total en la tabla de facturas es practica
   universal en sistemas de facturacion; la alternativa de calcularlo cada vez genera
   riesgo de discrepancias.

**1FN:** ✓  **2FN:** ✓  **3FN:** Aceptada con justificacion tecnica documentada.

**Conclusion: FACTURA esta en 3FN con la excepcion justificada de importe_total.**

---

### 3.16 DOCUMENTO_SERVICIO

**Clave primaria:** id_documento_srv (simple)

**Dependencias funcionales:**
```
id_documento_srv → tipo_documento
id_documento_srv → descripcion
id_documento_srv → fecha_documento
id_documento_srv → recibido
id_documento_srv → fecha_recepcion
id_documento_srv → referencia_archivo
id_documento_srv → id_servicio
```

**1FN:** Todos los atributos son atomicos. ✓
**2FN:** Clave primaria simple → 2FN automatica. ✓
**3FN:** recibido y fecha_recepcion son atributos independientes: es posible registrar
el documento antes de recibirlo fisicamente (recibido = false, fecha_recepcion nulo).
No hay dependencias transitivas. ✓

**Conclusion: DOCUMENTO_SERVICIO esta en 3FN.**

---

### 3.17 DOCUMENTO_RECURSO

**Clave primaria:** id_documento_rec (simple)

**Dependencias funcionales:**
```
id_documento_rec → tipo_documento
id_documento_rec → numero_documento
id_documento_rec → fecha_emision
id_documento_rec → fecha_caducidad
id_documento_rec → organismo_emisor
id_documento_rec → referencia_archivo
id_documento_rec → id_vehiculo
id_documento_rec → id_remolque
id_documento_rec → id_conductor
```

**1FN:** Todos los atributos son atomicos. ✓
**2FN:** Clave primaria simple → 2FN automatica. ✓
**3FN:** Las tres FK son mutuamente excluyentes (restriccion de exclusividad); su
presencia o ausencia en cada fila no genera dependencias entre atributos no clave. ✓

**Nota sobre el diseno con tres FK opcionales:** La alternativa teoricamente mas pura
seria una superentidad RECURSO con herencia de subtipos (VEHICULO, REMOLQUE, CONDUCTOR
como subtipos). Esta solucion introduce complejidad de modelado que excede el alcance
del TFG DAM. La solucion de tres FK opcionales con restriccion de exclusividad es
pragmatica, defendible y esta documentada en la justificacion del modelo conceptual
(seccion 4.4 de justificacion_modelo.md).

**Conclusion: DOCUMENTO_RECURSO esta en 3FN.**

---

### 3.18 REGISTRO_AUDITORIA

**Clave primaria:** id_auditoria (simple)

**Dependencias funcionales:**
```
id_auditoria → tipo_operacion
id_auditoria → entidad_afectada
id_auditoria → id_registro_afectado
id_auditoria → usuario
id_auditoria → fecha_hora
id_auditoria → descripcion
```

**1FN:** Todos los atributos son atomicos. ✓
**2FN:** Clave primaria simple → 2FN automatica. ✓
**3FN:** entidad_afectada e id_registro_afectado son datos registrados en el momento
de la operacion; no hay dependencias entre ellos ni con los demas atributos no clave. ✓

**Conclusion: REGISTRO_AUDITORIA esta en 3FN.**

---

## 4. Resumen del analisis

| # | Tabla | 1FN | 2FN | 3FN | Observacion |
|:---:|---|:---:|:---:|:---:|---|
| 1 | CLIENTE | ✓ | ✓ | ✓ | — |
| 2 | CONTACTO | ✓ | ✓ | ✓ | — |
| 3 | DIRECCION_OPERATIVA | ✓ | ✓ | ✓ | — |
| 4 | SERVICIO | ✓ | ✓ | ✓ | Dos FK directas; sin transitividad interna |
| 5 | PUNTO_SERVICIO | ✓ | ✓ | ✓ | — |
| 6 | EVENTO_SEGUIMIENTO | ✓ | ✓ | ✓ | — |
| 7 | MERCANCIA | ✓ | ✓ | ✓ | UQ en FK para 1:1 con SERVICIO |
| 8 | REQUISITO_ESPECIAL | ✓ | ✓ | ✓ | Columnas temp. condicionales: restriccion de integridad, no FD |
| 9 | INCIDENCIA | ✓ | ✓ | ✓ | Columnas de cierre condicionales |
| 10 | VEHICULO | ✓ | ✓ | ✓ | — |
| 11 | REMOLQUE | ✓ | ✓ | ✓ | — |
| 12 | CONDUCTOR | ✓ | ✓ | ✓ | categorias_permiso como texto atomico; justificado |
| 13 | ASIGNACION | ✓ | ✓ | ✓ | — |
| 14 | COSTE_OPERATIVO | ✓ | ✓ | ✓ | — |
| 15 | FACTURA | ✓ | ✓ | ✓* | importe_total: excepcion justificada |
| 16 | DOCUMENTO_SERVICIO | ✓ | ✓ | ✓ | — |
| 17 | DOCUMENTO_RECURSO | ✓ | ✓ | ✓ | Tres FK opcionales exclusivas; diseno justificado |
| 18 | REGISTRO_AUDITORIA | ✓ | ✓ | ✓ | Entidad transversal; sin FK directas |

**(*) Excepcion aceptada con justificacion tecnica documentada.**

**Resultado: las 18 tablas del modelo relacional cumplen la Tercera Forma Normal.**

---

## 5. Conclusion

El modelo relacional resultante de la transformacion del Diagrama E/R de FASE 2 cumple
la normalizacion hasta 3FN en todas sus tablas. La unica excepcion formal (importe_total
en FACTURA) esta justificada por razones legales, tecnicas y de practica del sector, y
es un patron de diseno aceptado en la literatura de bases de datos relacionales aplicadas.

No se ha identificado ningun caso que requiriese descomponer una tabla del modelo
conceptual para alcanzar 3FN, lo que valida la calidad del modelo E/R disenado en FASE 2:
las decisiones de separar entidades como MERCANCIA, PUNTO_SERVICIO, EVENTO_SEGUIMIENTO
y COSTE_OPERATIVO en lugar de incluirlas como atributos de SERVICIO previenen
precisamente las violaciones de forma normal que se habrian producido con un modelo menos
granular.
