# FASE 1 - Descripcion del Dominio y Requerimientos del Cliente

Estado: Pendiente
Dependencia: ninguna - esta es la fase de arranque
Proyecto: TFG - Base de Datos Empresa de Transporte Intracomunitario (UE)

---

## Objetivo

Describir en detalle la actividad de la empresa, la informacion que se almacenara en la base de datos y el uso que haran de ella los distintos departamentos. Esta fase constituye la **base de todo el proyecto**: sin un dominio bien definido no es posible disenar un modelo coherente.

---

## Alcance

Esta fase cubre exclusivamente la descripcion y analisis del problema, sin entrar en diseno tecnico:

- Descripcion completa de la empresa y su actividad.
- Identificacion de la informacion que se necesita almacenar.
- Identificacion de los departamentos que usaran la BD y como.
- Listado de requerimientos funcionales del cliente (RF-001, RF-002...).
- Listado de requerimientos no funcionales (RNF-001...).
- Identificacion narrativa de entidades candidatas y relaciones principales.
- Acotacion del alcance del proyecto.

---

## Entregables

| Entregable | Descripcion | Ubicacion |
|---|---|---|
| descripcion_dominio.md | Descripcion detallada de la empresa y su actividad | entregables/ |
| requerimientos_cliente.md | Requerimientos funcionales y no funcionales | entregables/ |
| entidades_candidatas.md | Identificacion narrativa de entidades y relaciones | entregables/ |
| casos_de_uso.md | Operaciones principales por departamento | entregables/ |

---

## Estructura Interna

01_FASE_1_Descripcion_Dominio_y_Requerimientos/
+-- README.md
+-- documentacion/
|   +-- notas.md
|   +-- TODO.md
+-- borradores/
+-- entregables/

---

## Checklist

- [ ] Descripcion general de la empresa (actividad, sector, paises).
- [ ] Descripcion del flujo operativo principal (ciclo de vida de un servicio).
- [ ] Identificacion de la informacion a almacenar por area tematica.
- [ ] Tabla de departamentos implicados y su uso de la BD.
- [ ] Listado de requerimientos funcionales numerados (RF-001...).
- [ ] Listado de requerimientos no funcionales numerados (RNF-001...).
- [ ] Identificacion narrativa de entidades candidatas.
- [ ] Identificacion narrativa de relaciones principales entre entidades.
- [ ] Acotacion del alcance (que entra y que queda fuera del proyecto).
- [ ] Revision y validacion del contenido antes de pasar a FASE 2.

---

## Proximos Pasos

1. Completar todos los entregables en entregables/.
2. Marcar el checklist como completado.
3. Actualizar el estado a Completada.
4. Commit: docs(fase1): complete domain description and client requirements [FECHA]
5. Avanzar a FASE 2 - Modelo Conceptual.

---

## Notas

- No se escribe SQL en esta fase.
- No se crean diagramas formales (eso es FASE 2).
- La propuesta de TFG entregada al centro es el punto de partida, pero esta fase la desarrolla con mucho mayor detalle.