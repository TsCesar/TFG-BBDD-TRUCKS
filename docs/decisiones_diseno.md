# Decisiones de Diseno

> Registro vivo de las decisiones importantes tomadas a lo largo del proyecto.
> Si alguien lee este documento, deberia entender **por que** el diseno es como es.

---

## Como se usa este documento

Cada vez que se toma una decision relevante en cualquier fase, se registra aqui.

| Campo | Descripcion |
|---|---|
| **ID** | Identificador unico: DD-001, DD-002... |
| **Fase** | En que fase se tomo la decision |
| **Decision** | Que se decidio |
| **Alternativas** | Otras opciones consideradas |
| **Justificacion** | Por que se eligio esta opcion |
| **Impacto** | Que partes del proyecto afecta |

---

## Registro de decisiones

### DD-001 - Eleccion del SGBD: MySQL + phpMyAdmin

| Campo | Detalle |
|---|---|
| **Fase** | Propuesta inicial |
| **Decision** | Usar MySQL 8.x con phpMyAdmin como entorno de trabajo |
| **Alternativas** | PostgreSQL (mas potente pero mas complejo), SQLite (demasiado simple para este dominio) |
| **Justificacion** | MySQL es la herramienta trabajada durante el modulo. Facilita la evaluacion y la defensa. phpMyAdmin proporciona capturas claras de la estructura y los resultados |
| **Impacto** | Todas las fases de implementacion (FASE 4, 5 y 6) |

---

---

### DD-002 - Cardinalidad SERVICIO-MERCANCIA: de 1:1 a 1:N

| Campo | Detalle |
|---|---|
| **Fase** | FASE 2 - Modelo Conceptual (revision 2026-05-28) |
| **Decision** | Cambiar la relacion SERVICIO-MERCANCIA de 1:1 a 1:N y renombrarla CONTIENE_MERCANCIA |
| **Alternativas** | Mantener 1:1 (un solo bloque de carga por servicio); modelar como N:M con catalogo de tipos de carga |
| **Justificacion** | En servicios LTL el vehiculo puede transportar mercancias de tipos distintos pertenecientes a diferentes expedidores. Cada lote tiene descripcion, peso y valor propios. La relacion 1:1 no permite representar este caso real del dominio. La N:M no es necesaria porque cada lote es especifico del servicio (no es catalogo reutilizable). |
| **Impacto** | FASE 2: diccionario_entidades, diccionario_relaciones, justificacion_modelo, diagrama. FASE 3: tabla MERCANCIA pierde restriccion UNIQUE sobre id_servicio; datos de ejemplo deben mostrar un servicio LTL con varios lotes. |

---

### DD-003 - CATEGORIA_PERMISO como entidad catalogo con N:M

| Campo | Detalle |
|---|---|
| **Fase** | FASE 2 - Modelo Conceptual (revision 2026-05-28) |
| **Decision** | Crear entidad CATEGORIA_PERMISO y relacion N:M POSEE_CATEGORIA con CONDUCTOR; eliminar atributo `categorias_permiso` de CONDUCTOR |
| **Alternativas** | Mantener `categorias_permiso` como campo de texto libre en CONDUCTOR; crear entidad asociativa con atributos como fecha de obtencion |
| **Justificacion** | El campo de texto viola la Primera Forma Normal (atributo multivaluado). Un conductor puede tener C, CE, C1 u otras categorias; una categoria (CE) es compartida por muchos conductores. La relacion N:M es innegable en el dominio. Como la relacion no tiene atributos propios en el modelo conceptual, se representa con rombo. En FASE 3 se transformara en tabla intermedia CONDUCTOR_CATEGORIA_PERMISO. |
| **Impacto** | FASE 2: nueva entidad CATEGORIA_PERMISO (19 entidades en total), nueva relacion R-21 POSEE_CATEGORIA N:M, eliminacion de categorias_permiso de CONDUCTOR. FASE 1: CATEGORIA_PERMISO anadida como entidad candidata. FASE 3: crear tabla CATEGORIA_PERMISO y tabla intermedia CONDUCTOR_CATEGORIA_PERMISO, actualizar analisis de normalizacion y datos de ejemplo. |

---

### DD-004 - Nombres semanticos para todas las relaciones

| Campo | Detalle |
|---|---|
| **Fase** | FASE 2 - Modelo Conceptual (revision 2026-05-28) |
| **Decision** | Asignar nombres semanticos a todas las relaciones; mantener codigos R-xx como referencia secundaria |
| **Alternativas** | Usar solo codigos R-xx (menos legible); usar solo nombres sin codigos (mas legible pero pierde referencia cruzada) |
| **Justificacion** | Los nombres semanticos hacen el modelo autoexplicativo y facilitan la defensa oral. Los codigos R-xx permiten referencias cruzadas entre documentos. Los cambios principales son: SE_FACTURA_EN -> AGRUPA_SERVICIOS, TIENE_EVENTO -> REGISTRA_EVENTO, TIENE_REQUISITO -> REQUIERE_CONDICION, TIENE_DOCUMENTO -> TIENE_DOCUMENTO_SERVICIO. |
| **Impacto** | FASE 2: todos los documentos del modelo conceptual. Sin impacto en FASE 3 (son cambios de nombre, no de estructura). |

---

### DD-005 - ASIGNACION como entidad asociativa (rectangulo, no rombo)

| Campo | Detalle |
|---|---|
| **Fase** | FASE 2 - Modelo Conceptual |
| **Decision** | Mantener ASIGNACION como entidad asociativa representada con rectangulo, no como relacion N:M directa con rombo |
| **Alternativas** | Modelar como relacion N:M directa con rombo (sin atributos); usar tres relaciones binarias separadas |
| **Justificacion** | ASIGNACION tiene atributos propios (fecha_asignacion, es_activa, motivo_cambio) y ciclo de vida independiente. Tambien puede existir historial de varias asignaciones para el mismo servicio (el flag es_activa distingue la vigente de las historicas). Por estas razones se modela como entidad asociativa (rectangulo) y no como simple rombo. |
| **Impacto** | Diagrama E/R: ASIGNACION se dibuja como rectangulo con doble borde, no como rombo. FASE 3: se crea tabla propia con PK artificial y FKs. |
