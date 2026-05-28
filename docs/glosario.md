# Glosario del Proyecto

> Diccionario de terminos utilizados en este TFG, tanto del dominio de la empresa
> como tecnicos de bases de datos. Se amplia a medida que avanza el proyecto.

---

## Terminos del dominio - Empresa de Transporte

| Termino | Definicion |
|---|---|
| **Servicio** | Operacion de transporte encargada por un cliente: desde la recogida hasta la entrega. |
| **Envio** | A veces sinonimo de servicio; puede referirse a la mercancia especifica dentro de un servicio. |
| **Recogida** | Punto y momento en que se carga la mercancia en origen. |
| **Entrega** | Punto y momento en que se descarga la mercancia en destino. |
| **Ventana horaria** | Rango de tiempo en que el destinatario o remitente acepta la carga o descarga. |
| **Trazabilidad** | Capacidad de reconstruir el historial completo de un servicio. |
| **Incidencia** | Cualquier evento que afecte al desarrollo normal de un servicio (averia, demora, mercancia danada...). |
| **Flota** | Conjunto de vehiculos (camiones y remolques) de la empresa. |
| **FTL (Full Truck Load)** | Servicio de carga completa: un camion para un solo cliente. |
| **LTL (Less than Truck Load)** | Servicio de carga parcial: el camion lleva mercancia de varios clientes. |
| **CMR** | Carta de Porte Internacional por Carretera. Documento legal obligatorio en transporte intracomunitario. |
| **Cabeza tractora** | El camion propiamente dicho, sin contar el remolque. |
| **Semirremolque** | La parte trasera del vehiculo articulado donde va la carga. |
| **Intracomunitario** | Transporte entre paises miembros de la Union Europea. |
| **Coste operativo** | Gasto directamente asociado a la ejecucion de un servicio: combustible, peajes, dietas... |
| **Vigencia / Caducidad** | Fecha hasta la que un documento o certificacion es valido. |
| **Control interno** | Conjunto de registros y evidencias que permiten auditar la operativa. |

---

## Terminos tecnicos - Bases de Datos

| Termino | Definicion |
|---|---|
| **Entidad** | Objeto o concepto del mundo real sobre el que se guarda informacion. |
| **Atributo** | Propiedad o caracteristica de una entidad. |
| **Clave primaria (PK)** | Atributo que identifica de forma unica cada registro de una tabla. |
| **Clave foranea (FK)** | Atributo que referencia la PK de otra tabla, estableciendo una relacion. |
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
| **Trigger** | Bloque de codigo SQL que se ejecuta automaticamente ante un evento (INSERT/UPDATE/DELETE). |
| **Indice** | Estructura que acelera las busquedas sobre una columna. |
| **SGBD** | Sistema Gestor de Bases de Datos. En este proyecto: MySQL. |
| **phpMyAdmin** | Herramienta web para administrar bases de datos MySQL visualmente. |

---

---

## Nuevos terminos incorporados en la revision conceptual (2026-05-28)

| Termino | Definicion |
|---|---|
| **Categoria de permiso** | Habilitacion oficial para conducir un tipo de vehiculo. Las categorias relevantes en transporte de mercancias son C (camion rigido >3.5t), CE (vehiculo articulado = cabeza + remolque), C1 (vehiculo mediano), C1E (mediano con remolque), entre otras. |
| **CAP** | Certificado de Aptitud Profesional. Cualificacion obligatoria para conductores profesionales de mercancias o viajeros en la UE. Se renueva periodicamente. |
| **Relacion N:M** | Relacion muchos a muchos: un registro de A puede relacionarse con varios de B, y un registro de B puede relacionarse con varios de A. En el modelo E/R conceptual se representa con rombo. En el modelo logico se resuelve con tabla intermedia. |
| **Entidad asociativa** | Entidad que resuelve una relacion N:M y ademas tiene atributos propios. Se representa como rectangulo (no como rombo) en el diagrama E/R. Ejemplo: ASIGNACION. |
| **Entidad catalogo** | Entidad que almacena un conjunto estable de valores de referencia reutilizables. Ejemplo: CATEGORIA_PERMISO con los tipos de permiso homologados. |
| **Entidad transversal** | Entidad que registra operaciones sobre otras entidades sin tener FK directas. Ejemplo: REGISTRO_AUDITORIA. |
| **Participacion total** | Restriccion de participacion en la que todos los registros de una entidad deben participar en la relacion. Se representa con doble linea en el extremo del diagrama. |
| **Participacion parcial** | Restriccion de participacion en la que algunos registros de una entidad pueden no participar en la relacion. Se representa con linea simple (y a veces circulo). |
| **FTL** | Full Truck Load: el camion carga para un unico cliente; servicio de carga completa. |
| **LTL** | Less than Truck Load: el camion lleva mercancias de varios clientes o expedidores; servicio de carga parcial. |

*El glosario se amplia progresivamente. No anticipar terminos de fases no iniciadas.*
