# Revision Global -- Fases 1, 2 y 3

**Proyecto:** Diseno, creacion y explotacion de una base de datos para la gestion integral
de una empresa de transporte intracomunitario por carretera (UE) en MySQL (phpMyAdmin)
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora - Curso 2024-26
**Fecha de revision:** 2026-05-28
**Alcance:** Revision completa y correctiva de FASE 1, FASE 2 y estado de FASE 3

---

## 1. Objetivo de la revision

Revisar la coherencia, completitud y calidad profesional de FASE 1 y FASE 2 antes de
continuar con FASE 3. Verificar que el modelo conceptual es correcto, que los documentos
no se contradicen entre fases, que los badges de estado son correctos, y que el modelo
incluye el analisis de relaciones N:M que exige un diseno conceptual completo.

---

## 2. Documentos revisados

| Documento | Ubicacion | Tipo de revision |
|---|---|---|
| README.md (raiz) | / | Badge de fase actual |
| FASE 1 README | 01_FASE_1.../README.md | Badge de estado |
| descripcion_dominio.md | 01_FASE_1.../entregables/ | Cabecera de año |
| requerimientos_cliente.md | 01_FASE_1.../entregables/ | Cabecera de año |
| entidades_candidatas.md | 01_FASE_1.../entregables/ | Año + contenido conceptual |
| casos_de_uso.md | 01_FASE_1.../entregables/ | Cabecera de año |
| FASE 2 README | 02_FASE_2.../README.md | Badge + checklist |
| diccionario_entidades.md | 02_FASE_2.../entregables/ | Año + descripcion MERCANCIA |
| diccionario_relaciones.md | 02_FASE_2.../entregables/ | Año + R-09 + seccion N:M |
| justificacion_modelo.md | 02_FASE_2.../entregables/ | Año + seccion 3.3 + seccion 5 N:M |
| diagrama_entidad_relacion.md | 02_FASE_2.../entregables/ | Año + notacion R-09 |
| FASE 3 README | 03_FASE_3.../README.md | Badge + checklist |

---

## 3. Cambios aplicados

### 3.1 Correcciones de estado y año

| Archivo | Cambio |
|---|---|
| README.md raiz | Badge "Fase Actual" corregido: FASE 1 → FASE 3 |
| FASE 1 README | Badge corregido: Pendiente → Completada |
| FASE 2 README | Badge corregido: Pendiente → Completada |
| FASE 3 README | Badge corregido: Pendiente → En progreso |
| Todos los entregables FASE 1 | Año de cabecera corregido: Curso 2023-24 → Curso 2024-26 |
| Todos los entregables FASE 2 | Año de cabecera corregido: Curso 2023-24 → Curso 2024-26 |

### 3.2 Cambio conceptual principal: R-09 MERCANCIA de 1:1 a 1:N

El cambio mas importante de esta revision es la cardinalidad de la relacion entre
SERVICIO y MERCANCIA:

- **Antes:** R-09 DESCRIBE_CARGA | SERVICIO (1) -- MERCANCIA (1) | 1:1
- **Despues:** R-09 CONTIENE_MERCANCIA | SERVICIO (1) -- MERCANCIA (N) | 1:N

**Justificacion:** La relacion 1:1 impedia representar servicios LTL (Less than Truck Load)
donde el mismo vehiculo transporta mercancias de tipos distintos pertenecientes a
expedidores diferentes. Cada lote tiene descripcion, peso, volumen y valor declarado propios.
La relacion sigue siendo 1:N (no N:M) porque cada lote de mercancia es especifico del
servicio en que se transporta: no existe un catalogo de mercancia reutilizable entre servicios.

Impacto en FASE 3: la tabla MERCANCIA pierde la restriccion UNIQUE sobre id_servicio
(un servicio puede tener varios registros MERCANCIA). El resto del esquema no cambia.

### 3.3 Nombre de relacion actualizado

La relacion R-09 se renombra de DESCRIBE_CARGA a CONTIENE_MERCANCIA para reflejar
mejor la naturaleza 1:N: un servicio "contiene" uno o varios lotes de mercancia.

### 3.4 Analisis formal de relaciones N:M

Se añade seccion dedicada al analisis de N:M en diccionario_relaciones.md y en
justificacion_modelo.md. Esta seccion documenta:
- Las tres relaciones N:M implicitas del dominio (conductor-servicio, vehiculo-servicio,
  remolque-servicio) y como ASIGNACION las resuelve como entidad asociativa.
- Las relaciones que podrian ser N:M pero se modelan como 1:N con justificacion tecnica.
- El resumen de tipos de relacion presentes en el modelo final.

### 3.5 FASE 2 README checklist actualizado

El item "No hay relaciones N:M sin analizar" se actualiza para reflejar que el analisis
de N:M se ha realizado y documentado formalmente (no simplemente afirmar que no las hay).

### 3.6 FASE 3 README checklist corregido

Dos items pasan de [x] a [ ]:
- Exportacion del diagrama logico (pendiente)
- Verificacion de coherencia con FASE 2 revisada (pendiente por el cambio R-09)

### 3.7 Archivo nuevo: diagrama_er_textual.md

Se crea el archivo `02_FASE_2.../entregables/diagrama_er_textual.md` con:
- Representacion textual de todas las entidades con atributos principales
- Todas las relaciones con nombres semanticos, cardinalidades y participacion
- Instrucciones claras sobre que dibujar como rectangulo vs rombo vs entidad asociativa
- Tratamiento especial de ASIGNACION (entidad asociativa) y REGISTRO_AUDITORIA (transversal)
- Mapa global y guia paso a paso para draw.io

### 3.8 Correcciones en entidades_candidatas.md (FASE 1)

- MERCANCIA: descripcion actualizada para reflejar la posibilidad de multiples lotes LTL
- REQUISITO_ESPECIAL: eliminada referencia erronea a vinculacion con MERCANCIA (el vinculo
  correcto es directamente con SERVICIO)
- Relaciones narrativas: actualizada la linea de MERCANCIA y REQUISITO_ESPECIAL

---

## 4. Cambios conceptuales importantes

### 4.1 El modelo no tiene relaciones 1:1

Tras el cambio de R-09 a 1:N, el modelo conceptual final no contiene ninguna relacion 1:1.
Todos los tipos de relacion presentes son:
- **1:N directas**: 17 relaciones (R-01 a R-20 excepto las resueltas por ASIGNACION)
- **N:M resueltas**: conductor-servicio, vehiculo-servicio, remolque-servicio (via ASIGNACION)

### 4.2 ASIGNACION es la N:M central del modelo

La entidad asociativa ASIGNACION es el nucleo de la gestion operativa. Resuelve tres
relaciones N:M simultaneamente y ademas mantiene historial de cambios de recursos.
En el diagrama E/R debe representarse como rectangulo (no como rombo) con sus atributos.

### 4.3 REGISTRO_AUDITORIA como entidad transversal

REGISTRO_AUDITORIA no tiene FK directas a otras entidades del sistema. Las referencias
se gestionan mediante texto (entidad_afectada) e identificador numerico. En el diagrama
debe colocarse separado, con nota explicativa de su naturaleza transversal.

---

## 5. Entidades mantenidas y motivo

| # | Entidad | Razon de mantener |
|:---:|---|---|
| 1 | CLIENTE | Entidad nuclear. Actor externo principal. |
| 2 | CONTACTO | Multiples interlocutores por cliente. Evita grupos repetidos. |
| 3 | DIRECCION_OPERATIVA | Reutilizacion de ubicaciones habituales del cliente. |
| 4 | SERVICIO | Entidad central del modelo. Todo el sistema orbita en torno a ella. |
| 5 | PUNTO_SERVICIO | Servicios multipunto habituales en LTL. Ventanas horarias independientes. |
| 6 | EVENTO_SEGUIMIENTO | Historial completo de trazabilidad exigido por la propuesta. |
| 7 | MERCANCIA | Separada de SERVICIO para no sobrecargar la entidad central. Ahora 1:N. |
| 8 | REQUISITO_ESPECIAL | Varios requisitos de tipos distintos por servicio. Propuesta lo exige. |
| 9 | INCIDENCIA | Ciclo de vida propio con trazabilidad. Propuesta lo exige explicitamente. |
| 10 | VEHICULO | Recurso operativo con documentacion y disponibilidad propia. |
| 11 | REMOLQUE | Independiente del tractor; combinacion variable por servicio. |
| 12 | CONDUCTOR | Recurso con documentacion habilitante y disponibilidad gestionable. |
| 13 | ASIGNACION | Entidad asociativa. Resuelve N:M recursos-servicio. Atributos propios. |
| 14 | COSTE_OPERATIVO | Multiples tipos de coste por servicio. Calculo de rentabilidad. |
| 15 | FACTURA | Ciclo de vida economico independiente del ciclo operativo. |
| 16 | DOCUMENTO_SERVICIO | Multiples documentos por servicio (CMR, albaranes, evidencias). |
| 17 | DOCUMENTO_RECURSO | Vigencias y caducidades de vehiculos, remolques y conductores. |
| 18 | REGISTRO_AUDITORIA | Control interno exigido por la propuesta. Entidad transversal. |

**Total: 18 entidades. Ninguna eliminada ni reducida a atributo.**

---

## 6. Entidades transformadas

No se ha transformado ninguna entidad en atributo ni en relacion simple.
No se ha añadido ninguna entidad nueva.

La unica transformacion es la cardinalidad de la relacion R-09: MERCANCIA pasa de
relacionarse con SERVICIO en modo 1:1 a modo 1:N. La entidad MERCANCIA se mantiene
integra; lo que cambia es cuantos registros puede tener por servicio.

---

## 7. Relaciones renombradas o actualizadas

| Codigo | Nombre anterior | Nombre nuevo | Cardinalidad anterior | Cardinalidad nueva |
|:---:|---|---|:---:|:---:|
| R-09 | DESCRIBE_CARGA | CONTIENE_MERCANCIA | 1:1 | 1:N |

El resto de relaciones (R-01 a R-08, R-10 a R-20) mantienen su nombre y cardinalidad.

---

## 8. Impacto sobre FASE 3

### 8.1 Cambios necesarios en esquema_relacional.md

La tabla MERCANCIA debe revisarse:
- La FK `id_servicio` ya no debe tener restriccion UNIQUE (antes la 1:1 la implicaba).
- El comentario de la regla de transformacion debe actualizarse de R4 (1:1) a R2 (1:N).
- La descripcion de la tabla debe reflejar que puede haber multiples registros por servicio.

### 8.2 Cambios necesarios en analisis_normalizacion.md

El analisis de MERCANCIA debe actualizarse:
- La tabla deja de tener PK simple unica por servicio (puede haber N filas por servicio).
- El analisis de 2FN y 3FN no se ve afectado (la PK sigue siendo id_mercancia).
- Actualizar el parrafo introductorio de MERCANCIA para reflejar la relacion 1:N.

### 8.3 Cambios necesarios en diagrama_logico_textual.md

Actualizar la notacion de la relacion SERVICIO-MERCANCIA de 1:1 a 1:N en el mapa
de relaciones del modelo logico.

### 8.4 Cambios necesarios en tablas_con_datos_ejemplo.md

Los datos de ejemplo de MERCANCIA deben mostrar al menos un servicio con dos lotes
de mercancia distintos para ilustrar la cardinalidad 1:N.

### 8.5 Estado actual de FASE 3

FASE 3 tiene contenido sustancial generado (esquema_relacional.md, analisis_normalizacion.md,
diagrama_logico_textual.md, tablas_con_datos_ejemplo.md). Todos esos documentos son
validos en su mayor parte; solo las referencias a MERCANCIA necesitan ser revisadas
y actualizadas antes de dar FASE 3 por completada.

---

## 9. Pendientes antes de retomar FASE 3

| # | Tarea | Descripcion |
|:---:|---|---|
| P-01 | Dibujar diagrama E/R | Utilizar diagrama_er_textual.md como guia. Exportar PNG a /diagramas/modelo_conceptual.png |
| P-02 | Actualizar esquema_relacional.md | Revisar MERCANCIA: quitar UNIQUE en FK id_servicio; actualizar regla de transformacion de R4 a R2 |
| P-03 | Actualizar analisis_normalizacion.md | Revisar parrafo de MERCANCIA para reflejar 1:N |
| P-04 | Actualizar diagrama_logico_textual.md | Corregir notacion de SERVICIO-MERCANCIA de 1:1 a 1:N |
| P-05 | Actualizar tablas_con_datos_ejemplo.md | Añadir ejemplo de servicio LTL con dos lotes de mercancia |
| P-06 | Exportar diagrama logico | Una vez actualizados los documentos, exportar diagrama logico a /diagramas/modelo_logico.png |
| P-07 | Verificar coherencia completa FASE 3 | Revisar todos los archivos de FASE 3 con el modelo E/R corregido como referencia |

---

## 10. Confirmacion de coherencia con RA1, RA2, propuesta oficial y requisitos de la profesora

### Coherencia con la propuesta oficial del TFG

| Area de la propuesta | Entidades que la cubren | Estado |
|---|---|:---:|
| Clientes y terceros | CLIENTE, CONTACTO, DIRECCION_OPERATIVA | OK |
| Servicios/envios y seguimiento | SERVICIO, PUNTO_SERVICIO, EVENTO_SEGUIMIENTO | OK |
| Mercancia y requisitos especiales | MERCANCIA (1:N), REQUISITO_ESPECIAL | OK |
| Incidencias con trazabilidad | INCIDENCIA | OK |
| Vehiculos, remolques y conductores | VEHICULO, REMOLQUE, CONDUCTOR | OK |
| Asignaciones operativas | ASIGNACION (entidad asociativa) | OK |
| Costes operativos e imputacion | COSTE_OPERATIVO | OK |
| Facturacion y seguimiento de cobros | FACTURA | OK |
| Documentacion de servicios | DOCUMENTO_SERVICIO | OK |
| Documentacion con vigencias/caducidades | DOCUMENTO_RECURSO | OK |
| Auditoria interna / control interno | REGISTRO_AUDITORIA | OK |

### Coherencia con RA1 (Descripcion del dominio y requerimientos)

FASE 1 cubre correctamente:
- Descripcion de la empresa y su actividad operativa
- Ciclo de vida completo de un servicio
- 30 requerimientos funcionales (RF-001 a RF-030) y 10 no funcionales (RNF-001 a RNF-010)
- Identificacion narrativa de las 18 entidades candidatas organizadas por area funcional
- Relaciones narrativas principales con la actualizacion MERCANCIA corregida

### Coherencia con RA2 (Modelo conceptual)

FASE 2 cubre correctamente:
- 18 entidades con atributos, tipos conceptuales y claves primarias
- 20 relaciones con nombres semanticos, cardinalidades y participacion total/parcial
- Analisis de relaciones N:M (resueltas mediante ASIGNACION como entidad asociativa)
- Justificacion tecnica de cada decision de diseno
- Representacion textual del diagrama E/R lista para dibujar en draw.io
- Sin SQL ni tipos de dato fisicos (correcto para fase conceptual)
- Sin normalizacion (correcto para fase conceptual)

### No hay contradicciones entre documentos

Tras esta revision, los siguientes elementos son coherentes entre FASE 1, FASE 2 y FASE 3:
- La entidad MERCANCIA tiene relacion 1:N con SERVICIO en todos los documentos de FASE 1 y 2
- REQUISITO_ESPECIAL se vincula directamente a SERVICIO en todos los documentos (no a MERCANCIA)
- Los años del curso son "2024-26" en todos los documentos
- Los badges de estado reflejan el progreso real: FASE 1 Completada, FASE 2 Completada, FASE 3 En progreso
- La entidad ASIGNACION se documenta como entidad asociativa que resuelve N:M en todos los documentos
