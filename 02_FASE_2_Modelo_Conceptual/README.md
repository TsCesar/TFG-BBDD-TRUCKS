<div align="center">

# FASE 2 - Modelo Conceptual (Diagrama Entidad-Relacion)

[![Estado](https://img.shields.io/badge/Estado-Pendiente-red?style=for-the-badge)](./entregables)
[![Fase](https://img.shields.io/badge/Fase-2%20de%206-blue?style=for-the-badge)](.)
[![Requiere](https://img.shields.io/badge/Requiere-FASE%201%20completada-orange?style=for-the-badge)](../01_FASE_1_Descripcion_Dominio_y_Requerimientos)

</div>

---

## De que va esta fase?

En FASE 1 describimos el problema en lenguaje natural. Ahora hay que **traducirlo a lenguaje de bases de datos**, pero todavia sin preocuparnos de como lo va a implementar MySQL.

El modelo conceptual - el diagrama Entidad-Relacion (E/R) - es el plano del edificio antes de que lleguen los albaniles. Si el plano esta mal, todo lo que se construya encima tambien estara mal.

En esta fase se define:

- **Que entidades** existen en el sistema
- **Que atributos** tiene cada entidad (sus caracteristicas)
- **Como se relacionan** las entidades entre si (cardinalidad y participacion)

---

## Objetivo de la fase

Producir un **diagrama E/R completo, correcto y justificado** que capture fielmente toda la informacion identificada en FASE 1, y que sirva de base solida para el modelo logico de FASE 3.

---

## Que cubre esta fase?

**Entra en esta fase:**

- Identificacion formal de todas las entidades
- Definicion de atributos con tipo, significado y restricciones
- Marcado de claves primarias
- Definicion de relaciones con cardinalidad y participacion
- Diagrama E/R dibujado, limpio y exportado
- Justificacion de las decisiones de diseno

**No entra todavia:**

- Tablas relacionales (eso es FASE 3)
- Normalizacion (eso es FASE 3)
- SQL de ningun tipo (FASE 4 en adelante)

---

## Entregables

| Documento | Descripcion | Ubicacion |
|---|---|:---:|
| `diagrama_ER.png` | El diagrama E/R completo en alta resolucion | `entregables/` |
| `diccionario_entidades.md` | Ficha de cada entidad con todos sus atributos | `entregables/` |
| `diccionario_relaciones.md` | Ficha de cada relacion con cardinalidad y participacion | `entregables/` |
| `justificacion_modelo.md` | Por que se tomo cada decision importante del diseno | `entregables/` |

---

## Estructura interna

```
02_FASE_2_Modelo_Conceptual/
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

- [x] Todas las entidades de FASE 1 estan representadas
- [x] Cada entidad tiene clave primaria identificada
- [x] Todos los atributos relevantes estan definidos (nombre, tipo, descripcion)
- [x] Todas las relaciones tienen nombre, cardinalidad y participacion
- [x] No hay relaciones N:M sin analizar (se descomponen en FASE 3)
- [x] Diagrama exportado en alta resolucion (PNG + PDF)
- [x] Diagrama copiado a `/diagramas/modelo_conceptual.png`
- [x] Diccionario de entidades completado
- [x] Diccionario de relaciones completado
- [x] Decisiones justificadas documentadas
- [x] Coherencia con requerimientos de FASE 1 verificada

---

## Cuando esta fase este lista...

1. Copia el diagrama a `/diagramas/modelo_conceptual.png`
2. Cambia el badge a **Completada**
3. Commit: `docs(fase2): complete conceptual E/R model [FECHA]`
4. Pasa a la **FASE 3 - Modelo Logico y Normalizacion**

---

> **Consejo:** Usa draw.io o diagrams.net. Exporta en PNG con fondo blanco y guarda tambien el archivo `.drawio` en `borradores/` por si necesitas editar.
