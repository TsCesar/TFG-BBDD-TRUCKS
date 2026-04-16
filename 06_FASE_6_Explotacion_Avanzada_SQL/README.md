# FASE 6 - Explotacion Avanzada de la Base de Datos (SQL Avanzado)

Estado: Pendiente
Dependencia: FASE 5 completada y validada
Proyecto: TFG - Base de Datos Empresa de Transporte Intracomunitario (UE)

---

## Objetivo

Construir consultas SQL avanzadas que respondan a todos los requerimientos descritos en FASE 1, haciendo uso de las estructuras mas completas del lenguaje SQL: combinaciones internas y externas, funciones predefinidas, agrupaciones, restas, intersecciones, tablas derivadas y triggers.

---

## Alcance

- Combinaciones internas (INNER JOIN): consultas que cruzan datos entre varias tablas.
- Combinaciones externas (LEFT/RIGHT JOIN): para detectar registros sin correspondencia.
- Funciones predefinidas: agregado (COUNT, SUM, AVG, MAX, MIN), cadena, fecha.
- Agrupaciones: GROUP BY con HAVING.
- Restas e intersecciones: EXCEPT / NOT IN / NOT EXISTS.
- Subconsultas y tablas derivadas: subqueries en FROM, WHERE y SELECT.
- Triggers: al menos uno que automatice una operacion interna relevante.
- Documentacion completa de cada consulta: objetivo, SQL y resultado.

---

## Entregables

| Entregable | Descripcion | Ubicacion |
|---|---|---|
| consultas_avanzadas.sql | Consultas con JOINs, funciones, agrupaciones, subconsultas | entregables/ |
| operaciones_conjuntos.sql | Restas e intersecciones documentadas | entregables/ |
| triggers.sql | Codigo de triggers con justificacion | entregables/ |
| documentacion_fase6.md | Explicacion de cada consulta/trigger: objetivo y resultado | entregables/ |
| capturas_resultados.md | Capturas de resultados en phpMyAdmin | entregables/ |
| trazabilidad_requerimientos.md | Mapa consultas a requerimientos de FASE 1 cubiertos | entregables/ |

---

## Checklist

- [ ] Minimo 3 consultas con INNER JOIN (multitabla).
- [ ] Minimo 2 consultas con LEFT/RIGHT JOIN.
- [ ] Minimo 3 consultas con GROUP BY + funciones de agregado.
- [ ] Minimo 1 consulta con HAVING.
- [ ] Minimo 1 resta de conjuntos (NOT IN / EXCEPT / NOT EXISTS).
- [ ] Minimo 1 subconsulta o tabla derivada.
- [ ] Minimo 1 trigger implementado y documentado.
- [ ] Trazabilidad con requerimientos de FASE 1 documentada.
- [ ] Todos los scripts ejecutables sin errores.
- [ ] Capturas de resultados incluidas.
- [ ] Documentacion completa de objetivo y resultado de cada elemento.
- [ ] Revision final de todo el proyecto antes de defensa.

---

## Proximos Pasos

1. Copiar scripts a /sql/consultas.sql.
2. Actualizar estado a Completada en este README y en el README principal.
3. Commit: feat(fase6): add advanced SQL queries and triggers [FECHA]
4. Revision final de todo el repositorio.
5. Preparar defensa del TFG.

---

## Notas

- Esta es la fase mas compleja y la que mas peso tiene en la evaluacion.
- Cada consulta debe responder a un requerimiento real de FASE 1.
- El documento de trazabilidad requerimientos a consultas es clave para la defensa.
- Los triggers deben tener sentido en el contexto del dominio (no ser artificiales).