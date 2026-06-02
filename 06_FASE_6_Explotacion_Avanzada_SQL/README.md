<div align="center">

# FASE 6 - Explotacion Avanzada de la Base de Datos

[![Estado](https://img.shields.io/badge/Estado-Finalizado-brightgreen?style=for-the-badge)](./entregables)
[![Fase](https://img.shields.io/badge/Fase-6%20de%206-blue?style=for-the-badge)](.)
[![SQL](https://img.shields.io/badge/SQL-JOINs%20%7C%20Agregaciones%20%7C%20Trigger-4479A1?style=for-the-badge)](./entregables)
[![Requiere](https://img.shields.io/badge/Requiere-FASE%205%20completada-orange?style=for-the-badge)](../05_FASE_5_Explotacion_Basica_SQL)

</div>

---

## De que va esta fase?

Aqui se demuestra que la base de datos **responde a las preguntas reales del negocio** planteadas
en los requerimientos de FASE 1. Ya no con SELECT simples, sino con consultas que combinan
varias tablas, agregan datos y detectan situaciones de riesgo.

Ademas se implementa un trigger de auditoria que automatiza el registro de cambios
en los servicios sin necesidad de intervension manual.

---

## Objetivo de la fase

Construir consultas SQL avanzadas que respondan a los requerimientos funcionales de FASE 1,
y automatizar el registro de auditoria mediante un trigger sobre la tabla servicio.

---

## Que cubre esta fase?

| Tecnica SQL | Descripcion |
|---|---|
| `INNER JOIN` | Combinar datos de varias tablas para obtener informacion completa |
| `LEFT JOIN` | Detectar registros sin correspondencia (servicios sin facturar, sin conductor...) |
| `GROUP BY` + `SUM`, `COUNT`, `CASE` | Totales de facturacion, costes por servicio, resumen operativo |
| `DATEDIFF`, `CURDATE`, `DATE_ADD` | Detectar documentos caducados o proximos a caducar |
| `COALESCE` | Manejar valores NULL en JOINs opcionales |
| `FIELD` en `ORDER BY` | Ordenar por un orden logico de estados (no alfabetico) |
| `TRIGGER AFTER UPDATE` | Registrar automaticamente cambios de estado en registro_auditoria |

**No entra en esta fase:**

- Procedimientos almacenados complejos
- Vistas persistentes
- Funciones de usuario
- Administracion de usuarios y permisos

---

## Entregables

| Script / Documento | Descripcion | Ubicacion |
|---|---|:---:|
| `consultas_avanzadas.sql` | JOINs, agregaciones y consultas de control | `entregables/` |
| `trigger_auditoria.sql` | Trigger sobre servicio + prueba de funcionamiento | `entregables/` |
| `explicacion_consultas_avanzadas.md` | Objetivo, tablas, JOINs y utilidad de cada consulta | `entregables/` |
| `relacion_requerimientos.md` | Tabla de trazabilidad consulta -> requerimiento RF | `entregables/` |
| `capturas_consultas_avanzadas.md` | Plantilla para capturas de phpMyAdmin | `entregables/` |

Copias sincronizadas en `sql/consultas_avanzadas.sql` y `sql/trigger_auditoria.sql`.

---

## Orden de ejecucion

```
1. schema.sql              (FASE 4 -- ya ejecutado)
2. alter_table.sql         (FASE 4 -- ya ejecutado)
3. datos_prueba.sql        (FASE 4 -- ya ejecutado)
4. consultas_basicas.sql   (FASE 5 -- ya ejecutado)
5. trigger_auditoria.sql      <-- cargar primero el trigger
6. consultas_avanzadas.sql    <-- ejecutar las consultas
```

> El trigger se carga una sola vez. Una vez creado, se activa automaticamente en
> cada UPDATE sobre la tabla servicio que cambie el campo estado_actual.

---

## Checklist de la fase

Actividades segun el listado oficial (RA2 TFG DAM Listado Fases 5 y 6 -- Cesar Mendez):

- [x] Actividad 1 -- Crear consultas que unan informacion de varias tablas
- [x] Actividad 2 -- Consultar servicios junto con clientes, conductores y vehiculos asignados
- [x] Actividad 3 -- Consultar incidencias relacionadas con servicios
- [x] Actividad 4 -- Calcular costes totales de un servicio
- [x] Actividad 5 -- Consultar facturacion por cliente y periodo
- [x] Actividad 6 -- Detectar servicios sin facturar o con documentacion incompleta
- [x] Actividad 7 -- Localizar documentos caducados o proximos a caducar
- [x] Actividad 8 -- Crear algun trigger o automatismo sencillo
- [x] Actividad 9 -- Relacionar las consultas con los requerimientos del proyecto

---

## Estado actual

Trigger cargado, consultas avanzadas ejecutadas y auditoria verificada en phpMyAdmin el 2026-06-02.
Las 8 capturas reales estan enlazadas en `entregables/capturas_consultas_avanzadas.md`. Fase completada.

---

> **Para la defensa:** El documento `relacion_requerimientos.md` mapea cada consulta con el
> requerimiento funcional (RF-XXX) de FASE 1 que satisface. Si el tribunal pregunta para que
> sirve una consulta, basta señalar la fila correspondiente de esa tabla.
