# Diccionario de Relaciones

**Proyecto:** Diseno, creacion y explotacion de una base de datos para la gestion integral
de una empresa de transporte intracomunitario por carretera (UE) en MySQL (phpMyAdmin)
**Fase:** 2 - Modelo Conceptual
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora - Curso 2023-24

---

## Convenciones de cardinalidad y participacion

- **1:N** = un registro de A se relaciona con varios de B; cada B se relaciona con uno de A
- **1:1** = un registro de A se relaciona con exactamente un registro de B y viceversa
- **Participacion total** = todos los registros de la entidad participan obligatoriamente
- **Participacion parcial** = algunos registros pueden no participar en la relacion

---

## R-01 -- TIENE_CONTACTO

| Campo | Valor |
|---|---|
| **Entidades** | CLIENTE (1) -- CONTACTO (N) |
| **Descripcion** | Un cliente puede tener uno o varios contactos asociados. Cada contacto pertenece a exactamente un cliente. |
| **Cardinalidad** | 1:N |
| **Participacion CLIENTE** | Parcial -- puede existir un cliente sin contactos registrados todavia |
| **Participacion CONTACTO** | Total -- todo contacto debe pertenecer a un cliente |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | Los clientes corporativos tienen multiples interlocutores segun el area (logistica, compras, administracion). Mantenerlos en entidad separada evita repetir los datos del cliente. Cubre RF-002. |

---

## R-02 -- TIENE_DIRECCION

| Campo | Valor |
|---|---|
| **Entidades** | CLIENTE (1) -- DIRECCION_OPERATIVA (N) |
| **Descripcion** | Un cliente puede tener una o varias direcciones operativas registradas. Cada direccion pertenece a exactamente un cliente. |
| **Cardinalidad** | 1:N |
| **Participacion CLIENTE** | Parcial -- puede existir un cliente sin direcciones operativas registradas todavia |
| **Participacion DIRECCION_OPERATIVA** | Total -- toda direccion operativa debe pertenecer a un cliente |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | Los clientes con varias instalaciones (almacenes, plantas, delegaciones) necesitan tener sus ubicaciones operativas registradas para que los agentes de trafico las reutilicen al crear puntos de servicio. Cubre RF-003. |

---

## R-03 -- CONTRATA

| Campo | Valor |
|---|---|
| **Entidades** | CLIENTE (1) -- SERVICIO (N) |
| **Descripcion** | Un cliente puede contratar varios servicios de transporte a lo largo del tiempo. Cada servicio es contratado por exactamente un cliente. |
| **Cardinalidad** | 1:N |
| **Participacion CLIENTE** | Parcial -- puede existir un cliente registrado sin servicios todavia |
| **Participacion SERVICIO** | Total -- todo servicio debe estar vinculado a un cliente |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | Relacion nuclear del modelo. Sin ella no es posible la facturacion, la atencion al cliente ni el analisis comercial. Cubre RF-004. |

---

## R-04 -- EMITIDA_A

| Campo | Valor |
|---|---|
| **Entidades** | CLIENTE (1) -- FACTURA (N) |
| **Descripcion** | Un cliente puede tener varias facturas emitidas a su nombre. Cada factura esta emitida a exactamente un cliente. |
| **Cardinalidad** | 1:N |
| **Participacion CLIENTE** | Parcial -- puede existir un cliente sin facturas emitidas todavia |
| **Participacion FACTURA** | Total -- toda factura debe estar emitida a un cliente |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | Necesaria para el control financiero: permite consultar facturacion total por cliente, saldos pendientes e historial de cobros. Cubre RF-023 y RF-025. |

---

## R-05 -- SE_FACTURA_EN

| Campo | Valor |
|---|---|
| **Entidades** | FACTURA (1) -- SERVICIO (N) |
| **Descripcion** | Una factura puede agrupar varios servicios completados del mismo cliente. Cada servicio puede estar incluido en una unica factura o en ninguna si aun no ha sido facturado. |
| **Cardinalidad** | 1:N |
| **Participacion FACTURA** | Total -- toda factura debe tener al menos un servicio asociado |
| **Participacion SERVICIO** | Parcial -- un servicio puede no estar facturado todavia |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | En el sector es habitual emitir una factura que agrupa todos los servicios de un cliente en un periodo (semanal, quincenal, mensual). Cubre RF-023 y RF-025. |

---

## R-06 -- TIENE_PUNTO

| Campo | Valor |
|---|---|
| **Entidades** | SERVICIO (1) -- PUNTO_SERVICIO (N) |
| **Descripcion** | Un servicio tiene uno o varios puntos de parada (recogidas y entregas). Cada punto pertenece a exactamente un servicio. |
| **Cardinalidad** | 1:N |
| **Participacion SERVICIO** | Total -- todo servicio debe tener al menos un punto de recogida y uno de entrega |
| **Participacion PUNTO_SERVICIO** | Total -- todo punto pertenece a un servicio |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | Los servicios multipunto son habituales en LTL y en operaciones con varias entregas. Separar los puntos permite gestionarlos individualmente con ventanas horarias y estados propios. Cubre RF-005. |

---

## R-07 -- REFERENCIA_DIRECCION

| Campo | Valor |
|---|---|
| **Entidades** | PUNTO_SERVICIO (N) -- DIRECCION_OPERATIVA (1) |
| **Descripcion** | Un punto de servicio puede referenciar opcionalmente una direccion operativa registrada del cliente (cuando el punto coincide con una instalacion habitual). |
| **Cardinalidad** | N:1 |
| **Participacion PUNTO_SERVICIO** | Parcial -- un punto puede no coincidir con ninguna direccion registrada (punto ad hoc) |
| **Participacion DIRECCION_OPERATIVA** | Parcial -- una direccion puede no estar referenciada en ningun punto activo |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | Cuando el punto de un servicio coincide con una instalacion habitual del cliente ya registrada, se puede reutilizar esa informacion en lugar de teclearla de nuevo, mejorando la consistencia. |

---

## R-08 -- TIENE_EVENTO

| Campo | Valor |
|---|---|
| **Entidades** | SERVICIO (1) -- EVENTO_SEGUIMIENTO (N) |
| **Descripcion** | Cada servicio tiene un historial de eventos de seguimiento que registra cronologicamente su evolucion. |
| **Cardinalidad** | 1:N |
| **Participacion SERVICIO** | Total -- todo servicio debe tener al menos el evento de creacion |
| **Participacion EVENTO_SEGUIMIENTO** | Total -- todo evento pertenece a un servicio |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | La trazabilidad del ciclo de vida del servicio es un requisito central de la propuesta. EVENTO_SEGUIMIENTO registra el historial completo: estados, confirmaciones, hitos operativos y responsables. Cubre RF-010. |

---

## R-09 -- DESCRIBE_CARGA

| Campo | Valor |
|---|---|
| **Entidades** | SERVICIO (1) -- MERCANCIA (1) |
| **Descripcion** | Cada servicio tiene asociada una descripcion de la carga que se transporta. |
| **Cardinalidad** | 1:1 |
| **Participacion SERVICIO** | Total -- todo servicio debe tener una descripcion de mercancia |
| **Participacion MERCANCIA** | Total -- toda descripcion de carga pertenece a un servicio |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | La descripcion fisica de la carga (tipo, peso, volumen, valor) se mantiene en una entidad separada del SERVICIO para no sobrecargar la entidad central y para tener claridad en el modelo. La propuesta incluye explicitamente la mercancia como area de contenido. Cubre RF-007. |

---

## R-10 -- TIENE_REQUISITO

| Campo | Valor |
|---|---|
| **Entidades** | SERVICIO (1) -- REQUISITO_ESPECIAL (N) |
| **Descripcion** | Un servicio puede tener cero o varios requisitos operativos especiales. Cada requisito esta vinculado a exactamente un servicio. |
| **Cardinalidad** | 1:N |
| **Participacion SERVICIO** | Parcial -- la mayoria de servicios no tienen requisitos especiales |
| **Participacion REQUISITO_ESPECIAL** | Total -- todo requisito especial debe estar vinculado a un servicio |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | La propuesta contempla explicitamente los requisitos operativos especiales (temperatura, manipulacion, seguros, restricciones) como parte del alcance de la base de datos. Mantener una entidad independiente permite registrar varios requisitos de tipos distintos para el mismo servicio. Cubre RF-008. |

---

## R-11 -- GENERA_INCIDENCIA

| Campo | Valor |
|---|---|
| **Entidades** | SERVICIO (1) -- INCIDENCIA (N) |
| **Descripcion** | Un servicio puede generar cero o varias incidencias durante su ejecucion. Cada incidencia esta vinculada a exactamente un servicio. |
| **Cardinalidad** | 1:N |
| **Participacion SERVICIO** | Parcial -- la mayoria de servicios se ejecutan sin incidencias |
| **Participacion INCIDENCIA** | Total -- toda incidencia debe estar vinculada a un servicio |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | La trazabilidad de incidencias por servicio es esencial para la resolucion de reclamaciones y el analisis de calidad. La propuesta incluye explicitamente incidencias con registro, clasificacion, gestion y cierre. Cubre RF-018, RF-019 y RF-020. |

---

## R-12 -- GENERA_COSTE

| Campo | Valor |
|---|---|
| **Entidades** | SERVICIO (1) -- COSTE_OPERATIVO (N) |
| **Descripcion** | Un servicio puede generar cero o varios costes operativos directos. Cada coste esta imputado a exactamente un servicio. |
| **Cardinalidad** | 1:N |
| **Participacion SERVICIO** | Parcial -- puede haber servicios sin costes adicionales registrados todavia |
| **Participacion COSTE_OPERATIVO** | Total -- todo coste debe estar imputado a un servicio |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | La imputacion de costes por servicio es imprescindible para calcular la rentabilidad de cada operacion y relacionar ingresos con costes, como establece la propuesta. Cubre RF-021 y RF-022. |

---

## R-13 -- TIENE_DOCUMENTO

| Campo | Valor |
|---|---|
| **Entidades** | SERVICIO (1) -- DOCUMENTO_SERVICIO (N) |
| **Descripcion** | Un servicio puede tener uno o varios documentos vinculados (CMR, albaranes, evidencias). Cada documento pertenece a exactamente un servicio. |
| **Cardinalidad** | 1:N |
| **Participacion SERVICIO** | Parcial -- un servicio puede no tener todavia documentos archivados (pendiente de recepcion) |
| **Participacion DOCUMENTO_SERVICIO** | Total -- todo documento de servicio pertenece a un servicio |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | La propuesta incluye explicitamente la documentacion asociada a servicios y las evidencias como parte del control interno. Un servicio puede generar varios documentos de tipos distintos. Cubre RF-026. |

---

## R-14 -- TIENE_ASIGNACION

| Campo | Valor |
|---|---|
| **Entidades** | SERVICIO (1) -- ASIGNACION (N) |
| **Descripcion** | Un servicio puede tener una o varias asignaciones a lo largo de su vida (la activa y las historicas si hubo cambios de recursos). Cada asignacion pertenece a un servicio. |
| **Cardinalidad** | 1:N |
| **Participacion SERVICIO** | Parcial -- un servicio en estado Pendiente puede no tener asignacion todavia |
| **Participacion ASIGNACION** | Total -- toda asignacion pertenece a un servicio |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | ASIGNACION es la entidad que conecta un SERVICIO con sus recursos (conductor, vehiculo y remolque). Tener historial de asignaciones permite saber quien realizo el servicio incluso si hubo cambios. Cubre RF-016 y RF-017. |

---

## R-15 -- REALIZA

| Campo | Valor |
|---|---|
| **Entidades** | CONDUCTOR (1) -- ASIGNACION (N) |
| **Descripcion** | Un conductor puede estar o haber estado vinculado a varios servicios. Cada asignacion incluye exactamente un conductor. |
| **Cardinalidad** | 1:N |
| **Participacion CONDUCTOR** | Parcial -- puede existir un conductor disponible sin asignaciones activas |
| **Participacion ASIGNACION** | Total -- toda asignacion debe incluir un conductor |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | Necesaria para saber quien realizo cada servicio, controlar la disponibilidad del conductor y gestionar responsabilidades en caso de incidencia. Cubre RF-014, RF-015 y RF-016. |

---

## R-16 -- UTILIZA_VEHICULO

| Campo | Valor |
|---|---|
| **Entidades** | VEHICULO (1) -- ASIGNACION (N) |
| **Descripcion** | Un vehiculo puede estar o haber estado asignado a varios servicios. Cada asignacion utiliza exactamente un vehiculo. |
| **Cardinalidad** | 1:N |
| **Participacion VEHICULO** | Parcial -- puede existir un vehiculo disponible sin asignaciones activas |
| **Participacion ASIGNACION** | Total -- toda asignacion debe incluir un vehiculo |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | Imprescindible para controlar el uso de la flota, evitar dobles asignaciones y mantener el historial de servicios realizados con cada vehiculo. Cubre RF-012, RF-015 y RF-016. |

---

## R-17 -- UTILIZA_REMOLQUE

| Campo | Valor |
|---|---|
| **Entidades** | REMOLQUE (1) -- ASIGNACION (N) |
| **Descripcion** | Un remolque puede estar o haber estado asignado a varios servicios. Una asignacion puede incluir opcionalmente un remolque. |
| **Cardinalidad** | 1:N con participacion parcial en ASIGNACION |
| **Participacion REMOLQUE** | Parcial -- un remolque puede estar disponible sin asignaciones activas |
| **Participacion ASIGNACION** | Parcial -- una asignacion puede no requerir remolque (vehiculo rigido, servicio sin semirremolque) |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | El remolque es opcional en la asignacion porque los vehiculos rigidos no necesitan remolque. Su gestion independiente del vehiculo tractor permite combinarlos segun las necesidades de cada servicio. Cubre RF-013, RF-015 y RF-016. |

---

## R-18 -- DOCUMENTA_VEHICULO

| Campo | Valor |
|---|---|
| **Entidades** | VEHICULO (1) -- DOCUMENTO_RECURSO (N) |
| **Descripcion** | Un vehiculo puede tener varios documentos con fecha de caducidad. |
| **Cardinalidad** | 1:N |
| **Participacion VEHICULO** | Parcial -- modelado mediante FK opcional en DOCUMENTO_RECURSO |
| **Participacion DOCUMENTO_RECURSO** | Total (cuando el documento es de vehiculo) |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | Cada vehiculo tiene al menos seguro, ITV y calibracion de tacografo, cada uno con caducidad propia. El control de caducidades de vehiculos es critico para el cumplimiento legal y la operativa diaria. Cubre RF-027 y RF-028. |

---

## R-19 -- DOCUMENTA_REMOLQUE

| Campo | Valor |
|---|---|
| **Entidades** | REMOLQUE (1) -- DOCUMENTO_RECURSO (N) |
| **Descripcion** | Un remolque puede tener varios documentos con fecha de caducidad. |
| **Cardinalidad** | 1:N |
| **Participacion REMOLQUE** | Parcial -- modelado mediante FK opcional en DOCUMENTO_RECURSO |
| **Participacion DOCUMENTO_RECURSO** | Total (cuando el documento es de remolque) |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | Los remolques tienen documentacion propia independiente del tractor: seguro propio, ITV propia, autorizaciones especiales. La gestion independiente es necesaria porque el remolque puede cambiar de cabeza tractora. Cubre RF-027 y RF-028. |

---

## R-20 -- DOCUMENTA_CONDUCTOR

| Campo | Valor |
|---|---|
| **Entidades** | CONDUCTOR (1) -- DOCUMENTO_RECURSO (N) |
| **Descripcion** | Un conductor puede tener varios documentos habilitantes con fecha de caducidad. |
| **Cardinalidad** | 1:N |
| **Participacion CONDUCTOR** | Parcial -- modelado mediante FK opcional en DOCUMENTO_RECURSO |
| **Participacion DOCUMENTO_RECURSO** | Total (cuando el documento es de conductor) |
| **Atributos de la relacion** | Ninguno |
| **Justificacion** | Cada conductor tiene permiso de conducir, tarjeta CAP y tarjeta de tacografo, cada uno con su propia caducidad. Su vencimiento inhabilita al conductor para el transporte internacional, haciendo el control de caducidades critico para el cumplimiento legal. Cubre RF-027 y RF-028. |

---

## Resumen de relaciones

| Cod | Nombre | Entidades | Cardinalidad |
|:---:|---|---|:---:|
| R-01 | TIENE_CONTACTO | CLIENTE -- CONTACTO | 1:N |
| R-02 | TIENE_DIRECCION | CLIENTE -- DIRECCION_OPERATIVA | 1:N |
| R-03 | CONTRATA | CLIENTE -- SERVICIO | 1:N |
| R-04 | EMITIDA_A | CLIENTE -- FACTURA | 1:N |
| R-05 | SE_FACTURA_EN | FACTURA -- SERVICIO | 1:N |
| R-06 | TIENE_PUNTO | SERVICIO -- PUNTO_SERVICIO | 1:N |
| R-07 | REFERENCIA_DIRECCION | PUNTO_SERVICIO -- DIRECCION_OPERATIVA | N:1 (parcial) |
| R-08 | TIENE_EVENTO | SERVICIO -- EVENTO_SEGUIMIENTO | 1:N |
| R-09 | DESCRIBE_CARGA | SERVICIO -- MERCANCIA | 1:1 |
| R-10 | TIENE_REQUISITO | SERVICIO -- REQUISITO_ESPECIAL | 1:N |
| R-11 | GENERA_INCIDENCIA | SERVICIO -- INCIDENCIA | 1:N |
| R-12 | GENERA_COSTE | SERVICIO -- COSTE_OPERATIVO | 1:N |
| R-13 | TIENE_DOCUMENTO | SERVICIO -- DOCUMENTO_SERVICIO | 1:N |
| R-14 | TIENE_ASIGNACION | SERVICIO -- ASIGNACION | 1:N |
| R-15 | REALIZA | CONDUCTOR -- ASIGNACION | 1:N |
| R-16 | UTILIZA_VEHICULO | VEHICULO -- ASIGNACION | 1:N |
| R-17 | UTILIZA_REMOLQUE | REMOLQUE -- ASIGNACION | 1:N (parcial) |
| R-18 | DOCUMENTA_VEHICULO | VEHICULO -- DOCUMENTO_RECURSO | 1:N |
| R-19 | DOCUMENTA_REMOLQUE | REMOLQUE -- DOCUMENTO_RECURSO | 1:N |
| R-20 | DOCUMENTA_CONDUCTOR | CONDUCTOR -- DOCUMENTO_RECURSO | 1:N |