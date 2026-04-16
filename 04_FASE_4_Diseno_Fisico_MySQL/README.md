# FASE 4 - Diseno Fisico en MySQL (Creacion de la Base de Datos)

Estado: Pendiente
Dependencia: FASE 3 completada y validada
Proyecto: TFG - Base de Datos Empresa de Transporte Intracomunitario (UE)

---

## Objetivo

Crear la base de datos utilizando MySQL + phpMyAdmin, implementando el esquema disenado en FASE 3. Incluye la correccion de la estructura mediante SQL (ALTER TABLE), la carga de datos de prueba suficientes para las fases siguientes, y la documentacion del diseno fisico.

---

## Alcance

- Creacion de la base de datos y todas las tablas mediante DDL (CREATE DATABASE, CREATE TABLE).
- Definicion de claves primarias, foraneas, indices y restricciones fisicas.
- Modificacion de la estructura con ALTER TABLE (al menos una requerida por el modulo).
- Carga de datos de prueba representativos y suficientes (INSERT INTO).
- Documentacion: scripts SQL comentados y capturas de phpMyAdmin.

---

## Entregables

| Entregable | Descripcion | Ubicacion |
|---|---|---|
| schema.sql | Script DDL completo (CREATE DATABASE + CREATE TABLE) | entregables/ y /sql/schema.sql |
| datos_prueba.sql | Script INSERT INTO de datos de prueba | entregables/ y /sql/datos_prueba.sql |
| alter_table.sql | Script(s) ALTER TABLE aplicados a la estructura | entregables/ |
| capturas_phpmyadmin.md | Capturas de phpMyAdmin + descripcion | entregables/ |
| documentacion_fisica.md | Justificacion de tipos de datos, indices y decisiones fisicas | entregables/ |

---

## Checklist

- [ ] Script DDL completo y ejecutable sin errores.
- [ ] Todas las PKs y FKs implementadas correctamente.
- [ ] Al menos un ALTER TABLE documentado y justificado.
- [ ] Datos de prueba cargados (suficientes para FASE 5 y FASE 6).
- [ ] Script de datos de prueba ejecutable sin errores.
- [ ] Capturas de phpMyAdmin incluidas.
- [ ] Documentacion fisica completada.
- [ ] Scripts copiados a /sql/.
- [ ] Coherencia con FASE 3 verificada.
- [ ] Revision y validacion antes de pasar a FASE 5.

---

## Proximos Pasos

1. Copiar schema.sql y datos_prueba.sql a /sql/.
2. Actualizar estado a Completada.
3. Commit: feat(fase4): implement physical database schema and test data [FECHA]
4. Avanzar a FASE 5 - Explotacion Basica SQL.

---

## Notas

- Los datos de prueba deben ser suficientemente variados para cubrir todos los casos de FASE 5 y FASE 6.
- El script DDL debe poder ejecutarse en un MySQL limpio sin errores.
- Herramienta: MySQL 8.x + phpMyAdmin (entorno del centro/clase).