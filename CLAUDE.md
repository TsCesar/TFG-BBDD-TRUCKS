# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

TFG (Trabajo Final de Grado) for a 2nd-year DAM program at Centro FP María Auxiliadora (2024–26). The goal is to design and implement a relational MySQL database for an EU truck transport logistics company, progressing through 6 sequential phases.

**Stack:** MySQL 8.x + phpMyAdmin, SQL (DDL/DML/DQL), draw.io for diagrams, Markdown for documentation. No build system — this is a pure database design project.

## Running SQL

```bash
# Apply schema (FASE 4+)
mysql -u root -p < sql/schema.sql

# Load test data
mysql -u root -p < sql/datos_prueba.sql

# Run queries
mysql -u root -p < sql/consultas.sql
```

phpMyAdmin is available at `http://localhost/phpmyadmin` for GUI-based operations.

## Phase Structure

Each of the 6 phases has its own directory (`01_FASE_1_*/` through `06_FASE_6_*/`) with three subdirectories:
- `entregables/` — final validated deliverables
- `documentacion/` — working notes and TODOs
- `borradores/` — drafts and intermediate work

**Progress:** FASE 1 (requirements) and FASE 2 (ER conceptual model) are complete. FASE 3–6 are pending.

## Database Domain

18 core entities across 8 areas:
- **Clients & Third Parties:** `CLIENTE`, `CONTACTO`, `DIRECCION_OPERATIVA`
- **Transport Services:** `SERVICIO`, `PUNTO_RUTA`, `NIVEL_URGENCIA`
- **Fleet & Resources:** `VEHICULO`, `CONDUCTOR`
- **Cargo:** `MERCANCIA` (with special conditions and dangerous goods flags)
- **Incidents:** `INCIDENCIA`
- **Costs:** `COSTE_OPERATIVO`
- **Invoicing:** `FACTURA`
- **Compliance:** documentation validity and audit trail tables

Normalization target is 3NF. N:M relationships are decomposed into junction tables in FASE 3. PKs use auto-incrementing integers.

## Conventions

**Commit format:**
```
tipo(scope): descripcion [YYYY-MM-DD HH:MM]
```
Example: `docs(fase3): add normalization analysis to 3NF [2026-04-25 10:00]`

**Language:** All documentation, comments, and identifiers are in Spanish.

**Diagrams:** Exported as high-resolution PNG from draw.io, placed in `diagramas/` (project-wide) or the phase's `entregables/` folder.

**Design decisions** are logged in `docs/decisiones_diseno.md` using the DD-NNN format with fields: ID, Phase, Decision, Alternatives, Justification, Impact.
