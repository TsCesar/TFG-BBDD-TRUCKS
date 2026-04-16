# FASE 2 - Modelo Conceptual (Diagrama Entidad-Relacion)

Estado: Pendiente
Dependencia: FASE 1 completada y validada
Proyecto: TFG - Base de Datos Empresa de Transporte Intracomunitario (UE)

---

## Objetivo

Elaborar el diseno preliminar (modelo conceptual) de la base de datos, recogiendo las entidades que formaran parte de ella y las relaciones entre dichas entidades, con todos sus atributos, especificando claves, tipos de datos, significado, formato y restricciones.

---

## Alcance

- Identificacion y definicion formal de todas las entidades del sistema.
- Definicion de atributos (nombre, tipo, significado, restricciones, clave primaria).
- Identificacion y definicion de todas las relaciones (cardinalidad, participacion, atributos de relacion si procede).
- Elaboracion del Diagrama E/R completo.
- Documentacion justificada de cada decision de diseno.

---

## Entregables

| Entregable | Descripcion | Ubicacion |
|---|---|---|
| diagrama_ER.png | Diagrama Entidad-Relacion completo | entregables/ |
| diccionario_entidades.md | Definicion formal de entidades y atributos | entregables/ |
| diccionario_relaciones.md | Definicion formal de relaciones y cardinalidades | entregables/ |
| justificacion_modelo.md | Justificacion de las decisiones de diseno | entregables/ |

---

## Checklist

- [ ] Listado completo de entidades identificadas en FASE 1.
- [ ] Definicion de atributos para cada entidad (nombre, tipo, PK, restricciones).
- [ ] Definicion de relaciones (nombre, entidades implicadas, cardinalidad, participacion).
- [ ] Diagrama E/R elaborado y exportado en alta resolucion.
- [ ] Diccionario de entidades completado.
- [ ] Diccionario de relaciones completado.
- [ ] Justificacion de decisiones relevantes documentada.
- [ ] Coherencia con los requerimientos de FASE 1 verificada.
- [ ] Revision y validacion antes de pasar a FASE 3.

---

## Proximos Pasos

1. Mover el diagrama E/R tambien a /diagramas/modelo_conceptual.png.
2. Actualizar estado a Completada.
3. Commit: docs(fase2): complete conceptual model ER diagram [FECHA]
4. Avanzar a FASE 3 - Modelo Logico y Normalizacion.

---

## Notas

- No se escribe SQL en esta fase.
- El diagrama debe poder defenderse ante el tribunal explicando cada decision.
- Herramienta recomendada: draw.io / diagrams.net (exportar a PNG y PDF).