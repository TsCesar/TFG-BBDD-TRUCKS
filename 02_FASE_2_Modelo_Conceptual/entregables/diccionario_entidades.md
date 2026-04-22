# Diccionario de Entidades

**Proyecto:** Diseno, creacion y explotacion de una base de datos para la gestion integral
de una empresa de transporte intracomunitario por carretera (UE) en MySQL (phpMyAdmin)
**Fase:** 2 - Modelo Conceptual
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora - Curso 2024-26

> Define formalmente las 18 entidades del modelo conceptual con atributos, clave primaria
> conceptual, tipo de dato conceptual, significado y restricciones.
> No incluye SQL ni tipos de dato fisicos de MySQL.

---

## Convenciones

- **PK** = Clave primaria conceptual
- **[oblig]** = Atributo obligatorio; no puede quedar sin valor
- **[unico]** = El valor no puede repetirse dentro de la entidad
- Tipos conceptuales: **Entero** | **Texto** | **Decimal** | **Fecha** | **FechaHora** | **Booleano** | **Enumerado**

---

## Area 1 -- Clientes y terceros

### 1. CLIENTE

**Descripcion:** Empresa o persona que contrata servicios de transporte. Actor externo
principal del sistema, origen de servicios y de facturas.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_cliente** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| nombre_razon_social | Texto | [oblig] | Nombre completo o razon social |
| cif_nif | Texto | [oblig], [unico] | Identificador fiscal |
| pais | Texto | [oblig] | Pais de registro o sede principal |
| ciudad | Texto | | Ciudad de la sede principal |
| direccion_sede | Texto | | Direccion postal de la sede principal |
| telefono | Texto | | Telefono de contacto principal |
| email | Texto | | Correo electronico de contacto principal |
| condiciones_pago | Texto | | Plazo y forma de pago acordados comercialmente |
| activo | Booleano | [oblig] | Indica si el cliente esta activo en el sistema |

---

### 2. CONTACTO

**Descripcion:** Persona fisica dentro de una empresa cliente con la que la operadora
se relaciona en el dia a dia. Un cliente puede tener varios contactos.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_contacto** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| nombre | Texto | [oblig] | Nombre del contacto |
| apellidos | Texto | [oblig] | Apellidos del contacto |
| cargo | Texto | | Cargo o puesto en la empresa cliente |
| telefono | Texto | | Telefono directo del contacto |
| email | Texto | | Correo electronico del contacto |
| es_principal | Booleano | [oblig] | Indica si es el contacto principal del cliente |

*Vinculacion: pertenece a un CLIENTE (relacion R-01)*

---

### 3. DIRECCION_OPERATIVA

**Descripcion:** Ubicacion fisica desde la que opera un cliente: almacenes, plantas,
delegaciones o centros de distribucion. Se usa como punto habitual de recogida o entrega.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_direccion** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| descripcion | Texto | | Nombre o denominacion de la instalacion |
| direccion | Texto | [oblig] | Calle, numero y codigo postal |
| ciudad | Texto | [oblig] | Ciudad de la instalacion |
| pais | Texto | [oblig] | Pais de la instalacion |
| telefono | Texto | | Telefono de contacto de la instalacion |
| horario | Texto | | Horario habitual de carga y descarga |
| activa | Booleano | [oblig] | Indica si la direccion esta operativa |

*Vinculacion: pertenece a un CLIENTE (relacion R-02)*

---

## Area 2 -- Servicios y seguimiento

### 4. SERVICIO

**Descripcion:** Entidad central del sistema. Cada operacion de transporte contratada,
desde la solicitud hasta su cierre y facturacion. Todo el modelo orbita en torno a ella.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_servicio** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| numero_servicio | Texto | [oblig], [unico] | Codigo interno legible (ej: SRV-2026-0001) |
| fecha_solicitud | Fecha | [oblig] | Fecha en que el cliente realiza el encargo |
| fecha_prevista_recogida | Fecha | [oblig] | Fecha planificada para la primera recogida |
| tipo_servicio | Enumerado | [oblig] | FTL / LTL / Especial |
| nivel_urgencia | Enumerado | [oblig] | Estandar / Urgente / Fecha_garantizada / Nocturno |
| estado_actual | Enumerado | [oblig] | Pendiente / Planificado / Asignado / En_transito / Entregado / Cerrado / Cancelado / Con_incidencia |
| documentacion_completa | Booleano | [oblig] | Indica si todos los documentos del servicio han sido recibidos y archivados |
| observaciones | Texto | | Notas adicionales sobre el encargo |

*Vinculaciones: pertenece a un CLIENTE (R-03); puede estar incluido en una FACTURA (R-05)*

---

### 5. PUNTO_SERVICIO

**Descripcion:** Cada parada individual dentro de un servicio: recogida o entrega.
Permite gestionar servicios multipunto con ventanas horarias independientes por parada.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_punto** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| tipo | Enumerado | [oblig] | Recogida / Entrega |
| orden | Entero | [oblig] | Posicion de esta parada dentro de la ruta del servicio |
| direccion | Texto | [oblig] | Calle, numero y codigo postal del punto |
| ciudad | Texto | [oblig] | Ciudad del punto |
| pais | Texto | [oblig] | Pais del punto |
| ventana_inicio | FechaHora | | Inicio de la ventana horaria acordada |
| ventana_fin | FechaHora | | Fin de la ventana horaria acordada |
| fecha_ejecucion_real | FechaHora | | Fecha y hora real de ejecucion (nulo hasta que ocurra) |
| estado | Enumerado | [oblig] | Pendiente / En_proceso / Completado / Fallido |
| observaciones | Texto | | Instrucciones de acceso, contacto local, restricciones |

*Vinculaciones: pertenece a un SERVICIO (R-06); puede referenciar una DIRECCION_OPERATIVA (R-07)*

---

### 6. EVENTO_SEGUIMIENTO

**Descripcion:** Registro cronologico de cada evento relevante en el ciclo de vida de un
servicio. Constituye el historial de trazabilidad: permite reconstruir en cualquier momento
la evolucion completa de un servicio con fecha, hora y responsable de cada evento.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_evento** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| tipo_evento | Enumerado | [oblig] | Servicio_creado / Planificado / Asignado / Recogida_completada / En_transito / Llegada_punto / Entrega_completada / Incidencia_registrada / Cerrado / Cancelado / Otro |
| descripcion | Texto | [oblig] | Descripcion del evento registrado |
| fecha_hora | FechaHora | [oblig] | Fecha y hora exacta del evento |
| estado_resultante | Enumerado | [oblig] | Estado del servicio tras este evento |
| usuario_responsable | Texto | [oblig] | Usuario que registro el evento |
| observaciones | Texto | | Informacion adicional sobre el evento |

*Vinculacion: pertenece a un SERVICIO (R-08)*

---

## Area 3 -- Mercancia y requisitos

### 7. MERCANCIA

**Descripcion:** Descripcion de la carga asociada a un servicio: caracteristicas fisicas,
tipo y valor declarado. Separada de SERVICIO para distinguir la informacion del encargo
operativo de la descripcion fisica de lo que se transporta.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_mercancia** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| descripcion | Texto | [oblig] | Descripcion general de la carga |
| tipo_carga | Enumerado | [oblig] | Paletizada / Bultos / Granel / Maquinaria / Piezas_especiales / Otro |
| num_bultos_palets | Entero | | Numero de bultos, palets o unidades |
| peso_kg | Decimal | | Peso total de la carga en kilogramos |
| volumen_m3 | Decimal | | Volumen total de la carga en metros cubicos |
| valor_declarado | Decimal | | Valor declarado de la carga en euros |
| observaciones | Texto | | Caracteristicas adicionales de la carga |

*Vinculacion: asociada a un SERVICIO (R-09)*

---

### 8. REQUISITO_ESPECIAL

**Descripcion:** Condicionante operativo especifico vinculado a un servicio: temperatura
controlada, manipulacion especial, seguros adicionales, restricciones de acceso u otras
condiciones particulares. Un servicio puede tener varios.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_requisito** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| tipo | Enumerado | [oblig] | Temperatura_controlada / Manipulacion_especial / Seguro_adicional / Restriccion_acceso / Documentacion_adicional / Otro |
| descripcion | Texto | [oblig] | Descripcion detallada del requisito |
| temperatura_min | Decimal | | Temperatura minima requerida en grados Celsius |
| temperatura_max | Decimal | | Temperatura maxima requerida en grados Celsius |
| instrucciones | Texto | | Instrucciones operativas para el conductor o el destinatario |
| verificacion_obligatoria | Booleano | [oblig] | Indica si el requisito debe ser verificado y acreditado documentalmente |

*Vinculacion: asociado a un SERVICIO (R-10)*

---

## Area 4 -- Incidencias

### 9. INCIDENCIA

**Descripcion:** Evento no planificado que afecta al desarrollo normal de un servicio.
Tiene su propio ciclo de vida con trazabilidad de cada cambio de estado: registro,
clasificacion, gestion y cierre, tal como exige la propuesta oficial.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_incidencia** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| tipo | Enumerado | [oblig] | Averia_vehiculo / Accidente / Demora_significativa / Mercancia_danada / Rechazo_entrega / Problema_documentacion / Problema_acceso / Otro |
| descripcion | Texto | [oblig] | Descripcion detallada del evento ocurrido |
| fecha_apertura | FechaHora | [oblig] | Fecha y hora de apertura de la incidencia |
| prioridad | Enumerado | [oblig] | Baja / Media / Alta / Critica |
| estado | Enumerado | [oblig] | Abierta / En_gestion / Resuelta / Cerrada |
| fecha_ultima_actualizacion | FechaHora | | Fecha y hora del ultimo cambio de estado |
| responsable_gestion | Texto | | Persona o departamento que gestiona la incidencia |
| fecha_cierre | FechaHora | | Fecha y hora de cierre (nulo mientras este abierta) |
| descripcion_resolucion | Texto | | Descripcion de la solucion adoptada |
| genera_coste_adicional | Booleano | [oblig] | Indica si la incidencia genero un coste extra imputable al servicio |

*Vinculacion: pertenece a un SERVICIO (R-11)*

---

## Area 5 -- Recursos

### 10. VEHICULO

**Descripcion:** Unidad de motor de la flota propia: cabeza tractora o vehiculo rigido.
Recurso clave de la operativa con estado de disponibilidad y documentacion propia.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_vehiculo** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| matricula | Texto | [oblig], [unico] | Matricula oficial del vehiculo |
| tipo | Enumerado | [oblig] | Cabeza_tractora / Rigido |
| marca | Texto | | Marca del fabricante |
| modelo | Texto | | Modelo especifico del vehiculo |
| anio_matriculacion | Entero | | Ano de matriculacion |
| capacidad_carga_kg | Decimal | | Capacidad maxima de carga en kilogramos |
| estado_operativo | Enumerado | [oblig] | Disponible / Asignado / Mantenimiento / Baja |

---

### 11. REMOLQUE

**Descripcion:** Elemento de carga acoplable a las cabezas tractoras. Gestion independiente
porque la combinacion tractora-remolque puede variar por servicio y cada uno tiene
documentacion y caducidades propias.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_remolque** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| matricula | Texto | [oblig], [unico] | Matricula oficial del remolque |
| tipo | Enumerado | [oblig] | Lona / Frigorifico / Cisterna / Portacoches / Caja_cerrada / Otro |
| capacidad_carga_kg | Decimal | | Capacidad maxima de carga en kilogramos |
| longitud_m | Decimal | | Longitud del remolque en metros |
| apto_temperatura | Booleano | | Indica si esta preparado para control de temperatura |
| estado_operativo | Enumerado | [oblig] | Disponible / Asignado / Mantenimiento / Baja |

---

### 12. CONDUCTOR

**Descripcion:** Conductor profesional de la plantilla. Se gestiona su disponibilidad,
documentacion habilitante con fechas de caducidad y vinculacion a los servicios realizados.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_conductor** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| numero_empleado | Texto | [oblig], [unico] | Numero de empleado interno de la empresa |
| nombre | Texto | [oblig] | Nombre del conductor |
| apellidos | Texto | [oblig] | Apellidos del conductor |
| fecha_nacimiento | Fecha | | Fecha de nacimiento |
| telefono | Texto | | Telefono de contacto del conductor |
| email | Texto | | Correo electronico del conductor |
| numero_permiso | Texto | [oblig], [unico] | Numero del permiso de conducir |
| categorias_permiso | Texto | [oblig] | Categorias habilitantes del permiso (C, CE, etc.) |
| estado_disponibilidad | Enumerado | [oblig] | Disponible / Asignado / Vacaciones / Baja_temporal / Baja_definitiva |

---

### 13. ASIGNACION

**Descripcion:** Entidad asociativa que formaliza la vinculacion de un conductor y un
vehiculo (y opcionalmente un remolque) a un servicio concreto. Tiene atributos propios
y puede existir historial de asignaciones por servicio cuando se cambian recursos.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_asignacion** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| fecha_asignacion | FechaHora | [oblig] | Fecha y hora en que se formalizo la asignacion |
| es_activa | Booleano | [oblig] | True: asignacion vigente; False: registro historico sustituido |
| motivo_cambio | Texto | | Motivo de reasignacion si esta sustituye a una anterior |
| observaciones | Texto | | Notas adicionales sobre la asignacion |

*Vinculaciones: id_servicio [oblig], id_conductor [oblig], id_vehiculo [oblig], id_remolque [opcional]*

---

## Area 6 -- Costes operativos

### 14. COSTE_OPERATIVO

**Descripcion:** Gasto directo imputable a un servicio especifico: combustible, peajes,
dietas, reparaciones urgentes, seguros adicionales, mantenimiento, etc. Permite calcular
la rentabilidad real de cada operacion.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_coste** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| tipo_coste | Enumerado | [oblig] | Combustible / Peajes / Dietas / Reparacion / Seguro_adicional / Mantenimiento / Otro |
| importe | Decimal | [oblig] | Importe del coste en euros |
| fecha | Fecha | [oblig] | Fecha en que se incurrio en el coste |
| descripcion | Texto | | Descripcion adicional del gasto |
| justificante_disponible | Booleano | [oblig] | Indica si se dispone de factura o justificante del gasto |

*Vinculacion: imputado a un SERVICIO (R-12)*

---

## Area 7 -- Facturacion y cobros

### 15. FACTURA

**Descripcion:** Documento de cobro emitido a un cliente por uno o varios servicios
completados. Tiene su propio ciclo de vida economico con seguimiento del cobro,
tal como contempla explicitamente la propuesta oficial.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_factura** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| numero_factura | Texto | [oblig], [unico] | Numero oficial de la factura (ej: FAC-2026-0001) |
| fecha_emision | Fecha | [oblig] | Fecha en que se emite la factura |
| fecha_vencimiento | Fecha | [oblig] | Fecha limite de pago segun condiciones del cliente |
| importe_base | Decimal | [oblig] | Importe sin impuestos en euros |
| porcentaje_iva | Decimal | [oblig] | Porcentaje de IVA aplicado |
| importe_total | Decimal | [oblig] | Importe total con impuestos en euros |
| estado_cobro | Enumerado | [oblig] | Pendiente / Cobrada / Vencida / En_mora / Anulada |
| fecha_cobro | Fecha | | Fecha en que se recibio el pago (nulo hasta que se cobre) |
| metodo_cobro | Texto | | Forma de cobro efectuada (transferencia, cheque, etc.) |

*Vinculacion: emitida a un CLIENTE (R-04)*

---

## Area 8 -- Documentacion y control interno

### 16. DOCUMENTO_SERVICIO

**Descripcion:** Documentacion vinculada a un servicio: carta de porte CMR, albaranes
de entrega firmados, partes de incidencia, evidencias adicionales (fotos, registros de
temperatura, certificados). La propuesta contempla explicitamente la documentacion
asociada a servicios y las evidencias como parte del control interno.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_documento_srv** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| tipo_documento | Enumerado | [oblig] | CMR / Albaran_entrega / Parte_incidencia / Registro_temperatura / Certificado / Foto / Otro |
| descripcion | Texto | | Descripcion del contenido del documento |
| fecha_documento | Fecha | [oblig] | Fecha del documento |
| recibido | Booleano | [oblig] | Indica si el documento ha sido recibido y archivado |
| fecha_recepcion | Fecha | | Fecha en que se recibio el documento |
| referencia_archivo | Texto | | Referencia al archivo fisico o digital del documento |

*Vinculacion: pertenece a un SERVICIO (R-13)*

---

### 17. DOCUMENTO_RECURSO

**Descripcion:** Documentacion con fecha de caducidad vinculada a vehiculos, remolques
o conductores: permisos, seguros, ITV, calibracion de tacografo, CAP, tarjeta de tacografo.
La propuesta contempla explicitamente las vigencias/caducidades como parte del control interno.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_documento_rec** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| tipo_documento | Enumerado | [oblig] | Permiso_circulacion / Seguro / ITV / Tacografo_calibracion / Permiso_conducir / CAP / Tarjeta_tacografo / Autorizacion_especial / Otro |
| numero_documento | Texto | | Numero o referencia del documento |
| fecha_emision | Fecha | | Fecha de emision del documento |
| fecha_caducidad | Fecha | [oblig] | Fecha hasta la que el documento es valido |
| organismo_emisor | Texto | | Organismo o entidad que emite el documento |
| referencia_archivo | Texto | | Referencia al archivo fisico o digital del documento |

*Vinculaciones: id_vehiculo [opcional], id_remolque [opcional], id_conductor [opcional].
Exactamente uno de los tres debe tener valor en cada registro.*

---

### 18. REGISTRO_AUDITORIA

**Descripcion:** Registro de las operaciones criticas realizadas sobre el sistema:
creacion y modificacion de servicios, cambios de estado, asignaciones, facturas y costes.
Permite la trazabilidad de operaciones y el control de accesos. La propuesta contempla
explicitamente los registros de auditoria interna como parte del control interno.

| Atributo | Tipo | Restricciones | Significado |
|---|---|---|---|
| **id_auditoria** | Entero | PK, [oblig] | Identificador unico autoincrementable |
| tipo_operacion | Enumerado | [oblig] | Crear / Modificar / Eliminar / Cambio_estado / Asignar / Facturar / Cobrar |
| entidad_afectada | Texto | [oblig] | Nombre de la entidad sobre la que se realiza la operacion |
| id_registro_afectado | Entero | [oblig] | Identificador del registro afectado |
| usuario | Texto | [oblig] | Usuario que realizo la operacion |
| fecha_hora | FechaHora | [oblig] | Fecha y hora exacta de la operacion |
| descripcion | Texto | | Descripcion del cambio; valores anteriores y nuevos si aplica |

*Nota: REGISTRO_AUDITORIA no tiene FK directas a otras entidades porque es transversal
a todo el sistema. Las referencias se gestionan mediante entidad_afectada e id_registro_afectado.*

---

## Resumen de entidades

| # | Entidad | Area de la propuesta |
|:---:|---|---|
| 1 | CLIENTE | Clientes y terceros |
| 2 | CONTACTO | Clientes y terceros |
| 3 | DIRECCION_OPERATIVA | Clientes y terceros |
| 4 | SERVICIO | Servicios y seguimiento |
| 5 | PUNTO_SERVICIO | Servicios y seguimiento |
| 6 | EVENTO_SEGUIMIENTO | Servicios y seguimiento |
| 7 | MERCANCIA | Mercancia y requisitos |
| 8 | REQUISITO_ESPECIAL | Mercancia y requisitos |
| 9 | INCIDENCIA | Incidencias |
| 10 | VEHICULO | Recursos |
| 11 | REMOLQUE | Recursos |
| 12 | CONDUCTOR | Recursos |
| 13 | ASIGNACION | Recursos |
| 14 | COSTE_OPERATIVO | Costes operativos |
| 15 | FACTURA | Facturacion y cobros |
| 16 | DOCUMENTO_SERVICIO | Documentacion y control interno |
| 17 | DOCUMENTO_RECURSO | Documentacion y control interno |
| 18 | REGISTRO_AUDITORIA | Documentacion y control interno |