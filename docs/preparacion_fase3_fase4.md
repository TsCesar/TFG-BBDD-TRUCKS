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
| FASE 3 | En revision | Borradores verificados en entregables/. Pendientes: diagrama PNG y revision final contra nuevo listado |
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

Referencia: RA2 TFG DAM Listado Fase3 y 4 CesarMendez.pdf (en /anexos)

Los borradores de entregables/ han sido revisados y corregidos contra el modelo E/R de FASE 2.
Las actividades 1-6 del listado estan cubiertas por los documentos existentes.
Pendiente: diagrama PNG y revision de coherencia final.

| # | Actividad (segun listado oficial) | Tarea concreta | Archivo | Estado |
|:---:|---|---|---|:---:|
| F3-01 | Transformar cada entidad en una tabla | 20 tablas documentadas (19 entidades + tabla N:M) | esquema_relacional.md | Borrador verificado |
| F3-02 | Definir los campos principales de cada tabla | Columnas con tipo logico, restricciones y descripcion | esquema_relacional.md | Borrador verificado |
| F3-03 | Indicar claves primarias y claves foraneas | PKs y FKs con nullable segun participacion de FASE 2 | esquema_relacional.md | Borrador verificado |
| F3-04 | Resolver relaciones muchos a muchos | R-21 resuelta con CONDUCTOR_CATEGORIA_PERMISO (PK compuesta) | esquema_relacional.md | Borrador verificado |
| F3-05 | Revisar que la informacion no este repetida | Analisis de redundancias 1FN/2FN/3FN para 20 tablas | analisis_normalizacion.md | Borrador verificado |
| F3-06 | Comprobar diseno hasta tercera forma normal | 1FN, 2FN, 3FN; excepcion documentada en FACTURA | analisis_normalizacion.md | Borrador verificado |
| F3-07 | (Complemento) Guia para diagrama logico | Representacion textual completa para draw.io | diagrama_logico_textual.md | Borrador verificado |
| F3-08 | (Complemento) Datos de ejemplo por tabla | 3-5 filas por tabla; LTL con 2 lotes de mercancia | tablas_con_datos_ejemplo.md | Borrador verificado |
| F3-09 | (Pendiente) Diagrama logico exportado | Dibujar en draw.io y exportar PNG | /diagramas/modelo_logico.png | **Pendiente** |
| F3-10 | (Pendiente) Revision final | Coherencia total contra nuevo listado y modelo E/R | Todos | **Pendiente** |
| F3-11 | (Pendiente) Cierre | Badge Completada + commit de cierre | README.md | **Pendiente** |

---

## 5. Tareas de FASE 4

Referencia: RA2 TFG DAM Listado Fase3 y 4 CesarMendez.pdf (en /anexos)

FASE 4 no tiene ningun contenido previo. Se inicia desde cero una vez FASE 3 este
completada y aprobada (badge Completada, diagrama PNG exportado).

| # | Actividad (segun listado oficial) | Tarea concreta | Archivo | Estado |
|:---:|---|---|---|:---:|
| F4-01 | Crear la base de datos del proyecto | CREATE DATABASE + verificacion | schema.sql | Pendiente |
| F4-02 | Crear las tablas principales con sus campos | CREATE TABLE para las 20 tablas; tipos de dato MySQL definidos | schema.sql | Pendiente |
| F4-03 | Relacionar las tablas entre si | FOREIGN KEY con REFERENCES, ON DELETE, ON UPDATE | schema.sql | Pendiente |
| F4-04 | Anadir restricciones basicas | NOT NULL, UNIQUE, DEFAULT, CHECK para DOCUMENTO_RECURSO | schema.sql | Pendiente |
| F4-05 | Realizar alguna modificacion con ALTER TABLE | Al menos un ALTER TABLE justificado y documentado | alter_table.sql | Pendiente |
| F4-06 | Insertar datos de prueba | Clientes, servicios, camiones, conductores, incidencias, costes, facturas y documentos | datos_prueba.sql | Pendiente |
| F4-07 | Probar scripts en phpMyAdmin y guardar capturas | Capturas de estructura y datos; copiar scripts a /sql/ | capturas_phpmyadmin.md | Pendiente |
| F4-08 | (Complemento) Documentacion fisica | Justificacion de tipos de dato y decisiones fisicas | documentacion_fisica.md | Pendiente |
| F4-09 | (Cierre) Actualizar checklist y badge | Badge Completada + commit de cierre | README.md | Pendiente |

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

### Para cerrar FASE 3 (borradores ya verificados -- solo queda lo siguiente):

1. Los borradores de entregables/ estan verificados contra FASE 2 y cubren las 6 actividades
   del listado oficial (RA2 TFG DAM Listado Fase3 y 4 CesarMendez.pdf).
2. Abrir draw.io y dibujar el diagrama logico usando diagrama_logico_textual.md como guia.
3. Exportar PNG a /diagramas/modelo_logico.png.
4. Hacer la revision de coherencia final contra el nuevo listado.
5. Actualizar checklist del README de FASE 3 (marcar los dos items pendientes).
6. Cambiar badge de FASE 3 a Completada.
7. Commit: `docs(fase3): complete logical model and normalization to 3NF [FECHA]`

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
