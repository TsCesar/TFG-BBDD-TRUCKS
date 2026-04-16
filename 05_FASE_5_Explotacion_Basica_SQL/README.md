# FASE 5 - Explotacion Basica de la Base de Datos (DML + Consultas Simples)

Estado: Pendiente
Dependencia: FASE 4 completada y validada
Proyecto: TFG - Base de Datos Empresa de Transporte Intracomunitario (UE)

---

## Objetivo

Demostrar la utilidad de la base de datos creando operaciones SQL que permitan manipular la informacion (insercion, actualizacion y eliminacion de datos) y construir consultas simples que respondan a necesidades operativas basicas de la empresa.

---

## Alcance

- Operaciones DML: INSERT INTO, UPDATE, DELETE con casos practicos reales del dominio.
- Consultas SELECT simples: con filtros (WHERE), ordenacion (ORDER BY), limitacion (LIMIT) y proyecciones.
- Documentacion de cada operacion: objetivo perseguido, SQL empleado y resultado obtenido.

---

## Entregables

| Entregable | Descripcion | Ubicacion |
|---|---|---|
| operaciones_dml.sql | Scripts INSERT, UPDATE y DELETE comentados y justificados | entregables/ |
| consultas_simples.sql | Consultas SELECT simples con documentacion | entregables/ |
| documentacion_fase5.md | Explicacion de cada operacion: objetivo y resultado | entregables/ |
| capturas_resultados.md | Capturas de resultados en phpMyAdmin | entregables/ |

---

## Checklist

- [ ] Minimo 3 operaciones INSERT INTO con justificacion.
- [ ] Minimo 3 operaciones UPDATE con justificacion.
- [ ] Minimo 2 operaciones DELETE con justificacion.
- [ ] Minimo 5 consultas SELECT simples cubriendo distintas tablas.
- [ ] Cada operacion con objetivo explicado y resultado documentado.
- [ ] Capturas de resultados incluidas.
- [ ] Scripts ejecutables sin errores sobre los datos de FASE 4.
- [ ] Revision y validacion antes de pasar a FASE 6.

---

## Proximos Pasos

1. Copiar scripts relevantes a /sql/consultas.sql.
2. Actualizar estado a Completada.
3. Commit: feat(fase5): add basic SQL exploitation scripts [FECHA]
4. Avanzar a FASE 6 - Explotacion Avanzada SQL.

---

## Notas

- Cada operacion debe tener sentido en el contexto real de la empresa.
- La documentacion del objetivo y resultado es obligatoria para la defensa.
- Gestionar el orden de ejecucion DML para no comprometer los datos de FASE 6.