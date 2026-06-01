# TODO -- FASE 4

> Referencia: RA2 TFG DAM Listado Fase3 y 4 CesarMendez.pdf (en /anexos)
> FASE 4 cerrada el 2026-06-01. Todas las actividades completadas.

## Tareas (todas completadas)

**Actividad 1 -- Crear la base de datos del proyecto:**
- [x] CREATE DATABASE tfg_transporte_ue en schema.sql -- SCRIPT LISTO
- [x] Ejecutar en MySQL/phpMyAdmin y verificar

**Actividad 2 -- Crear las tablas principales con sus campos:**
- [x] Tipos de dato MySQL definidos para las 20 tablas -- SCRIPT LISTO (schema.sql)
- [x] CREATE TABLE en orden correcto (respetando FKs)
- [x] Ejecutar schema.sql en phpMyAdmin sin errores -- 20 tablas creadas

**Actividad 3 -- Relacionar las tablas entre si:**
- [x] FOREIGN KEY con REFERENCES definidas en schema.sql
- [x] ON DELETE y ON UPDATE decididos y documentados en documentacion_fisica.md
- [x] Verificar integridad referencial tras ejecutar schema en phpMyAdmin

**Actividad 4 -- Anadir restricciones basicas:**
- [x] NOT NULL en columnas obligatorias
- [x] UNIQUE: cif_nif, matricula (x2), numero_empleado, numero_permiso, numero_servicio, numero_factura, codigo_categoria
- [x] DEFAULT: activo, es_principal, activa, nivel_urgencia, estado_actual, documentacion_completa, estado, prioridad, es_activa, estado_cobro, etc.
- [x] CHECK en documento_recurso: exactamente una FK NOT NULL (implementado en schema.sql)

**Actividad 5 -- Modificacion de estructura mediante ALTER TABLE:**
- [x] ALTER TABLE 1: servicio.km_estimados INT UNSIGNED NULL (nueva columna)
- [x] ALTER TABLE 2: indice compuesto factura(estado_cobro, fecha_vencimiento)
- [x] Script alter_table.sql creado y justificado en documentacion_fisica.md
- [x] Ejecutar alter_table.sql en phpMyAdmin

**Actividad 6 -- Insertar datos de prueba:**
- [x] Script datos_prueba.sql creado con datos realistas para transporte EU
- [x] 5 clientes (ES, DE, FR, PL, IT), 6 vehiculos, 4 remolques, 6 conductores
- [x] 8 servicios (FTL, LTL, Especial; varios estados), 4 facturas
- [x] 35 documentos de recurso (incluye 8 caducados o proximos a vencer)
- [x] Datos respetan orden de FK y son suficientes para FASE 5 y FASE 6
- [x] Ejecutar datos_prueba.sql en phpMyAdmin sin errores

**Actividad 7 -- Probar en phpMyAdmin y guardar capturas:**
- [x] schema.sql ejecutado sin errores -- 20 tablas creadas
- [x] alter_table.sql ejecutado sin errores -- km_estimados e indice aplicados
- [x] datos_prueba.sql ejecutado sin errores -- datos cargados y verificados
- [x] Capturas obtenidas (10 capturas en borradores/, enlazadas en capturas_phpmyadmin.md)
- [x] documentacion_fisica.md redactada
- [x] capturas_phpmyadmin.md (10 capturas reales enlazadas)
- [x] Scripts copiados a /sql/ (schema.sql, datos_prueba.sql, alter_table.sql)
- [x] Badge de FASE 4 cambiado a "Completada"
- [x] Commit de cierre de FASE 4 -- docs(fase4): close physical MySQL implementation phase

## Notas

Scripts entregables listos en:
- 04_FASE_4_Diseno_Fisico_MySQL/entregables/schema.sql
- 04_FASE_4_Diseno_Fisico_MySQL/entregables/alter_table.sql
- 04_FASE_4_Diseno_Fisico_MySQL/entregables/datos_prueba.sql
- 04_FASE_4_Diseno_Fisico_MySQL/entregables/documentacion_fisica.md
- 04_FASE_4_Diseno_Fisico_MySQL/entregables/capturas_phpmyadmin.md

Copias en: sql/schema.sql, sql/alter_table.sql, sql/datos_prueba.sql

FASE 4 cerrada el 2026-06-01. Siguiente fase: FASE 5 -- Explotacion Basica SQL.
