<div align="center">

# FASE 1 - Descripcion del Dominio y Requerimientos del Cliente

[![Estado](https://img.shields.io/badge/Estado-Completada-brightgreen?style=for-the-badge)](./entregables)
[![Fase](https://img.shields.io/badge/Fase-1%20de%206-blue?style=for-the-badge)](.)
[![Dependencia](https://img.shields.io/badge/Dependencia-Ninguna-brightgreen?style=for-the-badge)](.)

</div>

---

## Por donde empezamos?

Todo proyecto de base de datos bien hecho empieza por **entender el problema antes de tocar el teclado**. En esta fase no se escribe una sola linea de SQL. Lo que se hace es escuchar, analizar y documentar:

- Que hace la empresa y como lo hace
- Que informacion necesita guardar y por que
- Quienes van a usar el sistema y para que
- Que debe poder hacer la base de datos (requerimientos funcionales)
- Que restricciones hay que respetar (requerimientos no funcionales)

El resultado de esta fase es el **mapa que guia todo lo demas**. Si aqui nos dejamos algo importante, lo pagaremos en fases posteriores.

---

## Objetivo de la fase

Elaborar una descripcion detallada y estructurada del dominio de la empresa de transporte, identificando toda la informacion que debera gestionar la base de datos y los requerimientos que esta debera satisfacer.

---

## Que cubre esta fase?

**Entra en esta fase:**

- Descripcion de la empresa, su actividad y su contexto operativo
- Flujo operativo principal: ciclo de vida completo de un servicio
- Informacion que se necesita almacenar, organizada por areas tematicas
- Requerimientos funcionales numerados (RF-001, RF-002...)
- Requerimientos no funcionales numerados (RNF-001...)
- Identificacion narrativa de las entidades candidatas
- Acotacion del alcance del proyecto

**No entra todavia:**

- Diagramas E/R (eso es FASE 2)
- Tablas ni columnas (eso es FASE 3)
- SQL de ningun tipo (FASE 4 en adelante)

---

## Entregables

| Documento | Descripcion | Ubicacion |
|---|---|:---:|
| `descripcion_dominio.md` | Descripcion completa de la empresa y su operativa | `entregables/` |
| `requerimientos_cliente.md` | Lista estructurada de RF y RNF | `entregables/` |
| `entidades_candidatas.md` | Identificacion narrativa de entidades y relaciones | `entregables/` |
| `casos_de_uso.md` | Que hace cada departamento con la BD | `entregables/` |

---

## Estructura interna

```
01_FASE_1_Descripcion_Dominio_y_Requerimientos/
|
+-- README.md              <- Estas aqui
+-- documentacion/
|   +-- notas.md           <- Notas de trabajo, referencias, ideas
|   +-- TODO.md            <- Tareas pendientes
+-- borradores/            <- Versiones preliminares
+-- entregables/           <- Documentos finales validados
```

---

## Checklist de la fase

- [x] Descripcion general de la empresa (actividad, sector, paises de operacion)
- [x] Ciclo de vida completo de un servicio documentado
- [x] Informacion a almacenar identificada por area tematica
- [x] Tabla de departamentos con su uso de la BD
- [x] Requerimientos funcionales numerados y descritos (minimo 15)
- [x] Requerimientos no funcionales numerados y descritos
- [x] Entidades candidatas identificadas de forma narrativa
- [x] Relaciones principales entre entidades descritas
- [x] Alcance del proyecto acotado claramente
- [x] Todo revisado y coherente con la propuesta original del TFG

---

## Cuando esta fase este lista...

1. Asegurate de que todos los entregables estan en `entregables/`
2. Marca el checklist completo
3. Cambia el badge de **Pendiente** a **Completada**
4. Haz commit: `docs(fase1): complete domain description and client requirements [FECHA]`
5. Pasa a la **FASE 2 - Modelo Conceptual**

---

> **Consejo para la defensa:** El tribunal suele preguntar por los requerimientos funcionales y como cada consulta de FASE 6 los satisface. Un buen documento de requerimientos en esta fase hace que FASE 6 sea mucho mas facil de defender.
