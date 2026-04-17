# ðŸš€ FASE 6 â€” Explotacion Avanzada de la Base de Datos

[![Estado](https://img.shields.io/badge/Estado-Pendiente-red?style=flat-square)](.)
[![Fase](https://img.shields.io/badge/Fase-6%20de%206-blue?style=flat-square)](.)
[![SQL](https://img.shields.io/badge/SQL-JOINs%20%7C%20Funciones%20%7C%20Triggers-4479A1?style=flat-square)](.)
[![Dependencia](https://img.shields.io/badge/Requiere-FASE%205%20completada-orange?style=flat-square)](../05_FASE_5_Explotacion_Basica_SQL)

---

## De que va esta fase?

Esta es la fase que mas peso tiene en la evaluacion, y la que mas satisfaccion da cuando funciona.

Aqui se demuestra que la base de datos **responde a las preguntas reales del negocio**: las que se plantearon en los requerimientos de FASE 1. Pero ya no con SELECT simples, sino con todo el arsenal del SQL: combinaciones entre tablas, funciones de agregado, agrupaciones, subconsultas y automatismos mediante triggers.

El objetivo es que cualquier persona que lea este codigo y las capturas de resultados entienda que la BD es util, que los datos tienen coherencia y que el sistema podria funcionar en un entorno real.

---

## ðŸŽ¯ Objetivo de la fase

Construir consultas SQL avanzadas que respondan a **todos los requerimientos funcionales de FASE 1**, y automatizar al menos una operacion de negocio relevante mediante triggers.

---

## ðŸ“ Que cubre esta fase

| Tipo de SQL | Descripcion |
|---|---|
| `INNER JOIN` | Cruzar datos de varias tablas para obtener informacion combinada |
| `LEFT/RIGHT JOIN` | Detectar registros sin correspondencia (envios sin facturar, vehiculos sin asignar...) |
| `GROUP BY + funciones` | Totales, medias, conteos (servicios por cliente, coste medio por ruta...) |
| `HAVING` | Filtrar grupos (clientes con mas de X servicios, rutas con coste medio alto...) |
| `NOT IN / NOT EXISTS` | Restas de conjuntos (clientes sin incidencias, conductores sin servicio asignado...) |
| `Subconsultas` | Consultas dentro de consultas para respuestas complejas |
| `Triggers` | Automatizar operaciones al insertar, actualizar o eliminar registros |

---

## ðŸ“¦ Entregables de esta fase

| Script / Documento | Descripcion |
|---|---|
| `consultas_avanzadas.sql` | JOINs, funciones de agregado, GROUP BY, subconsultas |
| `operaciones_conjuntos.sql` | NOT IN, NOT EXISTS, EXCEPT |
| `triggers.sql` | Triggers implementados con documentacion |
| `documentacion_fase6.md` | Objetivo, SQL y resultado de cada consulta y trigger |
| `capturas_resultados.md` | Capturas de phpMyAdmin |
| `trazabilidad_requerimientos.md` | Tabla que mapea cada RF de FASE 1 con la consulta que lo satisface |

---

## âœ… Checklist antes de cerrar la fase

- [ ] Minimo 3 consultas con INNER JOIN (multitabla)
- [ ] Minimo 2 consultas con LEFT o RIGHT JOIN
- [ ] Minimo 3 consultas con GROUP BY + funcion de agregado (COUNT, SUM, AVG, MAX, MIN)
- [ ] Minimo 1 consulta con HAVING
- [ ] Minimo 1 operacion de resta de conjuntos (NOT IN / NOT EXISTS)
- [ ] Minimo 1 subconsulta o tabla derivada
- [ ] Minimo 1 trigger implementado, probado y documentado
- [ ] Documento de trazabilidad RF -> consulta completado
- [ ] Todos los scripts ejecutables sin errores
- [ ] Capturas de resultados incluidas para cada consulta y trigger
- [ ] Documentacion completa: objetivo + resultado de cada elemento

---

## â­ï¸ Cuando esta fase este lista...

1. Copia los scripts a `/sql/consultas.sql`
2. Actualiza el estado a **Completada** en este README y en el README principal
3. Commit: `feat(fase6): add advanced SQL queries and triggers [FECHA]`
4. **Revision final de todo el repositorio**
5. Prepara la defensa del TFG

---

> ðŸ’¡ **Para la defensa:** El documento `trazabilidad_requerimientos.md` es oro. Si el tribunal te pregunta "y esto para que sirve?", basta con senalar la fila de la tabla que conecta esa consulta con el requerimiento original. Demuestra que el diseno tiene coherencia de principio a fin.