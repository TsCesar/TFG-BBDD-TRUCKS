# ðŸ§  Decisiones de Diseno

> Registro vivo de las decisiones importantes tomadas a lo largo del proyecto.
> Si alguien lee este documento, deberia entender *por que* el diseno es como es.

---

## Como se usa este documento

Cada vez que se toma una decision relevante en cualquier fase â€”elegir un tipo de dato, dividir una entidad en dos, renombrar una tabla, anadir un indiceâ€” se registra aqui. El formato es simple:

| Campo | Descripcion |
|---|---|
| **ID** | Identificador unico (DD-001, DD-002...) |
| **Fase** | En que fase se tomo la decision |
| **Decision** | Que se decidio |
| **Alternativas** | Otras opciones que se consideraron |
| **Justificacion** | Por que se eligio esta opcion |
| **Impacto** | Que partes del proyecto afecta |

---

## Registro

### DD-001 â€” Eleccion del SGBD: MySQL + phpMyAdmin
- **Fase:** Propuesta inicial
- **Decision:** Usar MySQL 8.x con phpMyAdmin como entorno de trabajo.
- **Alternativas consideradas:** PostgreSQL (mas potente pero mas complejo), SQLite (demasiado simple para este dominio).
- **Justificacion:** MySQL es la herramienta trabajada durante el modulo. Facilita la evaluacion y la defensa ante el tribunal. phpMyAdmin proporciona capturas claras de la estructura y los resultados.
- **Impacto:** Todas las fases de implementacion (FASE 4, 5 y 6).

---

*(Proximas decisiones se anadiran aqui a medida que se desarrollen las fases)*