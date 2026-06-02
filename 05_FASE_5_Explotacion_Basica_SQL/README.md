<div align="center">

# FASE 5 - Explotacion Basica de la Base de Datos

[![Estado](https://img.shields.io/badge/Estado-Finalizado-brightgreen?style=for-the-badge)](./entregables)
[![Fase](https://img.shields.io/badge/Fase-5%20de%206-blue?style=for-the-badge)](.)
[![SQL](https://img.shields.io/badge/SQL-DML%20%2B%20SELECT-4479A1?style=for-the-badge)](./entregables)
[![Requiere](https://img.shields.io/badge/Requiere-FASE%204%20completada-brightgreen?style=for-the-badge)](../04_FASE_4_Diseno_Fisico_MySQL)

</div>

---

## De que va esta fase?

La base de datos esta creada y tiene datos. Ahora hay que **empezar a usarla**.

En esta fase se demuestran dos cosas:

1. Que sabemos **modificar los datos** de la BD: insertar nuevos registros, actualizar datos existentes, eliminar registros de prueba.
2. Que sabemos **consultarla** para obtener informacion util para la empresa de transporte.

Las operaciones tienen que ser reales y tener sentido en el contexto del negocio. No se hacen consultas aleatorias, sino lo que haria un trabajador en su dia a dia.

---

## Objetivo de la fase

Demostrar el uso operativo basico de la base de datos mediante operaciones DML y consultas SELECT simples que reflejen el trabajo diario de la empresa de transporte.

---

## Que cubre esta fase?

**Entra en esta fase:**

- Operaciones `INSERT INTO` (nuevos contactos, costes operativos, registro de prueba para DELETE)
- Operaciones `UPDATE` (corregir email de cliente, marcar documentacion recibida, actualizar estado de incidencia)
- Operaciones `DELETE` (eliminar un registro de prueba creado expresamente para la actividad)
- Consultas `SELECT` con `WHERE`, `ORDER BY` y proyeccion de columnas
- Documentacion del objetivo y resultado de cada operacion
- Capturas de resultados en phpMyAdmin

**No entra en esta fase:**

- JOINs multitabla complejos -- FASE 6
- `GROUP BY` y funciones de agregado -- FASE 6
- Triggers y automatismos -- FASE 6

---

## Entregables

| Script / Documento | Descripcion | Ubicacion |
|---|---|:---:|
| `consultas_basicas.sql` | INSERT, UPDATE, DELETE y SELECT con comentarios breves | `entregables/` |
| `explicacion_consultas_basicas.md` | Objetivo, tablas, resultado y utilidad de cada operacion | `entregables/` |
| `capturas_consultas_basicas.md` | Plantilla para las capturas de phpMyAdmin | `entregables/` |

Copia sincronizada disponible en `sql/consultas_basicas.sql`.

---

## Orden de ejecucion

Los scripts de FASE 5 se ejecutan **sobre la base de datos ya cargada en FASE 4**.
No volver a ejecutar los scripts de FASE 4. La BD ya tiene los datos.

```
1. schema.sql           (FASE 4 -- ya ejecutado)
2. alter_table.sql      (FASE 4 -- ya ejecutado)
3. datos_prueba.sql     (FASE 4 -- ya ejecutado)
4. consultas_basicas.sql   <-- este script (FASE 5)
```

Para tomar capturas por separado, ejecutar cada seccion del script de forma individual
en la pestana SQL de phpMyAdmin.

---

## Checklist de la fase

Actividades segun el listado oficial (RA2 TFG DAM Listado Fases 5 y 6 -- Cesar Mendez):

- [x] Actividad 1 -- Añadir nuevos registros con INSERT
- [x] Actividad 2 -- Modificar datos existentes con UPDATE
- [x] Actividad 3 -- Borrar registros de prueba con DELETE
- [x] Actividad 4 -- Consultar clientes activos
- [x] Actividad 5 -- Consultar servicios por estado
- [x] Actividad 6 -- Consultar vehiculos y conductores disponibles
- [x] Actividad 7 -- Consultar facturas pendientes e incidencias abiertas
- [x] Actividad 8 -- Guardar capturas de los resultados en phpMyAdmin

---

## Estado actual

Consultas ejecutadas en phpMyAdmin el 2026-06-02. Las 7 capturas reales estan enlazadas
en `entregables/capturas_consultas_basicas.md`. Fase completada.

---

> **Nota sobre el DELETE:** El DELETE se hace sobre un cliente de prueba con CIF `TEST-DELETE-01`
> creado en la misma sesion. No se eliminan datos de FASE 4 necesarios para FASE 6.
>
> **FASE 6** (JOINs, agregaciones y trigger de auditoria) es una fase separada con sus propios entregables.
