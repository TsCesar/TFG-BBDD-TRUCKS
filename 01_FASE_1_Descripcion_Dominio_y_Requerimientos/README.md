# ðŸ“‹ FASE 1 â€” Descripcion del Dominio y Requerimientos del Cliente

[![Estado](https://img.shields.io/badge/Estado-Pendiente-red?style=flat-square)](.)
[![Fase](https://img.shields.io/badge/Fase-1%20de%206-blue?style=flat-square)](.)
[![Dependencia](https://img.shields.io/badge/Dependencia-Ninguna-green?style=flat-square)](.)

---

## Por donde empezamos?

Todo proyecto de base de datos bien hecho empieza por entender el problema antes de tocar el teclado. En esta fase no se escribe una sola linea de SQL. Lo que se hace es escuchar, analizar y documentar:

- Que hace la empresa y como lo hace
- Que informacion necesita guardar y por que
- Quienes van a usar el sistema y para que lo van a usar
- Que debe poder hacer la base de datos (requerimientos funcionales)
- Que restricciones hay que respetar (requerimientos no funcionales)

El resultado de esta fase es el mapa que guia todo lo demas. Si aqui nos dejamos algo importante, lo pagaremos en fases posteriores.

---

## ðŸŽ¯ Objetivo de la fase

Elaborar una **descripcion detallada y estructurada** del dominio de la empresa de transporte, identificando toda la informacion que debera gestionar la base de datos y los requerimientos que esta debera satisfacer.

---

## ðŸ“ Que cubre esta fase (y que no)

âœ… **Si entra en esta fase:**
- Descripcion de la empresa, su actividad y su contexto
- Flujo operativo principal (como funciona un servicio de A a Z)
- Informacion que se necesita almacenar, organizada por areas
- Requerimientos funcionales numerados (RF-001, RF-002...)
- Requerimientos no funcionales numerados (RNF-001...)
- Identificacion narrativa de las entidades candidatas
- Acotacion del alcance (que entra y que queda fuera)

âŒ **No entra todavia:**
- Diagramas E/R (eso es FASE 2)
- Tablas ni columnas (eso es FASE 3)
- SQL de ningun tipo (eso es FASE 4 en adelante)

---

## ðŸ“¦ Entregables de esta fase

| Documento | Descripcion |
|---|---|
| `descripcion_dominio.md` | Descripcion completa de la empresa y su operativa |
| `requerimientos_cliente.md` | Lista estructurada de RF y RNF |
| `entidades_candidatas.md` | Identificacion narrativa de entidades y relaciones |
| `casos_de_uso.md` | Que hace cada departamento con la BD |

Todos van en la carpeta `entregables/` cuando esten validados.

---

## âœ… Checklist antes de cerrar la fase

- [ ] Descripcion general de la empresa (actividad, sector, paises de operacion)
- [ ] Ciclo de vida completo de un servicio documentado
- [ ] Informacion a almacenar identificada por area tematica
- [ ] Tabla de departamentos con su uso de la BD
- [ ] Requerimientos funcionales numerados y descritos (minimo 15)
- [ ] Requerimientos no funcionales numerados y descritos
- [ ] Entidades candidatas identificadas de forma narrativa
- [ ] Relaciones principales entre entidades descritas
- [ ] Alcance del proyecto acotado claramente
- [ ] Todo revisado y coherente con la propuesta original del TFG

---

## ðŸ“ Estructura interna de esta carpeta

```
01_FASE_1_Descripcion_Dominio_y_Requerimientos/
+-- README.md                <- Estas aqui
+-- documentacion/
|   +-- notas.md             <- Notas de trabajo, referencias, ideas
|   +-- TODO.md              <- Tareas pendientes
+-- borradores/              <- Versiones preliminares de los documentos
+-- entregables/             <- Documentos finales validados (vacios hasta desarrollar)
```

---

## â­ï¸ Cuando esta fase este lista...

1. Asegurate de que todos los entregables estan en `entregables/`
2. Marca el checklist completo
3. Cambia el badge de estado a **Completada** en este README
4. Haz commit: `docs(fase1): complete domain description and client requirements [FECHA]`
5. Pasa a la **FASE 2 â€” Modelo Conceptual**

---

> ðŸ’¡ **Consejo para la defensa:** El tribunal suele preguntar por los requerimientos funcionales y como cada consulta de FASE 6 los satisface. Un buen documento de requerimientos en esta fase hace que FASE 6 sea mucho mas facil de defender.