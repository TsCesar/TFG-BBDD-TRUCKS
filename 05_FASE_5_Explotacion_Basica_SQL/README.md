# âš™ï¸ FASE 5 â€” Explotacion Basica de la Base de Datos

[![Estado](https://img.shields.io/badge/Estado-Pendiente-red?style=flat-square)](.)
[![Fase](https://img.shields.io/badge/Fase-5%20de%206-blue?style=flat-square)](.)
[![SQL](https://img.shields.io/badge/SQL-DML%20%2B%20SELECT-4479A1?style=flat-square)](.)
[![Dependencia](https://img.shields.io/badge/Requiere-FASE%204%20completada-orange?style=flat-square)](../04_FASE_4_Diseno_Fisico_MySQL)

---

## De que va esta fase?

La base de datos esta creada y tiene datos. Ahora hay que empezar a usarla.

En esta fase se demuestran dos cosas fundamentales: que sabemos **modificar los datos** de la BD (insertar nuevos registros, actualizar datos existentes, eliminar lo que ya no sirve) y que sabemos **consultarla** para obtener informacion util.

Las operaciones de esta fase tienen que ser reales y tener sentido en el contexto de la empresa. No se trata de hacer consultas aleatorias, sino de simular lo que haria un trabajador de la empresa en su dia a dia.

---

## ðŸŽ¯ Objetivo de la fase

Demostrar el uso operativo basico de la base de datos mediante operaciones DML y consultas SELECT simples que reflejen el trabajo diario de la empresa de transporte.

---

## ðŸ“ Que cubre esta fase

âœ… **Si entra:**
- Operaciones INSERT INTO (registrar nuevos servicios, clientes, incidencias...)
- Operaciones UPDATE (cambiar el estado de un envio, actualizar datos de un conductor...)
- Operaciones DELETE (eliminar registros que ya no aplican, con justificacion)
- Consultas SELECT con WHERE, ORDER BY, LIMIT y proyecciones de columnas
- Documentacion del objetivo y resultado de cada operacion

âŒ **No entra todavia:**
- JOINs multitabla complejos (FASE 6)
- GROUP BY y funciones de agregado (FASE 6)
- Triggers (FASE 6)

---

## ðŸ“¦ Entregables de esta fase

| Script / Documento | Descripcion |
|---|---|
| `operaciones_dml.sql` | INSERT, UPDATE y DELETE con comentarios explicativos |
| `consultas_simples.sql` | SELECT simples con comentarios |
| `documentacion_fase5.md` | Tabla con objetivo, SQL y resultado de cada operacion |
| `capturas_resultados.md` | Capturas de phpMyAdmin con los resultados |

---

## âœ… Checklist antes de cerrar la fase

- [ ] Minimo 3 INSERT INTO (casos practicos del dominio, no datos aleatorios)
- [ ] Minimo 3 UPDATE (con razon de negocio real)
- [ ] Minimo 2 DELETE (con justificacion de por que se elimina ese dato)
- [ ] Minimo 5 consultas SELECT simples en distintas tablas
- [ ] Cada operacion tiene objetivo explicado y resultado documentado
- [ ] Capturas de resultados incluidas
- [ ] Scripts ejecutables sin errores sobre los datos de FASE 4
- [ ] No se comprometen datos necesarios para FASE 6 (o se documenta el orden)

---

## â­ï¸ Cuando esta fase este lista...

1. Copia los scripts relevantes a `/sql/consultas.sql`
2. Cambia el badge de estado a **Completada**
3. Commit: `feat(fase5): add DML operations and basic SQL queries [FECHA]`
4. Pasa a la **FASE 6 â€” Explotacion Avanzada SQL**

---

> ðŸ’¡ **Cuidado con el orden:** Si haces DELETE en esta fase, asegurate de no eliminar datos que vas a necesitar en FASE 6. Una buena practica es hacer los DELETE al final, o trabajar con datos que no afecten a las consultas avanzadas.