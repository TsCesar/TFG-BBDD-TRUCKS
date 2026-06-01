# TODO -- FASE 4

> Referencia: RA2 TFG DAM Listado Fase3 y 4 CesarMendez.pdf (en /anexos)
> FASE 4 no puede iniciarse hasta que FASE 3 este completada y verificada.

## Tareas pendientes

**Actividad 1 -- Crear la base de datos del proyecto:**
- [ ] Ejecutar CREATE DATABASE en MySQL/phpMyAdmin
- [ ] Verificar que la base de datos esta seleccionada y lista

**Actividad 2 -- Crear las tablas principales con sus campos:**
- [ ] Definir tipos de dato MySQL para cada columna del esquema relacional de FASE 3
- [ ] Escribir CREATE TABLE para las 20 tablas en el orden correcto (respetando FKs)
- [ ] Ejecutar schema.sql y verificar que no hay errores

**Actividad 3 -- Relacionar las tablas entre si:**
- [ ] Definir FOREIGN KEY con REFERENCES en cada tabla que tenga FK
- [ ] Decidir ON DELETE y ON UPDATE para cada FK segun el dominio
- [ ] Verificar integridad referencial tras ejecutar el schema

**Actividad 4 -- Anadir restricciones basicas para controlar mejor los datos:**
- [ ] NOT NULL en columnas obligatorias
- [ ] UNIQUE en columnas que lo requieren (cif_nif, matricula, numero_permiso, numero_factura, etc.)
- [ ] DEFAULT values donde aplique (activo, documentacion_completa, etc.)
- [ ] CHECK para DOCUMENTO_RECURSO: exactamente una de las tres FK debe ser NOT NULL

**Actividad 5 -- Realizar alguna modificacion de estructura mediante ALTER TABLE:**
- [ ] Planificar y justificar al menos un ALTER TABLE (anadir columna, modificar tipo, anadir restriccion)
- [ ] Escribir y ejecutar el script alter_table.sql
- [ ] Documentar la justificacion del cambio

**Actividad 6 -- Insertar datos de prueba:**
- [ ] Disenar datos de prueba de clientes, servicios, camiones, conductores, incidencias, costes, facturas y documentos
- [ ] Minimo 5-10 registros por tabla principal; datos variados y realistas
- [ ] Escribir script datos_prueba.sql con INSERT INTO en orden correcto (FKs primero)
- [ ] Ejecutar datos_prueba.sql y verificar integridad referencial

**Actividad 7 -- Probar los scripts en phpMyAdmin y guardar capturas:**
- [ ] Tomar capturas de la estructura de tablas en phpMyAdmin
- [ ] Tomar capturas de las relaciones (diagrama ER en phpMyAdmin si esta disponible)
- [ ] Tomar capturas de datos cargados en las tablas principales
- [ ] Redactar capturas_phpmyadmin.md con descripcion de cada captura
- [ ] Redactar documentacion_fisica.md con justificacion de tipos de dato y decisiones fisicas
- [ ] Copiar schema.sql a /sql/schema.sql
- [ ] Copiar datos_prueba.sql a /sql/datos_prueba.sql
- [ ] Validar checklist del README
- [ ] Commit: feat(fase4): implement physical MySQL database with test data [FECHA]

## Notas

FASE 4 pendiente. Sin contenido desarrollado.
No iniciar hasta que FASE 3 este cerrada (badge Completada, diagrama PNG exportado).
Ver docs/preparacion_fase3_fase4.md para el orden de trabajo recomendado.
