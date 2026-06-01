# TODO -- FASE 3

> Referencia: RA2 TFG DAM Listado Fase3 y 4 CesarMendez.pdf (en /anexos)

## Trabajo completado en los borradores

Los documentos de entregables/ existen y han sido revisados. Corresponden a borradores
verificados contra el modelo E/R cerrado de FASE 2. Pendiente revision formal final.

- [x] Actividad 1 -- Transformar cada entidad en una tabla
      esquema_relacional.md: 20 tablas (19 entidades + CONDUCTOR_CATEGORIA_PERMISO)
- [x] Actividad 2 -- Definir los campos principales de cada tabla
      Columnas, tipos logicos, restricciones y descripciones en esquema_relacional.md
- [x] Actividad 3 -- Indicar claves primarias y claves foraneas
      PKs y FKs definidas; nullable / NOT NULL segun participacion de FASE 2
- [x] Actividad 4 -- Resolver relaciones muchos a muchos
      R-21 POSEE_CATEGORIA resuelta con tabla CONDUCTOR_CATEGORIA_PERMISO (PK compuesta)
- [x] Actividad 5 -- Revisar que la informacion no este repetida sin necesidad
      Analisis de redundancias en analisis_normalizacion.md; no hay datos denormalizados
- [x] Actividad 6 -- Comprobar que el diseno este organizado hasta tercera forma normal
      1FN, 2FN y 3FN analizados para las 20 tablas; excepcion documentada en FACTURA
- [x] Datos de ejemplo por tabla (tablas_con_datos_ejemplo.md; LTL con 2 lotes de mercancia)
- [x] Diagrama logico textual como guia para draw.io (diagrama_logico_textual.md)
- [x] Correcciones de coherencia aplicadas (T-09 corregida, tabla 4.3 completada, 20 tablas)

## Cierre de FASE 3

- [x] Diagrama logico dibujado en draw.io (ModeloLogico.png)
- [x] Diagrama exportado a entregables/ModeloLogico.png y diagramas/modelo_logico.png
- [x] Revision de coherencia final contra RA2 TFG DAM Listado Fase3 y 4 CesarMendez.pdf
- [x] Badge de FASE 3 cambiado a Completada en README y en README principal
- [x] Commit de cierre: docs(fase3): close logical model and normalization phase

## Notas

FASE 3 CERRADA -- 2026-06-01.
Todos los entregables verificados contra el modelo E/R de FASE 2 y el listado oficial.
No hay SQL ni tipos de dato MySQL en esta fase (son de FASE 4).
FASE 4 puede iniciarse: ver docs/preparacion_fase3_fase4.md para el orden de trabajo.
