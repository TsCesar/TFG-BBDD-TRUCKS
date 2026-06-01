<div align="center">

# FASE 3 - Modelo Logico y Normalizacion (Esquema Relacional)

[![Estado](https://img.shields.io/badge/Estado-En%20revisi%C3%B3n-orange?style=for-the-badge)](./entregables)
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

> Actividades segun RA2 TFG DAM Listado Fase3 y 4 CesarMendez.pdf (en /anexos)

> Existen borradores en `entregables/` para todas las actividades. Pendiente: revision formal contra el listado oficial y exportacion del diagrama PNG.

**Actividad 1 -- Transformar cada entidad en una tabla:**
- [ ] Las 19 entidades de FASE 2 transformadas en tablas logicas
- [ ] Tabla intermedia CONDUCTOR_CATEGORIA_PERMISO creada para la relacion N:M R-21
- [ ] Total: 20 tablas documentadas en esquema_relacional.md

**Actividad 2 -- Definir los campos principales de cada tabla:**
- [ ] Columnas definidas con tipo logico, longitud recomendada y descripcion
- [ ] Restricciones logicas indicadas (NOT NULL, UNIQUE, DEFAULT, enumerados)

**Actividad 3 -- Indicar claves primarias y claves foraneas:**
- [ ] PKs identificadas en todas las tablas (entero autoincrementable en 19; compuesta en CONDUCTOR_CATEGORIA_PERMISO)
- [ ] FKs identificadas y dirigidas segun las 21 relaciones de FASE 2
- [ ] Nullable / NOT NULL indicado para cada FK segun participacion

**Actividad 4 -- Resolver relaciones muchos a muchos si aparecen:**
- [ ] R-21 POSEE_CATEGORIA (CONDUCTOR N:M CATEGORIA_PERMISO) resuelta con tabla CONDUCTOR_CATEGORIA_PERMISO
- [ ] Justificacion documentada en analisis_normalizacion.md y en diagrama_logico_textual.md

**Actividad 5 -- Revisar que la informacion no este repetida sin necesidad:**
- [ ] Datos de CLIENTE no se repiten en SERVICIO (se accede por FK id_cliente)
- [ ] Datos de CONDUCTOR, VEHICULO y REMOLQUE no se repiten en ASIGNACION (solo FKs)
- [ ] Analisis de redundancias documentado en analisis_normalizacion.md

**Actividad 6 -- Comprobar que el diseno este organizado hasta tercera forma normal:**
- [ ] Analisis 1FN completado para las 20 tablas
- [ ] Analisis 2FN completado (unica tabla con PK compuesta: CONDUCTOR_CATEGORIA_PERMISO)
- [ ] Analisis 3FN completado; excepcion justificada en FACTURA.importe_total
- [ ] Conclusiones documentadas en analisis_normalizacion.md

**Entregables adicionales:**
- [ ] Datos de ejemplo representativos (3-5 filas por tabla; SRV-2026-0003 LTL con 2 lotes de mercancia)
- [ ] Diagrama logico textual como guia para dibujar en draw.io (diagrama_logico_textual.md)
- [ ] Diagrama logico exportado y copiado a `/diagramas/modelo_logico.png`

**Verificacion final:**
- [ ] Revision de coherencia total contra el nuevo listado (RA2 TFG DAM Listado Fase3 y 4 CesarMendez.pdf)
- [ ] Badge cambiado a Completada y commit de cierre

---

## Cuando esta fase este lista...

1. Copia el diagrama a `/diagramas/modelo_logico.png`
2. Cambia el badge a **Completada**
3. Commit: `docs(fase3): complete logical model and normalization to 3NF [FECHA]`
4. Pasa a la **FASE 4 - Diseno Fisico en MySQL**

---

> **Tip de normalizacion:** Si una columna puede derivarse de otra (por ejemplo, el nombre del cliente a partir de su ID), eso es una dependencia transitiva y viola 3FN. Hay que sacarla a su propia tabla.
