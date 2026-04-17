# ðŸ—ï¸ FASE 4 â€” Diseno Fisico en MySQL (Creacion de la Base de Datos)

[![Estado](https://img.shields.io/badge/Estado-Pendiente-red?style=flat-square)](.)
[![Fase](https://img.shields.io/badge/Fase-4%20de%206-blue?style=flat-square)](.)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=flat-square&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Dependencia](https://img.shields.io/badge/Requiere-FASE%203%20completada-orange?style=flat-square)](../03_FASE_3_Modelo_Logico_y_Normalizacion)

---

## De que va esta fase?

Hasta ahora todo ha sido papel (bueno, Markdown). En esta fase se abre phpMyAdmin y se construye la base de datos **de verdad**.

Se crea la BD, se crean todas las tablas con sus columnas, tipos de datos y restricciones, se modifica la estructura con ALTER TABLE para demostrar que sabemos hacerlo, y se carga una cantidad de datos de prueba suficiente para que las consultas de FASE 5 y FASE 6 tengan sentido.

Esta fase es el punto de inflexion del proyecto: el diseno se convierte en realidad.

---

## ðŸŽ¯ Objetivo de la fase

Implementar fisicamente en MySQL el esquema disenado en FASE 3, cargarlo con datos de prueba representativos, y documentar el proceso completo con los scripts SQL y las capturas necesarias.

---

## ðŸ“ Que cubre esta fase

âœ… **Si entra:**
- CREATE DATABASE y CREATE TABLE para todas las entidades
- Definicion fisica de PKs, FKs, indices y restricciones
- Al menos una modificacion estructural con ALTER TABLE (requisito del modulo)
- Insercion de datos de prueba suficientes y representativos (INSERT INTO)
- Capturas de phpMyAdmin que demuestren la estructura creada
- Documentacion del script DDL y las decisiones fisicas

âŒ **No entra todavia:**
- Consultas de explotacion (FASE 5 y 6)
- Triggers (FASE 6)

---

## ðŸ“¦ Entregables de esta fase

| Documento / Script | Descripcion |
|---|---|
| `schema.sql` | Script DDL completo: CREATE DATABASE + todas las CREATE TABLE |
| `datos_prueba.sql` | Script de carga de datos: INSERT INTO para todas las tablas |
| `alter_table.sql` | Script(s) de modificacion estructural con ALTER TABLE |
| `capturas_phpmyadmin.md` | Capturas de la estructura en phpMyAdmin + descripcion |
| `documentacion_fisica.md` | Justificacion de tipos de datos, indices y otras decisiones |

Los scripts `schema.sql` y `datos_prueba.sql` se copian tambien a `/sql/`.

---

## âœ… Checklist antes de cerrar la fase

- [ ] Script DDL completo y ejecutable en MySQL limpio sin errores
- [ ] Todas las tablas del esquema relacional (FASE 3) implementadas
- [ ] PKs y FKs correctamente definidas
- [ ] Restricciones de integridad aplicadas (NOT NULL, UNIQUE donde corresponda)
- [ ] Al menos un ALTER TABLE realizado, documentado y justificado
- [ ] Datos de prueba: minimo 5-10 registros por tabla principal
- [ ] Datos de prueba con variedad suficiente para las consultas de FASE 5 y 6
- [ ] Script de datos ejecutable sin errores sobre el schema generado
- [ ] Capturas de phpMyAdmin incluidas (estructura de tablas, diagrama ER de MySQL)
- [ ] Scripts copiados a `/sql/schema.sql` y `/sql/datos_prueba.sql`
- [ ] Documentacion fisica completada

---

## â­ï¸ Cuando esta fase este lista...

1. Copia los scripts a `/sql/`
2. Cambia el badge de estado a **Completada**
3. Commit: `feat(fase4): implement physical MySQL database with test data [FECHA]`
4. Pasa a la **FASE 5 â€” Explotacion Basica SQL**

---

> ðŸ’¡ **Importante:** Los datos de prueba son la base de las dos fases siguientes. Dedica tiempo a que sean variados y realistas: distintos estados, distintos clientes, algunas incidencias, varios periodos de tiempo. Un conjunto de datos pobre hara que las consultas avanzadas de FASE 6 no tengan gracia.