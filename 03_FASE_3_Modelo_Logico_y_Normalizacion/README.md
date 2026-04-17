# ðŸ“ FASE 3 â€” Modelo Logico y Normalizacion (Esquema Relacional)

[![Estado](https://img.shields.io/badge/Estado-Pendiente-red?style=flat-square)](.)
[![Fase](https://img.shields.io/badge/Fase-3%20de%206-blue?style=flat-square)](.)
[![Dependencia](https://img.shields.io/badge/Requiere-FASE%202%20completada-orange?style=flat-square)](../02_FASE_2_Modelo_Conceptual)

---

## De que va esta fase?

Tenemos el plano arquitectonico (FASE 2). Ahora hay que convertirlo en **planos de ingenieria** que MySQL pueda entender: tablas, columnas, claves primarias, claves foraneas y todas las restricciones necesarias.

Pero antes de escribir el primer CREATE TABLE, hay que asegurarse de que el diseno es solido. Para eso esta la **normalizacion**: un proceso sistematico que elimina redundancias, incoherencias y problemas de actualizacion de los datos.

En este TFG se normaliza hasta **Tercera Forma Normal (3FN)**, que es el estandar habitual en bases de datos de gestion.

---

## ðŸŽ¯ Objetivo de la fase

Transformar el modelo E/R de FASE 2 en un **esquema relacional completo**, normalizado hasta 3FN, documentado y listo para ser implementado fisicamente en MySQL en FASE 4.

---

## ðŸ“ Que cubre esta fase (y que no)

âœ… **Si entra:**
- Transformacion E/R -> Esquema relacional (reglas de transformacion documentadas)
- Analisis del nivel de normalizacion de cada tabla (1FN, 2FN, 3FN)
- Aplicacion de los cambios necesarios para alcanzar 3FN
- Esquema completo: nombre de tabla, columnas, tipos de datos, PKs, FKs, restricciones
- Datos de ejemplo en cada tabla (para demostrar que esta normalizada)
- Diagrama del modelo relacional

âŒ **No entra todavia:**
- Sentencias SQL reales (eso es FASE 4)
- Insercion de datos en MySQL (eso es FASE 4)

---

## ðŸ“¦ Entregables de esta fase

| Documento | Descripcion |
|---|---|
| `esquema_relacional.md` | Definicion completa de cada tabla: columnas, tipos, PKs, FKs |
| `analisis_normalizacion.md` | Analisis de 1FN/2FN/3FN y transformaciones aplicadas |
| `diagrama_logico.png` | Diagrama del modelo relacional con claves y relaciones |
| `tablas_con_datos_ejemplo.md` | Cada tabla con 3-5 filas de ejemplo para demostrar normalizacion |

---

## âœ… Checklist antes de cerrar la fase

- [ ] Transformacion E/R -> Relacional documentada paso a paso
- [ ] Todas las relaciones N:M descompuestas en tablas intermedias
- [ ] Analisis de 1FN completado para todas las tablas
- [ ] Analisis de 2FN completado (solo aplica si hay PK compuesta)
- [ ] Analisis de 3FN completado para todas las tablas
- [ ] Transformaciones de normalizacion aplicadas y documentadas
- [ ] Esquema relacional completo con tipos de datos apropiados
- [ ] PKs y FKs claramente identificadas en el esquema
- [ ] Restricciones adicionales documentadas (UNIQUE, NOT NULL, etc.)
- [ ] Diagrama logico exportado y copiado a `/diagramas/modelo_logico.png`
- [ ] Datos de ejemplo representativos incluidos
- [ ] Coherencia total con el modelo E/R de FASE 2

---

## â­ï¸ Cuando esta fase este lista...

1. Copia el diagrama logico a `/diagramas/modelo_logico.png`
2. Cambia el badge de estado a **Completada**
3. Commit: `docs(fase3): complete logical model and normalization to 3NF [FECHA]`
4. Pasa a la **FASE 4 â€” Diseno Fisico en MySQL**

---

> ðŸ’¡ **Tip de normalizacion:** Si una columna puede derivarse de otra (por ejemplo, el nombre del cliente a partir de su ID), eso es una dependencia transitiva y viola 3FN. Hay que sacarla a su propia tabla.