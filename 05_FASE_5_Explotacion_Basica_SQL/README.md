<div align="center">

# FASE 5 - Explotacion Basica de la Base de Datos

[![Estado](https://img.shields.io/badge/Estado-Pendiente-red?style=for-the-badge)](./entregables)
[![Fase](https://img.shields.io/badge/Fase-5%20de%206-blue?style=for-the-badge)](.)
[![SQL](https://img.shields.io/badge/SQL-DML%20%2B%20SELECT-4479A1?style=for-the-badge)](./entregables)
[![Requiere](https://img.shields.io/badge/Requiere-FASE%204%20completada-orange?style=for-the-badge)](../04_FASE_4_Diseno_Fisico_MySQL)

</div>

---

## De que va esta fase?

La base de datos esta creada y tiene datos. Ahora hay que **empezar a usarla**.

En esta fase se demuestran dos cosas fundamentales:

1. Que sabemos **modificar los datos** de la BD: insertar nuevos registros, actualizar datos existentes, eliminar lo que ya no sirve.
2. Que sabemos **consultarla** para obtener informacion util.

Las operaciones tienen que ser reales y tener sentido en el contexto de la empresa. No se trata de hacer consultas aleatorias, sino de simular lo que haria un trabajador en su dia a dia.

---

## Objetivo de la fase

Demostrar el uso operativo basico de la base de datos mediante operaciones DML y consultas SELECT simples que reflejen el trabajo diario de la empresa de transporte.

---

## Que cubre esta fase?

**Entra en esta fase:**

- Operaciones `INSERT INTO` (registrar nuevos servicios, clientes, incidencias...)
- Operaciones `UPDATE` (cambiar el estado de un envio, actualizar datos de un conductor...)
- Operaciones `DELETE` (eliminar registros que ya no aplican, con justificacion)
- Consultas `SELECT` con `WHERE`, `ORDER BY`, `LIMIT` y proyecciones de columnas
- Documentacion del objetivo y resultado de cada operacion

**No entra todavia:**

- JOINs multitabla complejos (FASE 6)
- `GROUP BY` y funciones de agregado (FASE 6)
- Triggers (FASE 6)

---

## Entregables

| Script / Documento | Descripcion | Ubicacion |
|---|---|:---:|
| `operaciones_dml.sql` | INSERT, UPDATE y DELETE con comentarios explicativos | `entregables/` |
| `consultas_simples.sql` | SELECT simples con comentarios | `entregables/` |
| `documentacion_fase5.md` | Tabla con objetivo, SQL y resultado de cada operacion | `entregables/` |
| `capturas_resultados.md` | Capturas de phpMyAdmin con los resultados | `entregables/` |

---

## Estructura interna

```
05_FASE_5_Explotacion_Basica_SQL/
|
+-- README.md              <- Estas aqui
+-- documentacion/
|   +-- notas.md
|   +-- TODO.md
+-- borradores/
+-- entregables/
```

---

## Checklist de la fase

- [ ] Minimo 3 operaciones INSERT INTO (casos practicos del dominio)
- [ ] Minimo 3 operaciones UPDATE (con razon de negocio real)
- [ ] Minimo 2 operaciones DELETE (con justificacion)
- [ ] Minimo 5 consultas SELECT simples en distintas tablas
- [ ] Cada operacion con objetivo explicado y resultado documentado
- [ ] Capturas de resultados incluidas
- [ ] Scripts ejecutables sin errores sobre los datos de FASE 4
- [ ] No se comprometen datos necesarios para FASE 6

---

## Cuando esta fase este lista...

1. Copia los scripts relevantes a `/sql/consultas.sql`
2. Cambia el badge a **Completada**
3. Commit: `feat(fase5): add DML operations and basic SQL queries [FECHA]`
4. Pasa a la **FASE 6 - Explotacion Avanzada SQL**

---

> **Cuidado con el orden:** Si haces DELETE en esta fase, asegurate de no eliminar datos que vas a necesitar en FASE 6. Una buena practica es hacer los DELETE al final o trabajar con registros que no afecten a las consultas avanzadas.
