<div align="center">

# TFG - Base de Datos para Empresa de Transporte Intracomunitario (UE)

[![Estado](https://img.shields.io/badge/Estado-En%20Desarrollo-yellow?style=for-the-badge)](https://github.com/TsCesar/TFG-BBDD-TRUCKS)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Fase Actual](https://img.shields.io/badge/Fase%20Actual-FASE%201-informational?style=for-the-badge)](./01_FASE_1_Descripcion_Dominio_y_Requerimientos)
[![Modulo](https://img.shields.io/badge/Modulo-Proyecto%202%C2%BA%20DAM-orange?style=for-the-badge)](https://www.cmaleon.es)

**Diseno, creacion y explotacion de una base de datos relacional en MySQL**
para la gestion integral de una empresa de transporte internacional por carretera (UE)

*Centro FP Maria Auxiliadora | Curso 2024-26 | Alumno: Cesar Mendez*

</div>

---

## De que va este proyecto?

Imagina una empresa de transportes que coordina camiones por toda Europa usando hojas de calculo, correos y papeles sueltos. Pedidos duplicados, conductores asignados dos veces al mismo servicio, facturas sin cobrar que nadie recuerda... El caos tipico de cuando el negocio crece mas rapido que los sistemas.

Este TFG propone la solucion: **una base de datos relacional en MySQL** que centraliza toda la operativa, desde que un cliente pide un servicio hasta que se cobra la factura, pasando por la asignacion de vehiculos, el seguimiento de envios, el control de incidencias y la auditoria interna.

> El objetivo no es solo aprobar el modulo. El objetivo es disenar algo que **podria usarse de verdad**.

---

## Que problemas resuelve?

| Problema real | Solucion en la base de datos |
|---|---|
| Clientes y direcciones duplicados | Entidades normalizadas con clave unica |
| Conductores o vehiculos con doble asignacion | Control de disponibilidad y restricciones de integridad |
| Sin historial del estado de un envio | Tabla de eventos con trazabilidad completa |
| Incidencias sin seguimiento | Modulo de incidencias con estado y resolucion |
| Costes invisibles por servicio | Imputacion de costes operativos a cada operacion |
| Facturas perdidas o sin cobrar | Modulo de facturacion y seguimiento de cobros |
| Documentacion que caduca sin avisar | Control de vigencias con fechas de caducidad |

---

## La empresa del proyecto

La empresa ficticia del TFG es una **operadora logistica de transporte internacional por carretera** que opera dentro de la Union Europea. Trabaja con empresas industriales, operadores logisticos y distribuidores que necesitan mover mercancia entre distintos paises, ya sea en carga completa (FTL) o parcial (LTL).

Su dia a dia implica:

- Coordinar recogidas y entregas con ventanas horarias estrictas
- Gestionar una flota de camiones y remolques con disponibilidad variable
- Controlar conductores con distintas licencias y disponibilidades
- Mantener documentacion legal y operativa actualizada (cartas de porte, CMR, etc.)
- Responder ante incidencias con trazabilidad demostrable

---

## Stack tecnologico

| Herramienta | Rol en el proyecto |
|---|---|
| **MySQL 8.x** | SGBD principal - donde vive toda la informacion |
| **phpMyAdmin** | Interfaz grafica para administrar y explotar la BD |
| **SQL** | DDL, DML y consultas (el corazon del TFG) |
| **draw.io** | Diagramas E/R y modelo logico |
| **GitHub** | Control de versiones, documentacion y entrega |

---

## Progreso del proyecto

| # | Fase | Contenido | Estado |
|:---:|---|---|:---:|
| 1 | [Descripcion del dominio](./01_FASE_1_Descripcion_Dominio_y_Requerimientos) | Empresa, requerimientos, entidades candidatas | ![Finalizada](https://img.shields.io/badge/-Pendiente-red?style=flat-square) |
| 2 | [Modelo conceptual](./02_FASE_2_Modelo_Conceptual) | Diagrama E/R completo | ![Pendiente](https://img.shields.io/badge/-Pendiente-red?style=flat-square) |
| 3 | [Modelo logico](./03_FASE_3_Modelo_Logico_y_Normalizacion) | Esquema relacional + normalizacion 3FN | ![Pendiente](https://img.shields.io/badge/-Pendiente-red?style=flat-square) |
| 4 | [Diseno fisico](./04_FASE_4_Diseno_Fisico_MySQL) | CREATE TABLE, ALTER, datos de prueba | ![Pendiente](https://img.shields.io/badge/-Pendiente-red?style=flat-square) |
| 5 | [Explotacion basica](./05_FASE_5_Explotacion_Basica_SQL) | INSERT, UPDATE, DELETE + consultas simples | ![Pendiente](https://img.shields.io/badge/-Pendiente-red?style=flat-square) |
| 6 | [Explotacion avanzada](./06_FASE_6_Explotacion_Avanzada_SQL) | JOINs, funciones, triggers | ![Pendiente](https://img.shields.io/badge/-Pendiente-red?style=flat-square) |

---

## Estructura del repositorio

```
TFG-BBDD-TRUCKS/
|
+-- README.md                      <- Estas aqui
+-- .gitignore / LICENSE
|
+-- 01_FASE_1_Descripcion_Dominio_y_Requerimientos/
+-- 02_FASE_2_Modelo_Conceptual/
+-- 03_FASE_3_Modelo_Logico_y_Normalizacion/
+-- 04_FASE_4_Diseno_Fisico_MySQL/
+-- 05_FASE_5_Explotacion_Basica_SQL/
+-- 06_FASE_6_Explotacion_Avanzada_SQL/
|     |
|     +-- README.md                <- Objetivo, alcance, checklist y estado
|     +-- documentacion/           <- Notas de trabajo
|     +-- borradores/              <- Versiones intermedias
|     +-- entregables/             <- Documentos finales validados
|
+-- docs/
|   +-- decisiones_diseno.md
|   +-- glosario.md
|
+-- sql/
|   +-- schema.sql                 <- DDL completo (FASE 4)
|   +-- datos_prueba.sql           <- Datos de prueba (FASE 4)
|   +-- consultas.sql              <- Consultas (FASE 5 y 6)
|
+-- diagramas/
|   +-- modelo_conceptual.png      <- Diagrama E/R (FASE 2)
|   +-- modelo_logico.png          <- Modelo relacional (FASE 3)
|
+-- datos_prueba/ / anexos/
```

---

## Metodologia de trabajo

La regla es sencilla: **una fase a la vez, y no se avanza sin terminar la anterior**.

Cada fase tiene su README con objetivo, alcance y checklist. Los commits siguen el formato:

```
tipo(scope): descripcion [YYYY-MM-DD HH:MM]
```

Ejemplo: `feat(fase4): add CREATE TABLE scripts for all entities [2026-04-20 18:30]`

---

## Contenido previsto de la base de datos

- **Clientes y contactos** - quienes encargan los servicios y donde contactarlos
- **Servicios y envios** - cada operacion de transporte con origen, destino y seguimiento
- **Mercancia** - que se transporta y si tiene requisitos especiales
- **Recursos** - vehiculos, remolques y conductores con sus disponibilidades
- **Incidencias** - cualquier evento que afecte al servicio y como se gestiona
- **Costes operativos** - combustible, peajes, mantenimiento imputados por servicio
- **Facturacion** - lo que se cobra, a quien y si esta pagado
- **Control interno** - documentacion, vigencias y auditoria

---

## Quien usa la base de datos?

| Departamento | Para que la usa |
|---|---|
| Operaciones / Trafico | Planificar servicios, asignar recursos, gestionar incidencias |
| Atencion al cliente | Consultar estado e historial de cualquier envio en segundos |
| Flota / Mantenimiento | Ver disponibilidad de vehiculos, registrar mantenimientos |
| Finanzas | Facturar servicios, controlar cobros, analizar rentabilidad |
| RR. HH. | Informacion operativa de conductores |
| Cumplimiento / Calidad | Auditar documentacion, controlar caducidades |

---

<div align="center">

*Proyecto desarrollado fase a fase - cada commit cuenta una parte de la historia*

</div>
