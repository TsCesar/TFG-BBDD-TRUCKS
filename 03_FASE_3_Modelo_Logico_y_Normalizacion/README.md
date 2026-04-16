# FASE 3 - Modelo Logico y Normalizacion (Esquema Relacional)

Estado: Pendiente
Dependencia: FASE 2 completada y validada
Proyecto: TFG - Base de Datos Empresa de Transporte Intracomunitario (UE)

---

## Objetivo

Obtener el esquema relacional (modelo logico) a partir del modelo conceptual de FASE 2, establecer en que forma normal se encuentra y normalizarlo hasta Tercera Forma Normal (3FN) si fuera necesario. Presentar tablas con datos de ejemplo que demuestren que la BD esta normalizada y lista para su implementacion fisica.

---

## Alcance

- Transformacion del diagrama E/R al esquema relacional.
- Analisis del nivel de normalizacion de cada tabla (1FN, 2FN, 3FN).
- Aplicacion de las transformaciones de normalizacion necesarias hasta 3FN.
- Definicion completa del esquema: tablas, columnas, tipos de datos, PKs, FKs, restricciones.
- Presentacion de tablas con datos de ejemplo representativos.

---

## Entregables

| Entregable | Descripcion | Ubicacion |
|---|---|---|
| esquema_relacional.md | Definicion completa de todas las tablas del modelo logico | entregables/ |
| analisis_normalizacion.md | Analisis de formas normales y transformaciones aplicadas | entregables/ |
| diagrama_logico.png | Diagrama del modelo relacional (con claves y relaciones) | entregables/ |
| tablas_con_datos_ejemplo.md | Tablas con filas de datos de ejemplo para demostrar normalizacion | entregables/ |

---

## Checklist

- [ ] Transformacion E/R a Relacional documentada y justificada.
- [ ] Analisis de 1FN, 2FN y 3FN para cada tabla.
- [ ] Normalizacion hasta 3FN aplicada (con justificacion de cada paso).
- [ ] Esquema relacional completo (tablas, columnas, tipos, PKs, FKs, restricciones).
- [ ] Diagrama del modelo logico elaborado y exportado.
- [ ] Datos de ejemplo que demuestren la normalizacion.
- [ ] Coherencia con FASE 2 verificada.
- [ ] Revision y validacion antes de pasar a FASE 4.

---

## Proximos Pasos

1. Mover diagrama logico a /diagramas/modelo_logico.png.
2. Actualizar estado a Completada.
3. Commit: docs(fase3): complete logical model and normalization [FECHA]
4. Avanzar a FASE 4 - Diseno Fisico en MySQL.

---

## Notas

- No se escribe SQL en esta fase (eso es FASE 4).
- Los datos de ejemplo son ilustrativos, no se insertan en la BD todavia.
- La normalizacion hasta 3FN es requisito obligatorio del modulo.