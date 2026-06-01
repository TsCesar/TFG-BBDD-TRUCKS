<div align="center">

# FASE 4 - Diseno Fisico en MySQL (Creacion de la Base de Datos)

[![Estado](https://img.shields.io/badge/Estado-En%20desarrollo-yellow?style=for-the-badge)](./entregables)
[![Fase](https://img.shields.io/badge/Fase-4%20de%206-blue?style=for-the-badge)](.)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Requiere](https://img.shields.io/badge/Requiere-FASE%203%20completada-orange?style=for-the-badge)](../03_FASE_3_Modelo_Logico_y_Normalizacion)

</div>

---

## De que va esta fase?

Hasta ahora todo ha sido documentacion. En esta fase **se abre phpMyAdmin y se construye la base de datos de verdad**.

Se crea la BD, se crean todas las tablas con sus columnas, tipos de datos y restricciones, se modifica la estructura con `ALTER TABLE`, y se carga una cantidad de datos de prueba suficiente para que las consultas de FASE 5 y FASE 6 tengan sentido.

Esta fase es el punto de inflexion del proyecto: el diseno se convierte en realidad.

---

## Objetivo de la fase

Implementar fisicamente en MySQL el esquema disenado en FASE 3, cargarlo con datos de prueba representativos, y documentar el proceso completo con los scripts SQL y las capturas necesarias.

---

## Que cubre esta fase?

**Entra en esta fase:**

- `CREATE DATABASE` y `CREATE TABLE` para todas las entidades
- Definicion fisica de PKs, FKs, indices y restricciones
- Al menos una modificacion estructural con `ALTER TABLE` (requisito del modulo)
- Insercion de datos de prueba suficientes y variados (`INSERT INTO`)
- Capturas de phpMyAdmin que demuestren la estructura creada
- Documentacion del script DDL y las decisiones fisicas

**No entra todavia:**

- Consultas de explotacion (FASE 5 y 6)
- Triggers (FASE 6)

---

## Entregables

| Script / Documento | Descripcion | Ubicacion |
|---|---|:---:|
| `schema.sql` | DDL completo: CREATE DATABASE + todas las CREATE TABLE | `entregables/` y `/sql/` |
| `datos_prueba.sql` | Script de carga: INSERT INTO para todas las tablas | `entregables/` y `/sql/` |
| `alter_table.sql` | Script de modificacion estructural con ALTER TABLE | `entregables/` |
| `capturas_phpmyadmin.md` | Capturas de la estructura en phpMyAdmin + descripcion | `entregables/` |
| `documentacion_fisica.md` | Justificacion de tipos de datos, indices y decisiones | `entregables/` |

---

## Estructura interna

```
04_FASE_4_Diseno_Fisico_MySQL/
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

**Actividad 1 -- Crear la base de datos del proyecto:**
- [x] CREATE DATABASE tfg_transporte_ue en schema.sql (script listo)
- [x] Ejecutar en MySQL/phpMyAdmin y verificar

**Actividad 2 -- Crear las tablas principales con sus campos:**
- [x] CREATE TABLE para las 20 tablas del esquema relacional de FASE 3
- [x] Tipos de dato MySQL definidos (INT, VARCHAR, DECIMAL, DATE, DATETIME, TINYINT, ENUM)
- [x] Script schema.sql ejecutado sin errores en MySQL/phpMyAdmin

**Actividad 3 -- Relacionar las tablas entre si:**
- [x] FKs definidas con REFERENCES y ON DELETE / ON UPDATE segun caso
- [x] Integridad referencial verificada tras la carga del schema

**Actividad 4 -- Anadir restricciones basicas para controlar mejor los datos:**
- [x] NOT NULL donde corresponda
- [x] UNIQUE en columnas que lo requieren (cif_nif, matricula x2, numero_permiso, numero_factura, etc.)
- [x] DEFAULT values en todos los campos que lo requieren
- [x] CHECK para restriccion de DOCUMENTO_RECURSO (exactamente una FK NOT NULL)

**Actividad 5 -- Realizar alguna modificacion de estructura mediante ALTER TABLE:**
- [x] ALTER TABLE 1: servicio.km_estimados anadido (nueva columna, justificada)
- [x] ALTER TABLE 2: indice compuesto factura(estado_cobro, fecha_vencimiento)
- [x] Script alter_table.sql creado y documentado
- [x] Scripts ejecutados en phpMyAdmin

**Actividad 6 -- Insertar datos de prueba:**
- [x] Datos de prueba: 5 clientes, 6 vehiculos, 4 remolques, 6 conductores, 8 servicios
- [x] 35 documentos de recurso con 8 caducados/proximos a vencer
- [x] Script datos_prueba.sql listo (respeta FKs, datos variados y realistas)
- [x] datos_prueba.sql ejecutado en phpMyAdmin sin errores

**Actividad 7 -- Probar los scripts en phpMyAdmin y guardar capturas:**
- [x] schema.sql ejecutado en phpMyAdmin sin errores
- [x] alter_table.sql ejecutado en phpMyAdmin sin errores
- [x] datos_prueba.sql ejecutado en phpMyAdmin sin errores
- [ ] Capturas de estructura de tablas y relaciones guardadas
- [x] Scripts copiados a /sql/ (schema.sql, alter_table.sql, datos_prueba.sql)
- [x] documentacion_fisica.md completada
- [x] capturas_phpmyadmin.md (plantilla lista, pendiente imagenes reales)

---

## Cuando esta fase este lista...

1. Copia los scripts a `/sql/`
2. Cambia el badge a **Completada**
3. Commit: `feat(fase4): implement physical MySQL database with test data [FECHA]`
4. Pasa a la **FASE 5 - Explotacion Basica SQL**

---

> **Importante:** Los datos de prueba son la base de las dos fases siguientes. Dedica tiempo a que sean variados y realistas: distintos estados, distintos clientes, algunas incidencias, varios periodos de tiempo. Un conjunto de datos pobre hara que las consultas avanzadas de FASE 6 no tengan gracia.
