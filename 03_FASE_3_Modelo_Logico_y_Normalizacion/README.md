<div align="center">

# FASE 3 - Modelo Logico y Normalizacion (Esquema Relacional)

[![Estado](https://img.shields.io/badge/Estado-Pendiente-red?style=for-the-badge)](./entregables)
[![Fase](https://img.shields.io/badge/Fase-3%20de%206-blue?style=for-the-badge)](.)
[![Requiere](https://img.shields.io/badge/Requiere-FASE%202%20completada-orange?style=for-the-badge)](../02_FASE_2_Modelo_Conceptual)

</div>

---

## De que va esta fase?

Tenemos el plano arquitectonico (FASE 2). Ahora hay que convertirlo en **planos de ingenieria** que MySQL pueda entender: tablas, columnas, claves primarias, claves foraneas y todas las restricciones necesarias.

Antes de escribir el primer `CREATE TABLE`, hay que asegurarse de que el diseno es solido. Para eso esta la **normalizacion**: un proceso sistematico que elimina redundancias, incoherencias y anomalias de actualizacion.

En este TFG se normaliza hasta **Tercera Forma Normal (3FN)**, que es el estandar habitual en bases de datos de gestion.

---

## Objetivo de la fase

Transformar el modelo E/R de FASE 2 en un **esquema relacional completo**, normalizado hasta 3FN, documentado y listo para ser implementado fisicamente en MySQL en FASE 4.

---

## Que cubre esta fase?

**Entra en esta fase:**

- Transformacion E/R a Esquema Relacional (reglas documentadas)
- Analisis del nivel de normalizacion de cada tabla (1FN, 2FN, 3FN)
- Aplicacion de los cambios necesarios para alcanzar 3FN
- Esquema completo: nombre de tabla, columnas, tipos de datos, PKs, FKs, restricciones
- Datos de ejemplo en cada tabla para demostrar la normalizacion
- Diagrama del modelo relacional

**No entra todavia:**

- Sentencias SQL reales (eso es FASE 4)
- Insercion de datos en MySQL (eso es FASE 4)

---

## Entregables

| Documento | Descripcion | Ubicacion |
|---|---|:---:|
| `esquema_relacional.md` | Definicion completa de cada tabla: columnas, tipos, PKs, FKs | `entregables/` |
| `analisis_normalizacion.md` | Analisis de 1FN/2FN/3FN y transformaciones aplicadas | `entregables/` |
| `diagrama_logico.png` | Diagrama del modelo relacional con claves y relaciones | `entregables/` |
| `tablas_con_datos_ejemplo.md` | Cada tabla con 3-5 filas de ejemplo | `entregables/` |

---

## Estructura interna

```
03_FASE_3_Modelo_Logico_y_Normalizacion/
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

- [x] Transformacion E/R a Relacional documentada paso a paso
- [x] Relaciones N:M analizadas: ASIGNACION resuelve las N:M implicitas de recursos
- [x] Analisis de 1FN completado para todas las tablas
- [x] Analisis de 2FN completado (aplica si hay PK compuesta)
- [x] Analisis de 3FN completado para todas las tablas
- [x] Transformaciones de normalizacion aplicadas y documentadas
- [x] Esquema relacional completo con tipos de datos logicos
- [x] PKs y FKs claramente identificadas
- [x] Restricciones adicionales documentadas (UNIQUE, NOT NULL...)
- [ ] Diagrama logico exportado y copiado a `/diagramas/modelo_logico.png`
- [x] Datos de ejemplo representativos incluidos
- [x] Coherencia total verificada con el modelo E/R de FASE 2 revisado (R-09 corregida a 1:N, CATEGORIA_PERMISO y CONDUCTOR_CATEGORIA_PERMISO integradas, R-21 N:M documentada)

---

## Cuando esta fase este lista...

1. Copia el diagrama a `/diagramas/modelo_logico.png`
2. Cambia el badge a **Completada**
3. Commit: `docs(fase3): complete logical model and normalization to 3NF [FECHA]`
4. Pasa a la **FASE 4 - Diseno Fisico en MySQL**

---

> **Tip de normalizacion:** Si una columna puede derivarse de otra (por ejemplo, el nombre del cliente a partir de su ID), eso es una dependencia transitiva y viola 3FN. Hay que sacarla a su propia tabla.
