<div align="center">

# ðŸš› TFG â€” Base de Datos para Empresa de Transporte Intracomunitario (UE)

[![Estado](https://img.shields.io/badge/Estado-En%20Desarrollo-yellow?style=for-the-badge&logo=github)](https://github.com/TsCesar/TFG-BBDD-TRUCKS)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Fase Actual](https://img.shields.io/badge/Fase%20Actual-FASE%201-blue?style=for-the-badge)](./01_FASE_1_Descripcion_Dominio_y_Requerimientos)
[![Modulo](https://img.shields.io/badge/Modulo-Proyecto%202%C2%BA%20DAM-orange?style=for-the-badge)](https://www.cmaleon.es)

**Diseno, creacion y explotacion de una base de datos relacional en MySQL**
para la gestion integral de una empresa de transporte internacional por carretera (UE)

*Centro FP Maria Auxiliadora Â· 2023-24 Â· Alumno: Cesar Mendez*

</div>

---

## ðŸ“– De que va este proyecto?

Imagina una empresa de transportes que coordina camiones por toda Europa usando hojas de calculo, correos y papeles sueltos. Pedidos duplicados, conductores asignados dos veces al mismo servicio, facturas sin cobrar que nadie recuerda... El caos tipico de cuando el negocio crece mas rapido que los sistemas.

Este TFG propone la solucion: **una base de datos relacional en MySQL** que centraliza toda la operativa â€”desde que un cliente pide un servicio hasta que se cobra la facturaâ€” pasando por la asignacion de vehiculos, el seguimiento de envios, el control de incidencias y la auditoria interna.

> El objetivo no es solo aprobar el modulo. El objetivo es disenar algo que **podria usarse de verdad**.

---

## ðŸŽ¯ Que resuelve exactamente?

| Problema real | Solucion en la BD |
|---|---|
| Clientes y direcciones duplicados | Entidades normalizadas con clave unica |
| Conductores o vehiculos con doble asignacion | Control de disponibilidad y restricciones de integridad |
| Sin historial del estado de un envio | Tabla de eventos con trazabilidad completa |
| Incidencias sin seguimiento | Modulo de incidencias con estado y resolucion |
| Costes invisibles por servicio | Imputacion de costes operativos a cada operacion |
| Facturas perdidas o sin cobrar | Modulo de facturacion y seguimiento de cobros |
| Documentacion que caduca sin avisar | Control de vigencias con fechas de caducidad |

---

## ðŸ¢ La empresa del proyecto

La empresa ficticia del TFG es una **operadora logistica de transporte internacional por carretera** que opera dentro de la Union Europea. Trabaja con empresas industriales, operadores logisticos y distribuidores que necesitan mover mercancia â€”paletizada, a granel, carga completa o parcialâ€” entre distintos paises.

Su dia a dia implica:
- Coordinar recogidas y entregas con ventanas horarias estrictas
- Gestionar una flota de camiones y remolques con disponibilidad variable
- Controlar conductores con distintas licencias y disponibilidades
- Mantener documentacion legal y operativa actualizada (cartas de porte, CMR, etc.)
- Responder ante incidencias con trazabilidad demostrable

---

## ðŸ› ï¸ Stack tecnologico

| Herramienta | Rol en el proyecto |
|---|---|
| **MySQL 8.x** | SGBD principal â€” donde vive todo |
| **phpMyAdmin** | Interfaz grafica para administrar y explotar la BD |
| **SQL** | DDL, DML y consultas (el corazon del TFG) |
| **draw.io** | Diagramas E/R y modelo logico |
| **GitHub** | Control de versiones, documentacion y entrega |

---

## ðŸ“Š Progreso del proyecto

| # | Fase | Contenido | Estado |
|---|---|---|---|
| 1 | ðŸ“‹ Descripcion del dominio | Empresa, requerimientos, entidades candidatas | ðŸ”´ Pendiente |
| 2 | ðŸ—ºï¸ Modelo conceptual | Diagrama E/R completo | ðŸ”´ Pendiente |
| 3 | ðŸ“ Modelo logico | Esquema relacional + normalizacion 3FN | ðŸ”´ Pendiente |
| 4 | ðŸ—ï¸ Diseno fisico | CREATE TABLE, ALTER, datos de prueba | ðŸ”´ Pendiente |
| 5 | âš™ï¸ Explotacion basica | INSERT, UPDATE, DELETE + consultas simples | ðŸ”´ Pendiente |
| 6 | ðŸš€ Explotacion avanzada | JOINs, funciones, triggers | ðŸ”´ Pendiente |

---

## ðŸ“ Estructura del repositorio

```
TFG-BBDD-TRUCKS/
|
+-- README.md                    <- Estas aqui
+-- .gitignore
+-- LICENSE
|
+-- 01_FASE_1_.../               <- Una carpeta por cada fase
|   +-- README.md                <- Objetivo, alcance, checklist, estado
|   +-- documentacion/           <- Notas de trabajo y decisiones
|   +-- borradores/              <- Versiones intermedias
|   +-- entregables/             <- Documentos finales validados
|
+-- [02 a 06 igual estructura]
|
+-- docs/
|   +-- decisiones_diseno.md     <- Por que se tomo cada decision importante
|   +-- glosario.md              <- Terminos del dominio y tecnicos
|
+-- sql/
|   +-- schema.sql               <- DDL completo (FASE 4)
|   +-- datos_prueba.sql         <- Datos de prueba (FASE 4)
|   +-- consultas.sql            <- Consultas y scripts (FASE 5 y 6)
|
+-- diagramas/
|   +-- modelo_conceptual.png    <- Diagrama E/R (FASE 2)
|   +-- modelo_logico.png        <- Modelo relacional (FASE 3)
|
+-- datos_prueba/                <- Datos adicionales si los hay
+-- anexos/                      <- Documentacion de apoyo
```

---

## ðŸ”„ Como se trabaja en este proyecto

La regla principal es sencilla: **una fase a la vez, y no se avanza sin terminar la anterior**.

Cada fase tiene su propia carpeta con un README que explica exactamente que hay que hacer, un checklist para no olvidarse de nada, y una carpeta de entregables donde va el resultado final. Los borradores y las notas de trabajo tienen su propio espacio para que el repositorio refleje el proceso real, no solo el resultado.

Los commits siguen el formato:
```
tipo(scope): descripcion [YYYY-MM-DD HH:MM]
```

Por ejemplo: `feat(fase4): add CREATE TABLE scripts for all entities [2026-04-20 18:30]`

---

## ðŸ“¦ Contenido de la base de datos (previsto)

La BD cubrira estas areas funcionales:

- **Clientes y contactos** â€” quien encarga los servicios y donde se comunica con ellos
- **Servicios y envios** â€” el corazon: cada operacion de transporte, con origen, destino y seguimiento
- **Mercancia** â€” que se transporta y si tiene requisitos especiales
- **Recursos** â€” vehiculos, remolques y conductores con sus disponibilidades
- **Incidencias** â€” cualquier cosa que salga mal, como se gestiona y como se cierra
- **Costes operativos** â€” combustible, peajes, mantenimiento imputados por operacion
- **Facturacion** â€” lo que se cobra, a quien y si esta pagado
- **Control interno** â€” documentacion, vigencias y auditoria

---

## ðŸ‘¥ Quien usa la base de datos

| Departamento | Para que la usa |
|---|---|
| ðŸš¦ Operaciones / Trafico | Planificar servicios, asignar recursos, gestionar incidencias |
| ðŸ“ž Atencion al cliente | Consultar estado e historial de cualquier envio en segundos |
| ðŸ”§ Flota / Mantenimiento | Ver disponibilidad de vehiculos, registrar mantenimientos |
| ðŸ’° Finanzas | Facturar servicios, controlar cobros, analizar rentabilidad |
| ðŸ‘¤ RR. HH. | Informacion operativa de conductores |
| âœ… Cumplimiento / Calidad | Auditar documentacion, controlar caducidades |

---

<div align="center">

*Proyecto desarrollado fase a fase â€” cada commit cuenta una parte de la historia*

[![GitHub](https://img.shields.io/badge/Ver%20en-GitHub-181717?style=for-the-badge&logo=github)](https://github.com/TsCesar/TFG-BBDD-TRUCKS)

</div>