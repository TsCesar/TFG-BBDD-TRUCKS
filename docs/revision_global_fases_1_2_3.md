# Revision Global -- Fases 1, 2 y 3

**Proyecto:** Diseno, creacion y explotacion de una base de datos para la gestion integral
de una empresa de transporte intracomunitario por carretera (UE) en MySQL (phpMyAdmin)
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora - Curso 2024-26
**Fecha de revision:** 2026-05-28
**Alcance:** Revision completa y correctiva de FASE 1, FASE 2 y estado de FASE 3 (dos pasadas)

---

## 1. Objetivo de la revision

Revisar la coherencia, completitud y calidad profesional de FASE 1 y FASE 2 antes de
continuar con FASE 3. Los objetivos concretos de la revision son:

1. Corregir badges de estado para que reflejen el progreso real.
2. Corregir el ano de curso en todos los entregables.
3. Cambiar la cardinalidad SERVICIO-MERCANCIA de 1:1 a 1:N para soportar servicios LTL.
4. Anadir la entidad catalogo CATEGORIA_PERMISO con su relacion N:M POSEE_CATEGORIA con CONDUCTOR.
5. Eliminar el atributo multivaluado `categorias_permiso` de CONDUCTOR (violacion de 1FN).
6. Asignar nombres semanticos a todas las relaciones del modelo.
7. Documentar formalmente el analisis de relaciones N:M en el modelo conceptual.
8. Clasificar cada entidad segun su naturaleza en el modelo (regular, central, asociativa, catalogo, transversal).
9. Completar la guia de dibujo del diagrama E/R.
10. Registrar el impacto de todos los cambios sobre FASE 3.
11. Verificar coherencia con RA1, RA2, propuesta oficial y requisitos del modulo.

---

## 2. Documentos revisados

| Documento | Ubicacion | Tipo de revision |
|---|---|---|
| README.md (raiz) | / | Badge de fase actual |
| FASE 1 README | 01_FASE_1.../README.md | Badge de estado |
| descripcion_dominio.md | 01_FASE_1.../entregables/ | Cabecera de ano |
| requerimientos_cliente.md | 01_FASE_1.../entregables/ | Cabecera de ano |
| casos_de_uso.md | 01_FASE_1.../entregables/ | Cabecera de ano |
| entidades_candidatas.md | 01_FASE_1.../entregables/ | Ano + MERCANCIA LTL + CATEGORIA_PERMISO + relaciones narrativas |
| FASE 2 README | 02_FASE_2.../README.md | Badge + checklist N:M |
| diccionario_entidades.md | 02_FASE_2.../entregables/ | CONDUCTOR (quitar atrib.) + nueva CATEGORIA_PERMISO + tabla resumen con naturaleza |
| diccionario_relaciones.md | 02_FASE_2.../entregables/ | R-09 + R-05 + R-08 + R-10 + R-13 renombradas + R-21 nueva + seccion N:M completa |
| justificacion_modelo.md | 02_FASE_2.../entregables/ | Sec. 3.3 MERCANCIA + sec. 3.5 CATEGORIA_PERMISO + sec. 5 N:M |
| diagrama_entidad_relacion.md | 02_FASE_2.../entregables/ | CONDUCTOR + CATEGORIA_PERMISO + R-21 + nombres semanticos + mapa global corregido |
| diagrama_er_textual.md | 02_FASE_2.../entregables/ | Reescritura completa como guia para dibujar el diagrama |
| FASE 3 README | 03_FASE_3.../README.md | Badge + checklist CATEGORIA_PERMISO + verificacion |
| docs/decisiones_diseno.md | docs/ | DD-002 a DD-005 nuevas decisiones |
| docs/glosario.md | docs/ | 10 nuevos terminos de dominio y modelado |

---

## 3. Cambios aplicados

### 3.1 Correcciones de estado y ano

| Archivo | Cambio |
|---|---|
| README.md raiz | Badge "Fase Actual": FASE%201 → FASE%203; enlace apunta a FASE 3 |
| FASE 1 README | Badge: Pendiente → Completada (verde) |
| FASE 2 README | Badge: Pendiente → Completada (verde) |
| FASE 3 README | Badge: Pendiente → En progreso (amarillo) |
| Todos los entregables FASE 1 | Cabecera: Curso 2023-24 → Curso 2024-26 |
| Todos los entregables FASE 2 | Cabecera: Curso 2023-24 → Curso 2024-26 |

### 3.2 Cambio conceptual: R-09 MERCANCIA de 1:1 a 1:N

La relacion entre SERVICIO y MERCANCIA cambia en cardinalidad y nombre:

| Campo | Antes | Despues |
|---|---|---|
| Nombre | DESCRIBE_CARGA | CONTIENE_MERCANCIA |
| Cardinalidad | 1:1 | 1:N |
| Participacion MERCANCIA | total | total |

**Justificacion:** En servicios LTL (Less than Truck Load) el mismo vehiculo transporta
mercancias de tipos distintos pertenecientes a diferentes expedidores. Cada lote tiene
descripcion, peso, volumen y valor declarado propios. La relacion 1:1 no permite representar
este caso real del dominio.

La relacion sigue siendo 1:N (no N:M) porque cada lote de mercancia es especifico del
servicio en que se transporta; no existe un catalogo de mercancia reutilizable entre servicios.

### 3.3 Nueva entidad: CATEGORIA_PERMISO (entidad catalogo)

Se anade la entidad 19 al modelo conceptual:

| Atributo | Tipo conceptual | Restriccion |
|---|---|---|
| id_categoria | Identificador | PK |
| codigo_categoria | Texto | [oblig][unico] |
| descripcion | Texto | [oblig] |
| activa | Booleano | [oblig] |

**Justificacion:** El atributo `categorias_permiso` en CONDUCTOR era un atributo multivaluado
(un conductor puede tener C, CE, C1, etc.) que viola directamente la Primera Forma Normal
(1FN). La unica solucion correcta en modelo relacional es crear una entidad catalogo y una
relacion N:M entre CONDUCTOR y CATEGORIA_PERMISO.

Esta entidad se comporta como "catalogo": almacena un conjunto estable de valores de
referencia (los tipos de permiso homologados) que son reutilizables entre conductores.

### 3.4 Nueva relacion: R-21 POSEE_CATEGORIA (N:M directa)

Se anade la relacion 21 como la unica N:M directa del modelo conceptual:

| Campo | Valor |
|---|---|
| Codigo | R-21 |
| Nombre | POSEE_CATEGORIA |
| Entidades | CONDUCTOR -- CATEGORIA_PERMISO |
| Cardinalidad | N:M |
| Participacion CONDUCTOR | Total (todo conductor profesional debe tener al menos una categoria vigente) |
| Participacion CATEGORIA_PERMISO | Parcial (puede haber categorias en el catalogo no asignadas aun a ningun conductor activo) |
| Representacion E/R | Rombo <POSEE_CATEGORIA> con linea doble en extremo CONDUCTOR y linea simple en CATEGORIA_PERMISO |

En FASE 3 esta relacion se transformara en la tabla intermedia `CONDUCTOR_CATEGORIA_PERMISO`.

### 3.5 Eliminacion de atributo: categorias_permiso en CONDUCTOR

El atributo `categorias_permiso` (texto libre con varias categorias separadas por coma)
se elimina de la entidad CONDUCTOR en todos los documentos de FASE 2. Queda sustituido
por la relacion R-21 POSEE_CATEGORIA con la entidad catalogo CATEGORIA_PERMISO.

### 3.6 Relaciones renombradas

Todas las relaciones reciben nombres semanticos explicitamente definidos. Los cambios
respecto al modelo anterior son:

| Codigo | Nombre anterior | Nombre nuevo | Motivo del cambio |
|:---:|---|---|---|
| R-05 | SE_FACTURA_EN | AGRUPA_SERVICIOS | La factura agrupa servicios; el nombre anterior era pasivo e impreciso |
| R-08 | TIENE_EVENTO | REGISTRA_EVENTO | Refleja que SERVICIO registra eventos de seguimiento; mas activo |
| R-09 | DESCRIBE_CARGA | CONTIENE_MERCANCIA | Coherente con la cardinalidad 1:N: un servicio "contiene" lotes |
| R-10 | TIENE_REQUISITO | REQUIERE_CONDICION | Refleja la naturaleza de restriccion operativa del requisito |
| R-13 | TIENE_DOCUMENTO | TIENE_DOCUMENTO_SERVICIO | Diferencia explicitamente de TIENE_DOCUMENTO_RECURSO (vehiculo/remolque/conductor) |

Las relaciones R-01 a R-04, R-06, R-07, R-11, R-12, R-14 a R-20 ya tenian nombres
semanticos correctos y se mantienen sin cambio.

### 3.7 Analisis formal de relaciones N:M

Se incorpora una seccion dedicada en diccionario_relaciones.md y en justificacion_modelo.md
que clasifica las relaciones N:M del modelo en tres tipos:

**Tipo 1 -- N:M directa representada con rombo:**
- R-21 POSEE_CATEGORIA (CONDUCTOR -- CATEGORIA_PERMISO): la relacion no tiene atributos propios en el modelo conceptual; se representa con rombo.

**Tipo 2 -- N:M implicita resuelta mediante entidad asociativa:**
- ASIGNACION resuelve simultaneamente las tres N:M implicitas conductor-servicio, vehiculo-servicio y remolque-servicio. Se representa como rectangulo porque tiene atributos propios (fecha_asignacion, es_activa, motivo_cambio) y ciclo de vida independiente.

**Tipo 3 -- Relacion que podria ser N:M pero se modela como 1:N con justificacion:**
- R-09 CONTIENE_MERCANCIA: cada lote es especifico del servicio, no es catalogo reutilizable.
- R-10 REQUIERE_CONDICION: cada requisito es especifico del servicio, no es catalogo reutilizable.
- R-12 GENERA_COSTE: cada coste se imputa a un unico servicio.
- R-13 TIENE_DOCUMENTO_SERVICIO: cada documento de transporte pertenece a un unico servicio.

### 3.8 Clasificacion de entidades por naturaleza

El diccionario_entidades.md incluye ahora la naturaleza de cada entidad en la tabla resumen:

| Naturaleza | Entidades |
|---|---|
| Entidad central | SERVICIO |
| Entidades regulares | CLIENTE, CONTACTO, DIRECCION_OPERATIVA, PUNTO_SERVICIO, EVENTO_SEGUIMIENTO, MERCANCIA, REQUISITO_ESPECIAL, INCIDENCIA, VEHICULO, REMOLQUE, CONDUCTOR, COSTE_OPERATIVO, FACTURA, DOCUMENTO_SERVICIO, DOCUMENTO_RECURSO |
| Entidad asociativa | ASIGNACION |
| Entidad catalogo | CATEGORIA_PERMISO |
| Entidad transversal | REGISTRO_AUDITORIA |

### 3.9 Reescritura de diagrama_er_textual.md

El archivo se reescribe por completo como guia profesional para dibujar el diagrama E/R.
Incluye 7 secciones:

1. **Leyenda de simbolos:** rectangulo/rombo/ovalo/participacion total-parcial/cardinalidad.
2. **19 entidades:** representacion ASCII de cada caja con atributos principales.
3. **21 relaciones:** para cada relacion: entidades involucradas, codigo, nombre semantico, cardinalidad, participacion y como representarla.
4. **Entidades especiales:** reglas de dibujo para ASIGNACION (rectangulo, no rombo) y REGISTRO_AUDITORIA (separada, sin FK).
5. **Distribucion del lienzo:** posicion recomendada de cada entidad en el espacio de dibujo.
6. **Tabla resumen:** 21 relaciones con tipo (1:N / N:M directa / N:M resuelta) y notas.
7. **Guia draw.io:** 7 pasos con instrucciones concretas para la herramienta.

R-21 aparece marcada como "UNICA RELACION N:M DIRECTA DEL MODELO" con representacion visual:
`[CONDUCTOR] --N-- <POSEE_CATEGORIA> --M-- [CATEGORIA_PERMISO]`

### 3.10 Actualizaciones en docs/ de apoyo

**docs/decisiones_diseno.md:** se añaden cuatro nuevas decisiones documentadas:
- DD-002: Cardinalidad SERVICIO-MERCANCIA de 1:1 a 1:N
- DD-003: CATEGORIA_PERMISO como entidad catalogo con N:M
- DD-004: Nombres semanticos para todas las relaciones
- DD-005: ASIGNACION como entidad asociativa (rectangulo, no rombo)

**docs/glosario.md:** se añaden 10 nuevos terminos bajo la seccion "Nuevos terminos incorporados en la revision conceptual (2026-05-28)":
Categoria de permiso, CAP, Relacion N:M, Entidad asociativa, Entidad catalogo,
Entidad transversal, Participacion total, Participacion parcial, FTL, LTL.

---

## 4. Cambios conceptuales importantes

### 4.1 El modelo tiene exactamente una relacion N:M directa

Tras la revision, el modelo conceptual tiene la siguiente distribucion de tipos de relacion:

| Tipo | Cantidad | Relaciones |
|---|:---:|---|
| 1:N directas | 19 | R-01 a R-20 (excepto R-21) |
| N:M directa (rombo) | 1 | R-21 POSEE_CATEGORIA |
| N:M implicitas resueltas | 3 | Via ASIGNACION (conductor, vehiculo, remolque) |

### 4.2 ASIGNACION es entidad asociativa, no rombo N:M

ASIGNACION resuelve tres N:M implicitas simultaneamente. Tiene atributos propios
(fecha_asignacion, es_activa, motivo_cambio) y ciclo de vida independiente (puede haber
varias asignaciones historicas para el mismo servicio). Por esto se representa como
rectangulo (entidad asociativa), no como rombo. En FASE 3 se crea como tabla propia con
PK artificial y tres FK.

### 4.3 CATEGORIA_PERMISO es entidad catalogo, no rombo aislado

R-21 se representa con rombo porque la relacion N:M POSEE_CATEGORIA no tiene atributos
propios en el modelo conceptual. CATEGORIA_PERMISO es una entidad catalogo: sus registros
son estables (los tipos de permiso homologados por la UE) y son reutilizables entre
conductores. En FASE 3 la relacion N:M se transforma en tabla intermedia.

### 4.4 REGISTRO_AUDITORIA es entidad transversal sin FK directas

REGISTRO_AUDITORIA no tiene FK directas. Las referencias a otras entidades se gestionan
mediante texto (entidad_afectada) e identificador numerico (id_registro_afectado). En el
diagrama se coloca separada con nota aclaratoria.

---

## 5. Entidades del modelo -- Estado final

| # | Entidad | Naturaleza | Estado tras revision |
|:---:|---|---|---|
| 1 | CLIENTE | Regular | Sin cambios |
| 2 | CONTACTO | Regular | Sin cambios |
| 3 | DIRECCION_OPERATIVA | Regular | Sin cambios |
| 4 | SERVICIO | Central | Sin cambios |
| 5 | PUNTO_SERVICIO | Regular | Sin cambios |
| 6 | EVENTO_SEGUIMIENTO | Regular | Sin cambios |
| 7 | MERCANCIA | Regular | Descripcion actualizada para LTL |
| 8 | REQUISITO_ESPECIAL | Regular | Descripcion corregida (vinculo con SERVICIO, no MERCANCIA) |
| 9 | INCIDENCIA | Regular | Sin cambios |
| 10 | VEHICULO | Regular | Sin cambios |
| 11 | REMOLQUE | Regular | Sin cambios |
| 12 | CONDUCTOR | Regular | Eliminado atributo categorias_permiso; añadida referencia a R-21 |
| 13 | ASIGNACION | Asociativa | Sin cambios estructurales; naturaleza documentada explicitamente |
| 14 | CATEGORIA_PERMISO | Catalogo | **NUEVA** -- anadida en esta revision |
| 15 | COSTE_OPERATIVO | Regular | Sin cambios |
| 16 | FACTURA | Regular | Sin cambios |
| 17 | DOCUMENTO_SERVICIO | Regular | Sin cambios |
| 18 | DOCUMENTO_RECURSO | Regular | Sin cambios |
| 19 | REGISTRO_AUDITORIA | Transversal | Sin cambios estructurales; naturaleza documentada explicitamente |

**Total: 19 entidades (18 preexistentes + 1 nueva: CATEGORIA_PERMISO).**

---

## 6. Relaciones del modelo -- Estado final

| Codigo | Nombre semantico | Entidades | Cardinalidad | Tipo | Cambio |
|:---:|---|---|:---:|---|---|
| R-01 | TIENE_CONTACTO | CLIENTE -- CONTACTO | 1:N | Regular | Sin cambio |
| R-02 | TIENE_DIRECCION | CLIENTE -- DIRECCION_OPERATIVA | 1:N | Regular | Sin cambio |
| R-03 | CONTRATA | CLIENTE -- SERVICIO | 1:N | Regular | Sin cambio |
| R-04 | EMITIDA_A | CLIENTE -- FACTURA | 1:N | Regular | Sin cambio |
| R-05 | AGRUPA_SERVICIOS | FACTURA -- SERVICIO | 1:N | Regular | Renombrada (era SE_FACTURA_EN) |
| R-06 | TIENE_PUNTO | SERVICIO -- PUNTO_SERVICIO | 1:N | Regular | Sin cambio |
| R-07 | REFERENCIA_DIRECCION | PUNTO_SERVICIO -- DIRECCION_OPERATIVA | N:1 | Regular | Sin cambio |
| R-08 | REGISTRA_EVENTO | SERVICIO -- EVENTO_SEGUIMIENTO | 1:N | Regular | Renombrada (era TIENE_EVENTO) |
| R-09 | CONTIENE_MERCANCIA | SERVICIO -- MERCANCIA | 1:N | Regular | Renombrada + cardinalidad 1:1→1:N |
| R-10 | REQUIERE_CONDICION | SERVICIO -- REQUISITO_ESPECIAL | 1:N | Regular | Renombrada (era TIENE_REQUISITO) |
| R-11 | GENERA_INCIDENCIA | SERVICIO -- INCIDENCIA | 1:N | Regular | Sin cambio |
| R-12 | GENERA_COSTE | SERVICIO -- COSTE_OPERATIVO | 1:N | Regular | Sin cambio |
| R-13 | TIENE_DOCUMENTO_SERVICIO | SERVICIO -- DOCUMENTO_SERVICIO | 1:N | Regular | Renombrada (era TIENE_DOCUMENTO) |
| R-14 | TIENE_ASIGNACION | SERVICIO -- ASIGNACION | 1:N | Regular | Sin cambio |
| R-15 | REALIZA | CONDUCTOR -- ASIGNACION | 1:N | Regular | Sin cambio |
| R-16 | UTILIZA_VEHICULO | VEHICULO -- ASIGNACION | 1:N | Regular | Sin cambio |
| R-17 | UTILIZA_REMOLQUE | REMOLQUE -- ASIGNACION | 1:N | Regular (opt) | Sin cambio |
| R-18 | DOCUMENTA_VEHICULO | VEHICULO -- DOCUMENTO_RECURSO | 1:N | Regular | Sin cambio |
| R-19 | DOCUMENTA_REMOLQUE | REMOLQUE -- DOCUMENTO_RECURSO | 1:N | Regular | Sin cambio |
| R-20 | DOCUMENTA_CONDUCTOR | CONDUCTOR -- DOCUMENTO_RECURSO | 1:N | Regular | Sin cambio |
| R-21 | POSEE_CATEGORIA | CONDUCTOR -- CATEGORIA_PERMISO | N:M | N:M directa (rombo) | **NUEVA** |

**Total: 21 relaciones (20 preexistentes + 1 nueva: R-21 POSEE_CATEGORIA).**

---

## 7. Impacto sobre FASE 3

### 7.1 Impacto del cambio R-09 (MERCANCIA 1:1 → 1:N)

| Documento FASE 3 | Cambio necesario |
|---|---|
| esquema_relacional.md | MERCANCIA: quitar restriccion UNIQUE en FK id_servicio; actualizar regla de transformacion de R4 (1:1) a R2 (1:N) |
| analisis_normalizacion.md | Parrafo de MERCANCIA: reflejar que puede haber N filas por id_servicio; la PK sigue siendo id_mercancia |
| diagrama_logico_textual.md | Notacion SERVICIO-MERCANCIA: corregir de 1:1 a 1:N |
| tablas_con_datos_ejemplo.md | Añadir al menos un servicio LTL con dos registros de MERCANCIA distintos |

### 7.2 Impacto de la nueva entidad CATEGORIA_PERMISO y R-21

| Documento FASE 3 | Cambio necesario |
|---|---|
| esquema_relacional.md | Crear tabla CATEGORIA_PERMISO (id_categoria PK, codigo_categoria UNIQUE NOT NULL, descripcion NOT NULL, activa NOT NULL) |
| esquema_relacional.md | Crear tabla CONDUCTOR_CATEGORIA_PERMISO (FK id_conductor + FK id_categoria; PK compuesta o PK artificial) |
| esquema_relacional.md | Eliminar columna categorias_permiso de la tabla CONDUCTOR si existe |
| analisis_normalizacion.md | Anadir analisis de CATEGORIA_PERMISO (trivialmente en 3FN) y CONDUCTOR_CATEGORIA_PERMISO |
| diagrama_logico_textual.md | Anadir CATEGORIA_PERMISO y CONDUCTOR_CATEGORIA_PERMISO al mapa de relaciones |
| tablas_con_datos_ejemplo.md | Anadir registros de CATEGORIA_PERMISO (C, CE, C1, etc.) y de CONDUCTOR_CATEGORIA_PERMISO |

### 7.3 Impacto de los nombres semanticos de relaciones

El cambio es solo de nombre; no afecta a la estructura de tablas. En los documentos de
FASE 3 se deben usar los nombres actualizados cuando se mencionen relaciones por nombre:
- AGRUPA_SERVICIOS (no SE_FACTURA_EN)
- REGISTRA_EVENTO (no TIENE_EVENTO)
- CONTIENE_MERCANCIA (no DESCRIBE_CARGA)
- REQUIERE_CONDICION (no TIENE_REQUISITO)
- TIENE_DOCUMENTO_SERVICIO (no TIENE_DOCUMENTO)

### 7.4 Estado actual de FASE 3

FASE 3 tiene contenido sustancial. Los documentos existentes son validos en su mayor parte;
los cambios listados en 7.1 y 7.2 son acotados y no invalidan el trabajo ya realizado.

---

## 8. Pendientes antes de dar FASE 3 por completada

| # | Tarea | Descripcion |
|:---:|---|---|
| P-01 | Dibujar diagrama E/R | Usar diagrama_er_textual.md. Exportar PNG a /diagramas/modelo_conceptual.png |
| P-02 | Actualizar MERCANCIA en esquema_relacional.md | Quitar UNIQUE en id_servicio; regla R2 en lugar de R4 |
| P-03 | Añadir CATEGORIA_PERMISO en esquema_relacional.md | Nueva tabla con 4 columnas |
| P-04 | Añadir CONDUCTOR_CATEGORIA_PERMISO en esquema_relacional.md | Tabla intermedia para R-21 |
| P-05 | Quitar categorias_permiso de CONDUCTOR en esquema_relacional.md | Si existe la columna |
| P-06 | Actualizar analisis_normalizacion.md | MERCANCIA (1:N) + nuevas tablas |
| P-07 | Actualizar diagrama_logico_textual.md | SERVICIO-MERCANCIA 1:N + CATEGORIA_PERMISO + CONDUCTOR_CATEGORIA_PERMISO |
| P-08 | Actualizar tablas_con_datos_ejemplo.md | Servicio LTL con 2 mercancias + datos de CATEGORIA_PERMISO |
| P-09 | Exportar diagrama logico | PNG a /diagramas/modelo_logico.png |
| P-10 | Verificacion de coherencia FASE 3 | Revisar todos los archivos de FASE 3 con el modelo E/R revisado como referencia |

---

## 9. Confirmacion de coherencia con RA1, RA2, propuesta oficial y criterios del modulo

### 9.1 Coherencia con la propuesta oficial del TFG

| Area de la propuesta | Entidades que la cubren | Estado |
|---|---|:---:|
| Clientes y terceros | CLIENTE, CONTACTO, DIRECCION_OPERATIVA | OK |
| Servicios/envios y seguimiento | SERVICIO, PUNTO_SERVICIO, EVENTO_SEGUIMIENTO | OK |
| Mercancia y requisitos especiales | MERCANCIA (1:N para LTL), REQUISITO_ESPECIAL | OK |
| Incidencias con trazabilidad | INCIDENCIA | OK |
| Vehiculos, remolques y conductores | VEHICULO, REMOLQUE, CONDUCTOR | OK |
| Habilitaciones de conduccion | CATEGORIA_PERMISO (nueva), R-21 POSEE_CATEGORIA | OK |
| Asignaciones operativas | ASIGNACION (entidad asociativa) | OK |
| Costes operativos e imputacion | COSTE_OPERATIVO | OK |
| Facturacion y seguimiento de cobros | FACTURA, R-05 AGRUPA_SERVICIOS | OK |
| Documentacion de servicios | DOCUMENTO_SERVICIO | OK |
| Documentacion con vigencias/caducidades | DOCUMENTO_RECURSO | OK |
| Auditoria interna / control interno | REGISTRO_AUDITORIA | OK |

### 9.2 Coherencia con RA1 (Descripcion del dominio y requerimientos)

FASE 1 cubre correctamente:
- Descripcion de la empresa y su actividad operativa en transporte intracomunitario.
- Ciclo de vida completo de un servicio de transporte.
- 30 requerimientos funcionales (RF-001 a RF-030) y 10 no funcionales (RNF-001 a RNF-010).
- 19 entidades candidatas organizadas por area funcional, incluyendo CATEGORIA_PERMISO.
- Relaciones narrativas actualizadas: MERCANCIA 1:N, POSEE_CATEGORIA N:M, AGRUPA_SERVICIOS.
- Sin SQL ni normalizacion (correcto para FASE 1).

### 9.3 Coherencia con RA2 (Modelo conceptual)

FASE 2 cubre correctamente:
- 19 entidades con atributos, tipos conceptuales, claves primarias y naturaleza clasificada.
- 21 relaciones con nombres semanticos, cardinalidades, participacion total/parcial.
- Una relacion N:M directa (R-21, rombo) y una entidad asociativa (ASIGNACION, rectangulo).
- Analisis formal de relaciones N:M con clasificacion en tres tipos.
- Justificacion tecnica de cada decision de diseno registrada en decisiones_diseno.md.
- Guia completa de dibujo del diagrama E/R en diagrama_er_textual.md.
- Sin SQL ni tipos de dato fisicos (correcto para FASE 2).
- Sin normalizacion (correcto para FASE 2).

### 9.4 No hay contradicciones entre documentos tras la revision

| Elemento | Coherente en FASE 1 | Coherente en FASE 2 | Coherente en FASE 3 (parcial) |
|---|:---:|:---:|:---:|
| MERCANCIA 1:N (LTL) | OK | OK | Pendiente actualizacion |
| CATEGORIA_PERMISO como entidad | OK | OK | Pendiente creacion |
| R-21 POSEE_CATEGORIA N:M | OK | OK | Pendiente tabla intermedia |
| REQUISITO_ESPECIAL vinculado a SERVICIO | OK | OK | OK |
| Ano de curso 2024-26 | OK | OK | OK |
| Badges de estado correctos | OK | OK | OK |
| ASIGNACION como entidad asociativa | OK | OK | OK |
| REGISTRO_AUDITORIA como transversal | OK | OK | OK |
| Nombres semanticos de relaciones | OK | OK | Pendiente actualizacion referencias |

### 9.5 Cumplimiento de 1FN en el modelo conceptual

El modelo conceptual no contiene atributos multivaluados tras la revision:
- `categorias_permiso` (multivaluado, violaba 1FN) eliminado de CONDUCTOR.
- Sustituido por la entidad catalogo CATEGORIA_PERMISO y la relacion N:M R-21.
- El resto del modelo no tiene atributos multivaluados ni grupos repetidos.

---

## 10. Segunda pasada de revision correctiva -- FASE 3 (2026-05-28)

**Alcance:** Correccion de las inconsistencias de FASE 3 respecto al modelo conceptual cerrado de FASE 2.

### 10.1 Problemas detectados en FASE 3 antes de la correccion

| Archivo | Problema | Gravedad |
|---|---|---|
| esquema_relacional.md | Afirmaba "No existen relaciones N:M directas" contradiciendo R-21 | Critica |
| esquema_relacional.md | MERCANCIA.id_servicio tenia restriccion UNIQUE (relacion 1:1) pero FASE 2 dice 1:N | Critica |
| esquema_relacional.md | CONDUCTOR tenia columna `categorias_permiso TEXTO(20) NN` eliminada en FASE 2 | Critica |
| esquema_relacional.md | Faltaban tablas CATEGORIA_PERMISO y CONDUCTOR_CATEGORIA_PERMISO | Critica |
| diagrama_logico_textual.md | 5 nombres de relacion desactualizados: SE_FACTURA_EN, TIENE_EVENTO, DESCRIBE_CARGA, TIENE_REQUISITO, TIENE_DOCUMENTO | Alta |
| diagrama_logico_textual.md | MERCANCIA con UQ en id_servicio (relacion 1:1) | Critica |
| diagrama_logico_textual.md | CONDUCTOR con `categorias_permiso` | Critica |
| diagrama_logico_textual.md | Faltaban tablas y relacion R-21 en el mapa | Alta |
| diagrama_logico_textual.md | Cardinalidad SERVICIO-MERCANCIA marcada como 1:1 | Critica |
| analisis_normalizacion.md | Seccion 2.2 argumentaba activamente CONTRA crear CATEGORIA_PERMISO N:M, contradiciendo FASE 2 | Critica |
| tablas_con_datos_ejemplo.md | CONDUCTOR con columna `categorias_permiso` | Alta |
| tablas_con_datos_ejemplo.md | Faltaban tablas de ejemplo para CATEGORIA_PERMISO y CONDUCTOR_CATEGORIA_PERMISO | Alta |
| tablas_con_datos_ejemplo.md | Nota de MERCANCIA decia "relacion 1:1" | Alta |

### 10.2 Correcciones aplicadas en esta pasada

**esquema_relacional.md:**
- Parrafo de N:M corregido: ahora indica que R-21 existe y se transforma en CONDUCTOR_CATEGORIA_PERMISO.
- MERCANCIA: eliminada restriccion UQ en id_servicio; justificacion cambiada de 1:1 a 1:N.
- CONDUCTOR: eliminada columna `categorias_permiso`; nota actualizada sobre el N:M.
- Tabla CATEGORIA_PERMISO añadida con atributos, PK y justificacion.
- Tabla CONDUCTOR_CATEGORIA_PERMISO añadida con PK compuesta, dos FK y nota sobre 2FN.
- Tabla resumen: actualizada de 18 a 20 tablas.
- Orden de creacion: actualizado de 18 a 20 pasos; CATEGORIA_PERMISO y CONDUCTOR_CATEGORIA_PERMISO insertadas en posiciones 5 y 6.

**diagrama_logico_textual.md:**
- MERCANCIA: eliminado UQ en id_servicio.
- CONDUCTOR: eliminada linea `categorias_permiso TEXTO(20) NN`.
- Anadidas tablas CATEGORIA_PERMISO y CONDUCTOR_CATEGORIA_PERMISO en el bloque de codigo.
- Mapa de relaciones: 5 nombres corregidos (R-05, R-08, R-09, R-10, R-13).
- Mapa de relaciones: anadida R-21 POSEE_CATEGORIA con sus dos FK.
- Tabla de cardinalidades: SERVICIO-MERCANCIA corregida de 1:1 a 1:N.
- Tabla de cardinalidades: anadida CONDUCTOR-CATEGORIA_PERMISO N:M.
- Instruccion draw.io: corregida referencia a R-09 de 1:1 a 1:N.
- Mapa visual draw.io: anadidas CATEGORIA_PERMISO y CONDUCTOR_CATEGORIA_PERMISO.

**analisis_normalizacion.md:**
- Seccion 2.2 reescrita completamente: ya no argumenta mantener `categorias_permiso`, sino que documenta su eliminacion y explica el N:M correctamente.
- Tabla 1FN: CONDUCTOR actualizado, anadidas CATEGORIA_PERMISO y CONDUCTOR_CATEGORIA_PERMISO.
- Tabla 2FN: anadida excepcion para CONDUCTOR_CATEGORIA_PERMISO (PK compuesta).
- Nueva seccion 3.3: analisis de 2FN especifico para CONDUCTOR_CATEGORIA_PERMISO.

**tablas_con_datos_ejemplo.md:**
- CONDUCTOR: eliminada columna `categorias_permiso` de cabecera y filas de datos.
- Anadida nota explicativa sobre categorias despues de la tabla CONDUCTOR.
- Anadida tabla de ejemplo CATEGORIA_PERMISO con 5 categorias (C, CE, C1, C1E, D).
- Anadida tabla de ejemplo CONDUCTOR_CATEGORIA_PERMISO con 4 registros (2 conductores x 2 categorias).
- Nota de MERCANCIA corregida de "relacion 1:1" a "relacion 1:N".

### 10.3 Estado de coherencia tras la segunda pasada

| Elemento | FASE 1 | FASE 2 | FASE 3 |
|---|:---:|:---:|:---:|
| MERCANCIA como relacion 1:N | OK | OK | OK (corregido) |
| CATEGORIA_PERMISO como entidad | OK | OK | OK (anadida) |
| CONDUCTOR sin `categorias_permiso` | OK | OK | OK (eliminado) |
| R-21 POSEE_CATEGORIA N:M | OK | OK | OK (tabla intermedia creada) |
| Nombres semanticos de relaciones | OK | OK | OK (corregidos) |
| Cardinalidad SERVICIO-MERCANCIA 1:N | OK | OK | OK (corregida) |

### 10.4 Pendientes antes de retomar FASE 3 como trabajo activo

| # | Tarea | Archivo afectado |
|:---:|---|---|
| P-01 | Dibujar el diagrama E/R conceptual en draw.io | diagrama_er_textual.md como guia |
| P-02 | Dibujar el diagrama logico en draw.io | diagrama_logico_textual.md como guia |
| P-03 | Exportar PNG modelo conceptual | /diagramas/modelo_conceptual.png |
| P-04 | Exportar PNG modelo logico | /diagramas/modelo_logico.png |
| P-05 | Anadir servicio LTL con 2 mercancias distintas en datos de ejemplo | tablas_con_datos_ejemplo.md |
| P-06 | Completar analisis 3FN para CATEGORIA_PERMISO y CONDUCTOR_CATEGORIA_PERMISO | analisis_normalizacion.md |
| P-07 | Verificar README de FASE 3 y actualizar checklist | 03_FASE_3.../README.md |

**FASE 3 NO esta cerrada.** Los documentos de esquema, normalizacion y datos de ejemplo estan corregidos y coherentes con FASE 2, pero faltan los diagramas y la verificacion final.

---

## 11. Tercera pasada -- Revision correctiva FASE 1 y FASE 2 (2026-05-29)

**Alcance:** Revision correctiva exclusiva de FASE 1 y FASE 2. FASE 3 no se toca.
**Prioridad de fuente:** Propuesta oficial > RA2 listado fases > RA1 > documentos del repositorio.

### 11.1 Documentos consultados en /anexos/

Se leyeron los cuatro PDFs oficiales antes de tomar ninguna decision:

| Archivo | Contenido clave extraido |
|---|---|
| Propuesta TFG Cesar Mendez.pdf | 8 areas de contenido; cliente+contactos+direcciones, servicios+seguimiento, mercancias+requisitos, incidencias, recursos, costes, facturacion+cobros, documentacion+auditoria |
| RA1 TFG DAM CesarMendez.pdf | Necesidades del sector; gestion de pedidos, clientes, camiones, remolques, conductores, costes, incidencias, facturacion |
| RA2 TFG DAM CesarMendez.pdf | Lista explicita de entidades: clientes, contactos, direcciones, servicios, puntos recogida/entrega, mercancias, requisitos, vehiculos, remolques, conductores, asignaciones, incidencias, costes, facturas, cobros, documentacion servicio, documentacion recurso, registros control |
| RA2 TFG DAM Listado Fase1 y 2.pdf | Tareas concretas de FASE 1 (6 tareas) y FASE 2 (6 tareas); FASE 2 tarea 4: "una factura puede agrupar varios servicios"; FASE 2 tarea 6: "una asignacion debe relacionar un servicio con un conductor, un camion, y si corresponde un remolque" |

### 11.2 Revision de FASE 1

**Conclusion:** FASE 1 esta correcta. No se aplico ningun cambio.

Documentos revisados: descripcion_dominio.md, requerimientos_cliente.md, entidades_candidatas.md, casos_de_uso.md, README.md.

- Las 8 areas de la propuesta estan cubiertas completamente.
- Los 30 RF y 10 RNF estan alineados con los requisitos del modulo.
- Las 19 entidades candidatas incluyen correctamente CATEGORIA_PERMISO.
- Las relaciones narrativas de la seccion 11 (LTL, N:M, AGRUPA_SERVICIOS) son correctas.
- No hay SQL ni normalizacion en FASE 1 (correcto).
- Badge: Completada (correcto).

### 11.3 Revision de FASE 2 -- Analisis de relaciones N:M

Se evaluaron cinco opciones de relaciones que podrian ser N:M directas adicionales a R-21:

| Opcion | Relacion | Decision | Justificacion |
|---|---|---|---|
| A | SERVICIO -- REQUISITO_ESPECIAL | **Mantener 1:N** | Los requisitos son instancias especificas del servicio, no catalogo reutilizable. No esta en propuesta como entidad de catalogo. |
| B | SERVICIO -- TIPO_DOCUMENTO_SERVICIO | **No anadir** | La propuesta no define TIPO_DOCUMENTO como entidad independiente; no hay soporte en RA1/RA2. |
| C | VEHICULO/REMOLQUE/CONDUCTOR -- TIPO_DOCUMENTO_RECURSO | **No anadir** | Mismo razonamiento que B; anadir un catalogo de tipos de documento no tiene respaldo explicito en la propuesta. |
| D | SERVICIO -- MERCANCIA | **Mantener 1:N** | R-09 ya es 1:N correctamente. No hay motivo para hacerla N:M; los lotes son especificos del servicio. |
| E | FACTURA -- SERVICIO | **Mantener 1:N** | R-05 AGRUPA_SERVICIOS ya es 1:N correctamente. La propuesta dice "una factura puede agrupar varios servicios", no que un servicio aparezca en varias facturas. |

**Conclusion:** R-21 POSEE_CATEGORIA sigue siendo la unica N:M directa del modelo. No se anade ninguna nueva N:M.

### 11.4 Revision de naturalezas de entidades

| Naturaleza | Entidades | Veredicto |
|---|---|:---:|
| Central | SERVICIO | Correcto |
| Regulares (15) | CLIENTE, CONTACTO, DIRECCION_OPERATIVA, PUNTO_SERVICIO, EVENTO_SEGUIMIENTO, MERCANCIA, REQUISITO_ESPECIAL, INCIDENCIA, VEHICULO, REMOLQUE, CONDUCTOR, COSTE_OPERATIVO, FACTURA, DOCUMENTO_SERVICIO, DOCUMENTO_RECURSO | Correcto |
| Asociativa | ASIGNACION | Correcto (tiene atributos propios y ciclo de vida independiente) |
| Catalogo | CATEGORIA_PERMISO | Correcto (valores estables y reutilizables entre conductores) |
| Transversal | REGISTRO_AUDITORIA | Correcto (sin FK directas; referencias por texto) |

**Conclusion:** Las naturalezas del modelo son correctas. No se aplica ningun cambio.

### 11.5 Correcciones aplicadas en FASE 2

| Archivo | Cambio | Tipo |
|---|---|---|
| justificacion_modelo.md | "18 entidades" → "19 entidades" en dos lugares (seccion 1 y seccion 2) | Correccion de dato |
| FASE 2 README (checklist N:M) | Linea N:M expandida para distinguir explicitamente: (a) R-21 POSEE_CATEGORIA como unica N:M directa con rombo; (b) ASIGNACION como entidad asociativa para N:M implicitas | Precision |
| diagrama_er_textual.md (seccion 5) | Reescritura completa de "Distribucion recomendada del lienzo" como mapa de 8 subsecciones con bloques funcionales A-E, mapas ASCII por bloque, R-21 visualmente destacada, mapa global de referencia (5.8) | Mejora mayor |
| diagrama_entidad_relacion.md (seccion 3) | DOCUMENTO_RECURSO mostrado tres veces → una sola caja con tres flechas convergentes y nota aclaratoria | Correccion de error |
| diagrama_entidad_relacion.md (paso 4) | "R-01 a R-20" → "R-01 a R-21" | Correccion de dato |
| diagrama_entidad_relacion.md (paso 2) | "DOCUMENTO_RECURSO (x3 instancias)" → "DOCUMENTO_RECURSO (una sola entidad, tres conexiones)" | Correccion de error |

### 11.6 Estado de FASE 1 y FASE 2 tras esta pasada

| Elemento | Estado |
|---|:---:|
| 19 entidades documentadas con atributos, PK y naturaleza | Completo |
| 21 relaciones con nombres semanticos, cardinalidad y participacion | Completo |
| R-21 POSEE_CATEGORIA como unica N:M directa | Correcto |
| ASIGNACION como entidad asociativa (no rombo) | Correcto |
| justificacion_modelo.md con recuento de 19 entidades | Correcto |
| Guia de dibujo con mapa por bloques (5 bloques + transversal) | Completo |
| DOCUMENTO_RECURSO como entidad unica con tres conexiones | Correcto |
| Coherencia con propuesta oficial + RA1 + RA2 + listado de fases | Verificada |
| Sin SQL ni tipos de dato fisicos en FASE 1 ni FASE 2 | Correcto |

**FASE 1 y FASE 2 estan cerradas y coherentes.**
