<div align="center">

# FASE 4 - Diseno Fisico en MySQL (Creacion de la Base de Datos)

[![Estado](https://img.shields.io/badge/Estado-Pendiente-red?style=for-the-badge)](./entregables)
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

- [ ] Script DDL completo y ejecutable en MySQL limpio sin errores
- [ ] Todas las tablas del esquema relacional (FASE 3) implementadas
- [ ] PKs y FKs correctamente definidas
- [ ] Restricciones de integridad aplicadas (NOT NULL, UNIQUE donde corresponda)
- [ ] Al menos un ALTER TABLE realizado, documentado y justificado
- [ ] Datos de prueba: minimo 5-10 registros por tabla principal
- [ ] Datos de prueba con variedad suficiente para FASE 5 y 6
- [ ] Script de datos ejecutable sin errores sobre el schema generado
- [ ] Capturas de phpMyAdmin incluidas
- [ ] Scripts copiados a `/sql/schema.sql` y `/sql/datos_prueba.sql`
- [ ] Documentacion fisica completada

---

## Cuando esta fase este lista...

1. Copia los scripts a `/sql/`
2. Cambia el badge a **Completada**
3. Commit: `feat(fase4): implement physical MySQL database with test data [FECHA]`
4. Pasa a la **FASE 5 - Explotacion Basica SQL**

---

> **Importante:** Los datos de prueba son la base de las dos fases siguientes. Dedica tiempo a que sean variados y realistas: distintos estados, distintos clientes, algunas incidencias, varios periodos de tiempo. Un conjunto de datos pobre hara que las consultas avanzadas de FASE 6 no tengan gracia.
