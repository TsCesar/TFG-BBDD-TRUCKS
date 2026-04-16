# Glosario del Proyecto

Definicion de los terminos tecnicos y de dominio utilizados en este TFG.
Se actualiza en cada fase.

---

## Terminos de dominio (empresa de transporte)

| Termino | Definicion |
|---|---|
| Servicio / Envio | Operacion de transporte desde un origen hasta un destino, encargada por un cliente. |
| Recogida | Punto y accion de recoger la mercancia en origen. |
| Entrega | Punto y accion de entregar la mercancia en destino. |
| Ventana horaria | Rango de tiempo disponible para realizar una recogida o entrega. |
| Trazabilidad | Capacidad de reconstruir el historial completo de un servicio (estados, eventos, incidencias). |
| Incidencia | Cualquier evento no planificado que afecte a la ejecucion normal de un servicio. |
| Flota | Conjunto de vehiculos (camiones y remolques) de la empresa. |
| Conductor | Persona que opera un vehiculo de la flota. |
| Coste operativo | Gasto directo asociado a la ejecucion de un servicio (combustible, peajes, mantenimiento). |
| Facturacion | Proceso de emitir facturas a los clientes por los servicios prestados. |
| Control interno | Conjunto de registros, documentacion y evidencias que permiten auditar la operativa. |
| Caducidad / Vigencia | Fecha limite de validez de un documento o requisito operativo. |
| Carga completa (FTL) | Servicio en que un camion transporta mercancia de un solo cliente. |
| Carga parcial (LTL) | Servicio en que un camion transporta mercancia de varios clientes. |
| Intracomunitario | Relativo al transporte entre paises miembros de la Union Europea. |

---

## Terminos tecnicos (bases de datos)

| Termino | Definicion |
|---|---|
| Entidad | Objeto del mundo real del que se almacena informacion. |
| Atributo | Propiedad o caracteristica de una entidad. |
| Clave primaria (PK) | Atributo o conjunto de atributos que identifica univocamente cada fila de una tabla. |
| Clave foranea (FK) | Atributo que referencia la PK de otra tabla, estableciendo una relacion. |
| Cardinalidad | Numero de instancias de una entidad que se relacionan con instancias de otra (1:1, 1:N, N:M). |
| Normalizacion | Proceso de organizacion de tablas para eliminar redundancias y dependencias problematicas. |
| 1FN | Primera Forma Normal: todos los atributos son atomicos; no hay grupos repetidos. |
| 2FN | Segunda Forma Normal: en 1FN y sin dependencias parciales de la PK. |
| 3FN | Tercera Forma Normal: en 2FN y sin dependencias transitivas. |
| DDL | Data Definition Language: sentencias SQL para definir estructura (CREATE, ALTER, DROP). |
| DML | Data Manipulation Language: sentencias SQL para manipular datos (INSERT, UPDATE, DELETE). |
| DQL | Data Query Language: sentencias SQL para consultar datos (SELECT). |
| Trigger | Procedimiento almacenado que se ejecuta automaticamente ante un evento en la BD. |
| JOIN | Operacion SQL que combina filas de dos o mas tablas basandose en una condicion. |
| Subconsulta | Consulta SQL anidada dentro de otra consulta. |
| SGBD | Sistema Gestor de Bases de Datos (en este proyecto: MySQL). |

---

NOTA: Este glosario se amplia progresivamente. No anticipar terminos de fases no iniciadas.