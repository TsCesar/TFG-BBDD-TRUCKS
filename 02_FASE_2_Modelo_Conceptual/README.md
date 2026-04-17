# ðŸ—ºï¸ FASE 2 â€” Modelo Conceptual (Diagrama Entidad-Relacion)

[![Estado](https://img.shields.io/badge/Estado-Pendiente-red?style=flat-square)](.)
[![Fase](https://img.shields.io/badge/Fase-2%20de%206-blue?style=flat-square)](.)
[![Dependencia](https://img.shields.io/badge/Requiere-FASE%201%20completada-orange?style=flat-square)](../01_FASE_1_Descripcion_Dominio_y_Requerimientos)

---

## De que va esta fase?

En FASE 1 describimos el problema en lenguaje natural. Ahora hay que traducirlo a **lenguaje de bases de datos**, pero todavia sin preocuparnos de como lo va a implementar MySQL.

El modelo conceptual â€”el diagrama Entidad-Relacion (E/R)â€” es el plano del edificio antes de que lleguen los albaniles. Si el plano esta mal, todo lo que se construya encima tambien estara mal.

En esta fase se define:
- **Que entidades** existen en el sistema (las "cosas" de las que hay que guardar informacion)
- **Que atributos** tiene cada entidad (sus caracteristicas)
- **Como se relacionan** las entidades entre si (con su cardinalidad y participacion)

---

## ðŸŽ¯ Objetivo de la fase

Producir un **diagrama E/R completo, correcto y justificado** que capture fielmente toda la informacion identificada en FASE 1, y que sirva de base solida para el modelo logico de FASE 3.

---

## ðŸ“ Que cubre esta fase (y que no)

âœ… **Si entra:**
- Identificacion formal de todas las entidades
- Definicion de atributos con tipo, significado y restricciones
- Marcado de claves primarias
- Definicion de relaciones con cardinalidad y participacion
- Diagrama E/R dibujado, limpio y exportado
- Justificacion de las decisiones de diseno

âŒ **No entra todavia:**
- Tablas relacionales (eso es FASE 3)
- Normalizacion (eso es FASE 3)
- SQL de ningun tipo (FASE 4 en adelante)

---

## ðŸ“¦ Entregables de esta fase

| Documento | Descripcion |
|---|---|
| `diagrama_ER.png` | El diagrama E/R completo, exportado en alta resolucion |
| `diccionario_entidades.md` | Ficha de cada entidad con todos sus atributos |
| `diccionario_relaciones.md` | Ficha de cada relacion con cardinalidad y participacion |
| `justificacion_modelo.md` | Por que se tomo cada decision importante del diseno |

---

## âœ… Checklist antes de cerrar la fase

- [ ] Todas las entidades de FASE 1 estan representadas
- [ ] Cada entidad tiene clave primaria identificada
- [ ] Todos los atributos relevantes estan definidos (nombre, tipo, descripcion)
- [ ] Todas las relaciones tienen nombre, cardinalidad y participacion
- [ ] No hay relaciones N:M sin analizar (habra que descomponerlas en FASE 3)
- [ ] Diagrama exportado en alta resolucion (PNG + PDF)
- [ ] Diagrama copiado a `/diagramas/modelo_conceptual.png`
- [ ] Diccionario de entidades completado
- [ ] Diccionario de relaciones completado
- [ ] Decisiones justificadas documentadas
- [ ] Coherencia con requerimientos de FASE 1 verificada

---

## â­ï¸ Cuando esta fase este lista...

1. Mueve el diagrama tambien a `/diagramas/modelo_conceptual.png`
2. Cambia el badge de estado a **Completada**
3. Commit: `docs(fase2): complete conceptual E/R model [FECHA]`
4. Pasa a la **FASE 3 â€” Modelo Logico y Normalizacion**

---

> ðŸ’¡ **Consejo:** Usa draw.io o diagrams.net. Exporta siempre en PNG con fondo blanco para que se vea bien en GitHub, y guarda tambien el archivo `.drawio` en `borradores/` por si necesitas editar.