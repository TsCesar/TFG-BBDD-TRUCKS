# TODO -- FASE 3

## Tareas completadas

- [x] Revisar entregables/ contra el modelo E/R cerrado de FASE 2
- [x] esquema_relacional.md completo (20 tablas, incluida CONDUCTOR_CATEGORIA_PERMISO)
- [x] Analisis 1FN en todas las tablas
- [x] Analisis 2FN (CONDUCTOR_CATEGORIA_PERMISO es la unica tabla con PK compuesta)
- [x] Analisis 3FN en todas las tablas; excepcion documentada en FACTURA.importe_total
- [x] Dependencias funcionales documentadas tabla por tabla
- [x] analisis_normalizacion.md verificado y corregido (T-09 era erronea: sin UNIQUE; tabla 4.3 completada con 20 tablas; conclusion corregida)
- [x] diagrama_logico_textual.md verificado y completo
- [x] tablas_con_datos_ejemplo.md verificado: SRV-2026-0003 LTL incluye 2 lotes de mercancia (id_mercancia 3 y 4, mismo id_servicio=3)
- [x] Checklist del README actualizado y badge corregido a Completada
- [x] Commit: docs(fase3): complete logical model and normalization [2026-06-01]

## Pendiente (no bloquea FASE 4)

- [ ] Dibujar diagrama logico en draw.io y exportar a `/diagramas/modelo_logico.png`

## Notas

FASE 3 completada el 2026-06-01. El unico entregable pendiente es el diagrama PNG, que
requiere trabajo manual en draw.io a partir de diagrama_logico_textual.md.
No iniciar trabajo de SQL ni tipos de dato MySQL hasta completar ese paso si es necesario;
FASE 4 puede iniciarse con el esquema_relacional.md como referencia principal.
