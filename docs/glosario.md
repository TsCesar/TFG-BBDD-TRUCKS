# ðŸ“š Glosario del Proyecto

> Diccionario de terminos utilizados en este TFG, tanto del dominio de la empresa
> como tecnicos de bases de datos. Se amplia a medida que avanza el proyecto.

---

## Terminos del dominio â€” Empresa de Transporte

| Termino | Definicion |
|---|---|
| **Servicio** | Operacion de transporte encargada por un cliente: desde la recogida hasta la entrega. |
| **Envio** | A veces sinonimo de servicio; puede referirse a la mercancia especifica dentro de un servicio. |
| **Recogida** | Punto y momento en que se carga la mercancia en origen. |
| **Entrega** | Punto y momento en que se descarga la mercancia en destino. |
| **Ventana horaria** | Rango de tiempo en que el destinatario o remitente acepta la carga o descarga. |
| **Trazabilidad** | Capacidad de reconstruir el historial completo de un servicio: donde estaba, cuando y en que estado. |
| **Incidencia** | Cualquier evento que afecte al desarrollo normal de un servicio (averia, demora, mercancia danada...). |
| **Flota** | Conjunto de vehiculos (camiones y remolques) propiedad o gestion de la empresa. |
| **FTL (Full Truck Load)** | Servicio de carga completa: un camion para un solo cliente. |
| **LTL (Less than Truck Load)** | Servicio de carga parcial: el camion lleva mercancia de varios clientes. |
| **CMR** | Carta de Porte Internacional por Carretera. Documento legal obligatorio en transporte intracomunitario. |
| **Cabeza tractora** | El camion propiamente dicho, sin contar el remolque. |
| **Semirremolque** | La parte trasera del vehiculo articulado donde va la carga. |
| **Intracomunitario** | Transporte entre paises miembros de la Union Europea. |
| **Coste operativo** | Gasto directamente asociado a la ejecucion de un servicio: combustible, peajes, dietas... |
| **Vigencia / Caducidad** | Fecha hasta la que un documento o certificacion es valido. |
| **Control interno** | Conjunto de registros y evidencias que permiten auditar que se han seguido los procedimientos correctos. |

---

## Terminos tecnicos â€” Bases de Datos

| Termino | Definicion |
|---|---|
| **Entidad** | Objeto o concepto del mundo real sobre el que se guarda informacion. |
| **Atributo** | Propiedad o caracteristica de una entidad. |
| **Clave primaria (PK)** | Atributo (o conjunto de atributos) que identifica de forma unica cada registro de una tabla. |
| **Clave foranea (FK)** | Atributo que referencia la PK de otra tabla, estableciendo una relacion entre ambas. |
| **Cardinalidad** | Cuantos registros de una entidad se relacionan con cuantos de otra: 1:1, 1:N, N:M. |
| **Normalizacion** | Proceso para organizar las tablas de forma que se eliminen redundancias y anomalias. |
| **1FN** | Primera Forma Normal: todos los atributos son atomicos; no hay grupos repetidos. |
| **2FN** | Segunda Forma Normal: cumple 1FN y no hay dependencias parciales de la PK. |
| **3FN** | Tercera Forma Normal: cumple 2FN y no hay dependencias transitivas. |
| **DDL** | Data Definition Language: CREATE, ALTER, DROP. Define la estructura de la BD. |
| **DML** | Data Manipulation Language: INSERT, UPDATE, DELETE. Manipula los datos. |
| **DQL** | Data Query Language: SELECT. Consulta los datos. |
| **INNER JOIN** | Combina filas de dos tablas que tienen correspondencia en la condicion de union. |
| **LEFT JOIN** | Devuelve todas las filas de la tabla izquierda, con o sin correspondencia en la derecha. |
| **Subconsulta** | Una SELECT dentro de otra SELECT, usada como dato o condicion. |
| **Trigger** | Bloque de codigo SQL que se ejecuta automaticamente cuando ocurre un evento (INSERT/UPDATE/DELETE). |
| **Indice** | Estructura que acelera las busquedas sobre una columna. Tiene coste en escritura. |
| **SGBD** | Sistema Gestor de Bases de Datos. En este proyecto: MySQL. |
| **phpMyAdmin** | Herramienta web para administrar bases de datos MySQL visualmente. |