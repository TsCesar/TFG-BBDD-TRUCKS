# Planificacion para FASE 3 y FASE 4

**Proyecto:** Diseno, creacion y explotacion de una base de datos para la gestion integral
de una empresa de transporte intracomunitario por carretera (UE) en MySQL (phpMyAdmin)
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora - Curso 2024-26
**Fecha:** 2026-05-29
**Alcance:** Documento de planificacion. No contiene desarrollo tecnico.

---

## 1. Estado actual del proyecto

| Fase | Estado | Observaciones |
|:---:|---|---|
| FASE 1 | Completada | 4 entregables completos y coherentes con propuesta oficial, RA1, RA2 |
| FASE 2 | Completada | 19 entidades, 21 relaciones (1 N:M directa R-21), sin FK en modelo conceptual |
| FASE 3 | Pendiente | Borradores previos en entregables/ alineados con FASE 2. Pendientes: diagramas y verificacion final |
| FASE 4 | Pendiente | Sin contenido. Requiere FASE 3 completada y aprobada |
| FASE 5 | Pendiente | Sin contenido. Requiere FASE 4 completada |
| FASE 6 | Pendiente | Sin contenido. Requiere FASE 5 completada |

---

## 2. Confirmacion de cierre de FASE 1 y FASE 2

### FASE 1 -- Cerrada

Los cuatro entregables de FASE 1 estan completos y verificados:

| Entregable | Estado | Contenido |
|---|:---:|---|
| descripcion_dominio.md | Completo | Empresa, actividad, ciclo de vida del servicio, areas de informacion |
| requerimientos_cliente.md | Completo | 30 RF (RF-001 a RF-030) y 10 RNF (RNF-001 a RNF-010) |
| entidades_candidatas.md | Completo | 19 entidades candidatas con relaciones narrativas por area |
| casos_de_uso.md | Completo | Casos de uso por departamento |

Verificaciones superadas:
- Las 8 areas de la propuesta estan cubiertas completamente.
- Sin SQL, sin normalizacion, sin disenno fisico.
- CATEGORIA_PERMISO incluida como entidad candidata.
- Relaciones narrativas actualizadas: MERCANCIA 1:N, POSEE_CATEGORIA N:M, AGRUPA_SERVICIOS.

### FASE 2 -- Cerrada

Los entregables de FASE 2 estan completos y verificados:

| Entregable | Estado | Contenido |
|---|:---:|---|
| diccionario_entidades.md | Completo | 19 entidades con atributos, PK conceptual y naturaleza |
| diccionario_relaciones.md | Completo | 21 relaciones con nombres semanticos, cardinalidad y participacion |
| justificacion_modelo.md | Completo | Justificacion de todas las decisiones de disenno con correspondencia RF |
| diagrama_er_textual.md | Completo | Guia de 7 secciones para dibujar el diagrama en draw.io |
| diagrama_entidad_relacion.md | Completo | Representacion textual de todas las entidades y relaciones |

Verificaciones superadas:
- Sin FK como atributos en el modelo conceptual (FK son exclusivas de FASE 3).
- Sin SQL, sin normalizacion, sin tipos de dato MySQL.
- R-21 POSEE_CATEGORIA: unica N:M directa del modelo, representada con rombo.
- ASIGNACION: entidad asociativa con atributos propios (no rombo).
- CONDUCTOR: sin atributo categorias_permiso (eliminado, sustituido por R-21).
- REGISTRO_AUDITORIA: entidad transversal sin FK directas.
- Coherente con RA1, RA2, propuesta oficial y listado de fases.

Revision correctiva documentada en: docs/revision_global_fases_1_2_3.md

---

## 3. Entradas para FASE 3

Documentos de FASE 2 que sirven como entrada directa para el modelo logico:

| Documento | Uso en FASE 3 |
|---|---|
| diccionario_entidades.md | Fuente de cada tabla logica: atributos, tipos y restricciones |
| diccionario_relaciones.md | Define cada FK y la direccion de cada relacion 1:N |
| justificacion_modelo.md | Justifica las decisiones que impactan la normalizacion |
| diagrama_er_textual.md | Guia para adaptar el modelo conceptual al logico |
| docs/decisiones_diseno.md | DD-002 a DD-005 impactan directamente el esquema relacional |

**Aviso:** FASE 3 ya tiene borradores en entregables/ alineados con el modelo E/R cerrado
de FASE 2 tras la revision del 2026-05-28. Antes de iniciar trabajo nuevo, revisar
el estado de cada borrador usando el modelo de FASE 2 como referencia unica.

---

## 4. Tareas de FASE 3

Nota: los archivos esquema_relacional.md, analisis_normalizacion.md, diagrama_logico_textual.md
y tablas_con_datos_ejemplo.md existen como borradores corregidos. Cada tarea debe verificarse
contra el modelo E/R cerrado de FASE 2 antes de marcarla como completada.

| # | Tarea | Archivo afectado | Observacion |
|:---:|---|---|---|
| F3-01 | Verificar transformacion E/R a esquema relacional completa | esquema_relacional.md | Borrador existe |
| F3-02 | Confirmar que todas las relaciones 1:N se implementan como FK en el lado N | esquema_relacional.md | Borrador existe |
| F3-03 | Confirmar tabla intermedia CONDUCTOR_CATEGORIA_PERMISO para R-21 N:M | esquema_relacional.md | Borrador existe |
| F3-04 | Confirmar ASIGNACION como tabla propia con PK artificial y FK | esquema_relacional.md | Borrador existe |
| F3-05 | Confirmar DOCUMENTO_RECURSO con tres FK opcionales | esquema_relacional.md | Borrador existe |
| F3-06 | Completar analisis 1FN para todas las tablas | analisis_normalizacion.md | Borrador existe |
| F3-07 | Completar analisis 2FN (especial atencion a CONDUCTOR_CATEGORIA_PERMISO) | analisis_normalizacion.md | Borrador existe |
| F3-08 | Completar analisis 3FN para todas las tablas | analisis_normalizacion.md | Borrador existe |
| F3-09 | Documentar dependencias funcionales | analisis_normalizacion.md | Borrador existe |
| F3-10 | Verificar diagrama_logico_textual.md (nombres semanticos, cardinalidades, tablas nuevas) | diagrama_logico_textual.md | Borrador existe |
| F3-11 | Completar tablas_con_datos_ejemplo.md (servicio LTL con 2 mercancias, CATEGORIA_PERMISO) | tablas_con_datos_ejemplo.md | Borrador existe |
| F3-12 | Dibujar diagrama logico en draw.io usando diagrama_logico_textual.md como guia | draw.io | Pendiente |
| F3-13 | Exportar PNG del diagrama logico a /diagramas/modelo_logico.png | diagramas/ | Pendiente |
| F3-14 | Verificacion de coherencia total FASE 3 con FASE 2 | Todos los archivos | Pendiente |
| F3-15 | Actualizar checklist y cambiar badge FASE 3 a Completada | README.md | Pendiente |

---

## 5. Tareas de FASE 4

FASE 4 no tiene ningun contenido previo. Se inicia desde cero una vez FASE 3 este
completada y aprobada.

| # | Tarea | Archivo objetivo | Observacion |
|:---:|---|---|---|
| F4-01 | Definir tipos de dato MySQL para cada columna del esquema relacional | documentacion_fisica.md | Empezar por aqui |
| F4-02 | Definir PKs fisicas: INT AUTO_INCREMENT | schema.sql | -- |
| F4-03 | Definir FKs con ON DELETE y ON UPDATE segun caso | schema.sql | -- |
| F4-04 | Definir restricciones NOT NULL, UNIQUE, DEFAULT, CHECK | schema.sql | -- |
| F4-05 | Crear script DDL: CREATE DATABASE + todas las CREATE TABLE | schema.sql | -- |
| F4-06 | Ejecutar schema.sql en MySQL y verificar que no hay errores | MySQL / phpMyAdmin | -- |
| F4-07 | Planificar y aplicar al menos un ALTER TABLE justificado | alter_table.sql | Requisito del modulo |
| F4-08 | Disenar datos de prueba representativos (min. 5-10 registros por tabla principal) | datos_prueba.sql | -- |
| F4-09 | Crear script INSERT INTO para todas las tablas en orden correcto | datos_prueba.sql | Respetar FKs |
| F4-10 | Ejecutar datos_prueba.sql y verificar integridad referencial | MySQL / phpMyAdmin | -- |
| F4-11 | Tomar capturas de phpMyAdmin: estructura, relaciones, datos | capturas_phpmyadmin.md | -- |
| F4-12 | Redactar documentacion de decisiones fisicas | documentacion_fisica.md | -- |
| F4-13 | Copiar schema.sql a /sql/schema.sql | /sql/ | -- |
| F4-14 | Copiar datos_prueba.sql a /sql/datos_prueba.sql | /sql/ | -- |
| F4-15 | Actualizar checklist y cambiar badge FASE 4 a Completada | README.md | -- |

---

## 6. Advertencias para no mezclar fases

| Advertencia | Que NO hacer |
|---|---|
| El modelo conceptual de FASE 2 esta cerrado | No modificar entidades ni relaciones de FASE 2 al trabajar en FASE 3 |
| Las FK son exclusivas de FASE 3 y 4 | No anadir FK como atributos en ningun documento de FASE 2 |
| Los tipos de dato MySQL son de FASE 4 | No usar INT, VARCHAR, DATETIME, etc. en documentos de FASE 3 |
| Las sentencias CREATE TABLE son de FASE 4 | No escribir SQL en FASE 3 |
| Los INSERT INTO son de FASE 4 | No escribir SQL en FASE 3 ni antes |
| Los datos de ejemplo de FASE 3 son logicos | En FASE 3 son datos representativos en Markdown; en FASE 4 son INSERT reales |
| FASE 4 requiere FASE 3 completada | No iniciar FASE 4 hasta que FASE 3 este verificada, con diagrama y badge Completada |
| El diagrama logico de FASE 3 es distinto del E/R de FASE 2 | Son dos diagramas diferentes; no confundirlos |

---

## 7. Orden recomendado de trabajo

### Para iniciar FASE 3:

1. Leer diccionario_entidades.md y diccionario_relaciones.md de FASE 2 como referencia.
2. Abrir esquema_relacional.md (borrador) y verificar que las 20 tablas son coherentes con FASE 2.
3. Completar analisis_normalizacion.md (1FN, 2FN, 3FN para todas las tablas).
4. Verificar diagrama_logico_textual.md (nombres de relaciones, cardinalidades, nuevas tablas).
5. Completar tablas_con_datos_ejemplo.md (servicio LTL con 2 mercancias, datos CATEGORIA_PERMISO).
6. Dibujar el diagrama logico en draw.io usando diagrama_logico_textual.md como guia.
7. Exportar PNG a /diagramas/modelo_logico.png.
8. Verificar coherencia total de FASE 3 contra FASE 2.
9. Actualizar checklist del README de FASE 3.
10. Cambiar badge de FASE 3 a Completada.
11. Commit: `docs(fase3): complete logical model and normalization to 3NF [FECHA]`

### Para iniciar FASE 4 (solo cuando FASE 3 este cerrada):

1. Leer esquema_relacional.md de FASE 3 como documento base de partida.
2. Decidir tipos de dato MySQL para cada columna y registrar en documentacion_fisica.md.
3. Escribir schema.sql con CREATE DATABASE y todas las CREATE TABLE en orden correcto.
4. Ejecutar en MySQL y depurar cualquier error.
5. Aplicar y documentar al menos un ALTER TABLE.
6. Disenar y ejecutar datos_prueba.sql con datos variados y realistas.
7. Tomar capturas de phpMyAdmin.
8. Documentar las decisiones fisicas.
9. Commit: `feat(fase4): implement physical MySQL database with test data [FECHA]`

---

## Referencia rapida: entidades del modelo (19)

| # | Entidad | Area | Naturaleza |
|:---:|---|---|---|
| 1 | CLIENTE | Clientes y terceros | Regular |
| 2 | CONTACTO | Clientes y terceros | Regular |
| 3 | DIRECCION_OPERATIVA | Clientes y terceros | Regular |
| 4 | SERVICIO | Servicios y seguimiento | Central |
| 5 | PUNTO_SERVICIO | Servicios y seguimiento | Regular |
| 6 | EVENTO_SEGUIMIENTO | Servicios y seguimiento | Regular |
| 7 | MERCANCIA | Mercancia y requisitos | Regular |
| 8 | REQUISITO_ESPECIAL | Mercancia y requisitos | Regular |
| 9 | INCIDENCIA | Incidencias | Regular |
| 10 | VEHICULO | Recursos | Regular |
| 11 | REMOLQUE | Recursos | Regular |
| 12 | CONDUCTOR | Recursos | Regular |
| 13 | ASIGNACION | Recursos | Asociativa |
| 14 | CATEGORIA_PERMISO | Recursos | Catalogo |
| 15 | COSTE_OPERATIVO | Costes operativos | Regular |
| 16 | FACTURA | Facturacion y cobros | Regular |
| 17 | DOCUMENTO_SERVICIO | Documentacion y control interno | Regular |
| 18 | DOCUMENTO_RECURSO | Documentacion y control interno | Regular |
| 19 | REGISTRO_AUDITORIA | Documentacion y control interno | Transversal |

En FASE 3 se generan 20 tablas logicas: las 19 entidades anteriores + CONDUCTOR_CATEGORIA_PERMISO
(tabla intermedia para la relacion N:M R-21 POSEE_CATEGORIA entre CONDUCTOR y CATEGORIA_PERMISO).
