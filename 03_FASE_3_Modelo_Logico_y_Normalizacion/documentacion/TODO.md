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

## Pendiente -- bloquea el cierre de FASE 3

- [ ] Dibujar el diagrama logico en draw.io usando diagrama_logico_textual.md como guia
- [ ] Exportar el diagrama a /diagramas/modelo_logico.png
- [ ] Revision de coherencia final contra RA2 TFG DAM Listado Fase3 y 4 CesarMendez.pdf
- [ ] Cambiar badge de FASE 3 a Completada en README y en README principal
- [ ] Commit de cierre: docs(fase3): complete logical model and normalization to 3NF [FECHA]

## Notas

FASE 3 en revision. Los entregables existen como borradores verificados contra FASE 2.
No se considera completada hasta que el diagrama PNG este exportado y la revision final
contra el nuevo listado este documentada.
No iniciar SQL ni tipos de dato MySQL en esta fase.
FASE 4 no puede iniciarse hasta que FASE 3 este cerrada y verificada.
