# Diagrama E/R -- Guia de Construccion Textual

**Proyecto:** Diseno, creacion y explotacion de una base de datos para la gestion integral
de una empresa de transporte intracomunitario por carretera (UE) en MySQL (phpMyAdmin)
**Fase:** 2 - Modelo Conceptual
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora - Curso 2024-26

> Guia detallada para dibujar el Diagrama Entidad-Relacion a mano o en draw.io.
> Incluye nombres semanticos de relaciones, cardinalidades, participacion total/parcial,
> instrucciones de representacion grafica y analisis N:M.

---

## 1. Convencion de notacion utilizada

```
Entidades:          [ NOMBRE ]          Rectangulo
Relaciones:         < NOMBRE >          Rombo (cuando es relacion pura)
Entidad asociativa: [[ NOMBRE ]]        Rectangulo con doble linea o marca especial
Atributos:          ( atributo )        Ovalo conectado a entidad o relacion

Cardinalidad y participacion (extremo izquierdo -- relacion -- extremo derecho):
  ||---           lado 1, participacion TOTAL (doble linea vertical)
  o|---           lado 1, participacion PARCIAL (circulo + linea)
  ---||           lado 1 derecho, participacion TOTAL
  ---<            lado N (pata de cuervo = crow's foot)
  ---o<           lado N, participacion PARCIAL en ese extremo
```

---

## 2. Entidades del modelo -- que dibujar como rectangulos

Todas las entidades se representan como **rectangulos**. Para cada una se indican
los atributos principales que deben aparecer en el diagrama (subrayar la PK).

### Area 1: Clientes y terceros

```
+----------------------------+
|          CLIENTE           |
+----------------------------+
| <PK> id_cliente            |
| nombre_razon_social  [oblig]|
| cif_nif  [oblig] [unico]   |
| pais  [oblig]              |
| condiciones_pago           |
| activo  [oblig]            |
+----------------------------+

+----------------------------+
|         CONTACTO           |
+----------------------------+
| <PK> id_contacto           |
| nombre  [oblig]            |
| apellidos  [oblig]         |
| cargo                      |
| telefono                   |
| email                      |
| es_principal  [oblig]      |
+----------------------------+

+----------------------------+
|    DIRECCION_OPERATIVA     |
+----------------------------+
| <PK> id_direccion          |
| descripcion                |
| direccion  [oblig]         |
| ciudad  [oblig]            |
| pais  [oblig]              |
| horario                    |
| activa  [oblig]            |
+----------------------------+
```

### Area 2: Servicios y seguimiento

```
+----------------------------+
|          SERVICIO          |  <-- ENTIDAD CENTRAL del modelo
+----------------------------+
| <PK> id_servicio           |
| numero_servicio [oblig][U] |
| fecha_solicitud  [oblig]   |
| fecha_prev_recogida [oblig]|
| tipo_servicio  [oblig]     |  enum: FTL/LTL/Especial
| nivel_urgencia  [oblig]    |  enum: Estandar/Urgente/...
| estado_actual  [oblig]     |  enum: Pendiente/Asignado/...
| documentacion_completa     |
| observaciones              |
+----------------------------+

+----------------------------+
|      PUNTO_SERVICIO        |
+----------------------------+
| <PK> id_punto              |
| tipo  [oblig]              |  enum: Recogida/Entrega
| orden  [oblig]             |
| direccion  [oblig]         |
| ciudad  [oblig]            |
| pais  [oblig]              |
| ventana_inicio             |
| ventana_fin                |
| fecha_ejecucion_real       |
| estado  [oblig]            |
+----------------------------+

+----------------------------+
|    EVENTO_SEGUIMIENTO      |
+----------------------------+
| <PK> id_evento             |
| tipo_evento  [oblig]       |
| descripcion  [oblig]       |
| fecha_hora  [oblig]        |
| estado_resultante  [oblig] |
| usuario_responsable [oblig]|
+----------------------------+
```

### Area 3: Mercancia y requisitos

```
+----------------------------+
|         MERCANCIA          |
+----------------------------+
| <PK> id_mercancia          |
| descripcion  [oblig]       |
| tipo_carga  [oblig]        |  enum: Paletizada/Granel/...
| num_bultos_palets          |
| peso_kg                    |
| volumen_m3                 |
| valor_declarado            |
+----------------------------+

+----------------------------+
|     REQUISITO_ESPECIAL     |
+----------------------------+
| <PK> id_requisito          |
| tipo  [oblig]              |  enum: Temperatura/ADR/...
| descripcion  [oblig]       |
| temperatura_min            |
| temperatura_max            |
| instrucciones              |
| verificacion_obligatoria   |
+----------------------------+
```

### Area 4: Incidencias

```
+----------------------------+
|         INCIDENCIA         |
+----------------------------+
| <PK> id_incidencia         |
| tipo  [oblig]              |
| descripcion  [oblig]       |
| fecha_apertura  [oblig]    |
| prioridad  [oblig]         |
| estado  [oblig]            |
| responsable_gestion        |
| fecha_cierre               |
| descripcion_resolucion     |
+----------------------------+
```

### Area 5: Recursos

```
+----------------------------+
|         VEHICULO           |
+----------------------------+
| <PK> id_vehiculo           |
| matricula  [oblig] [unico] |
| tipo  [oblig]              |  enum: Cabeza_tractora/Rigido
| marca                      |
| modelo                     |
| capacidad_carga_kg         |
| estado_operativo  [oblig]  |
+----------------------------+

+----------------------------+
|          REMOLQUE          |
+----------------------------+
| <PK> id_remolque           |
| matricula  [oblig] [unico] |
| tipo  [oblig]              |  enum: Lona/Frigorifico/...
| capacidad_carga_kg         |
| apto_temperatura           |
| estado_operativo  [oblig]  |
+----------------------------+

+----------------------------+
|         CONDUCTOR          |
+----------------------------+
| <PK> id_conductor          |
| numero_empleado [oblig][U] |
| nombre  [oblig]            |
| apellidos  [oblig]         |
| numero_permiso  [oblig][U] |
| categorias_permiso [oblig] |
| estado_disponibilidad      |
+----------------------------+

+============================+
|        ASIGNACION          |  <-- ENTIDAD ASOCIATIVA (rectangulo)
+============================+
| <PK> id_asignacion         |
| fecha_asignacion  [oblig]  |
| es_activa  [oblig]         |  distingue asignacion vigente / historica
| motivo_cambio              |
| observaciones              |
| <FK> id_servicio  [oblig]  |
| <FK> id_conductor [oblig]  |
| <FK> id_vehiculo  [oblig]  |
| <FK> id_remolque  [opcio.] |
+============================+
```

### Area 6: Costes operativos

```
+----------------------------+
|      COSTE_OPERATIVO       |
+----------------------------+
| <PK> id_coste              |
| tipo_coste  [oblig]        |  enum: Combustible/Peajes/...
| importe  [oblig]           |
| fecha  [oblig]             |
| descripcion                |
| justificante_disponible    |
+----------------------------+
```

### Area 7: Facturacion y cobros

```
+----------------------------+
|          FACTURA           |
+----------------------------+
| <PK> id_factura            |
| numero_factura [oblig][U]  |
| fecha_emision  [oblig]     |
| fecha_vencimiento  [oblig] |
| importe_base  [oblig]      |
| porcentaje_iva  [oblig]    |
| importe_total  [oblig]     |
| estado_cobro  [oblig]      |
| fecha_cobro                |
| metodo_cobro               |
+----------------------------+
```

### Area 8: Documentacion y control interno

```
+----------------------------+
|    DOCUMENTO_SERVICIO      |
+----------------------------+
| <PK> id_documento_srv      |
| tipo_documento  [oblig]    |  enum: CMR/Albaran/...
| descripcion                |
| fecha_documento  [oblig]   |
| recibido  [oblig]          |
| fecha_recepcion            |
| referencia_archivo         |
+----------------------------+

+----------------------------+
|     DOCUMENTO_RECURSO      |
+----------------------------+
| <PK> id_documento_rec      |
| tipo_documento  [oblig]    |  enum: Seguro/ITV/CAP/...
| numero_documento           |
| fecha_emision              |
| fecha_caducidad  [oblig]   |
| organismo_emisor           |
| referencia_archivo         |
| <FK> id_vehiculo   [opt]   |  exactamente una de las tres
| <FK> id_remolque   [opt]   |  FK con valor por registro
| <FK> id_conductor  [opt]   |
+----------------------------+

+----------------------------+
|     REGISTRO_AUDITORIA     |  <-- ENTIDAD TRANSVERSAL
+----------------------------+
| <PK> id_auditoria          |
| tipo_operacion  [oblig]    |
| entidad_afectada  [oblig]  |  nombre de la entidad (texto)
| id_registro_afectado       |  ID del registro afectado
| usuario  [oblig]           |
| fecha_hora  [oblig]        |
| descripcion                |
+----------------------------+
```

---

## 3. Relaciones del modelo -- que dibujar y como

### 3.1 Relaciones directas (rombos en el diagrama)

Para cada relacion se indica:
- Codigo de referencia
- Nombre semantico (etiqueta del rombo)
- Entidades conectadas con su participacion
- Cardinalidad

```
R-01 -- TIENE_CONTACTO
CLIENTE ||--- <TIENE_CONTACTO> ---< CONTACTO
Cardinalidad: 1:N
CLIENTE: participacion parcial (puede existir sin contactos)
CONTACTO: participacion total (todo contacto pertenece a un cliente)

R-02 -- TIENE_DIRECCION
CLIENTE ||--- <TIENE_DIRECCION> ---< DIRECCION_OPERATIVA
Cardinalidad: 1:N
CLIENTE: participacion parcial
DIRECCION_OPERATIVA: participacion total

R-03 -- CONTRATA
CLIENTE o|--- <CONTRATA> ---< SERVICIO
Cardinalidad: 1:N
CLIENTE: participacion parcial (puede existir sin servicios)
SERVICIO: participacion total (todo servicio tiene un cliente)

R-04 -- EMITIDA_A
CLIENTE o|--- <EMITIDA_A> ---< FACTURA
Cardinalidad: 1:N
CLIENTE: participacion parcial
FACTURA: participacion total (toda factura va a un cliente)

R-05 -- SE_FACTURA_EN
FACTURA ||--- <SE_FACTURA_EN> ---o< SERVICIO
Cardinalidad: 1:N
FACTURA: participacion total (toda factura agrupa servicios)
SERVICIO: participacion parcial (puede no estar facturado todavia)

R-06 -- TIENE_PUNTO
SERVICIO ||--- <TIENE_PUNTO> ---< PUNTO_SERVICIO
Cardinalidad: 1:N
SERVICIO: participacion total (todo servicio tiene puntos)
PUNTO_SERVICIO: participacion total

R-07 -- REFERENCIA_DIRECCION
PUNTO_SERVICIO o|--- <REFERENCIA_DIRECCION> ---o|| DIRECCION_OPERATIVA
Cardinalidad: N:1
Ambos extremos: participacion parcial
(un punto puede ser ad hoc; una direccion puede no estar referenciada actualmente)

R-08 -- TIENE_EVENTO
SERVICIO ||--- <TIENE_EVENTO> ---< EVENTO_SEGUIMIENTO
Cardinalidad: 1:N
SERVICIO: participacion total (todo servicio tiene al menos el evento de creacion)
EVENTO_SEGUIMIENTO: participacion total

R-09 -- CONTIENE_MERCANCIA
SERVICIO ||--- <CONTIENE_MERCANCIA> ---< MERCANCIA
Cardinalidad: 1:N  [cambio: era 1:1 en el borrador inicial]
SERVICIO: participacion total (todo servicio tiene al menos un lote de mercancia)
MERCANCIA: participacion total (toda mercancia pertenece a un servicio)
Nota: En FTL habitualmente 1 lote; en LTL pueden ser varios lotes distintos.

R-10 -- TIENE_REQUISITO
SERVICIO o|--- <TIENE_REQUISITO> ---< REQUISITO_ESPECIAL
Cardinalidad: 1:N
SERVICIO: participacion parcial (muchos servicios sin requisitos especiales)
REQUISITO_ESPECIAL: participacion total

R-11 -- GENERA_INCIDENCIA
SERVICIO o|--- <GENERA_INCIDENCIA> ---< INCIDENCIA
Cardinalidad: 1:N
SERVICIO: participacion parcial (la mayoria sin incidencias)
INCIDENCIA: participacion total

R-12 -- GENERA_COSTE
SERVICIO o|--- <GENERA_COSTE> ---< COSTE_OPERATIVO
Cardinalidad: 1:N
SERVICIO: participacion parcial
COSTE_OPERATIVO: participacion total

R-13 -- TIENE_DOCUMENTO
SERVICIO o|--- <TIENE_DOCUMENTO> ---< DOCUMENTO_SERVICIO
Cardinalidad: 1:N
SERVICIO: participacion parcial (pendiente de recepcion de documentos)
DOCUMENTO_SERVICIO: participacion total

R-14 -- TIENE_ASIGNACION
SERVICIO o|--- <TIENE_ASIGNACION> ---< ASIGNACION
Cardinalidad: 1:N
SERVICIO: participacion parcial (servicios en estado Pendiente pueden no tener asignacion)
ASIGNACION: participacion total

R-15 -- REALIZA
CONDUCTOR o|--- <REALIZA> ---< ASIGNACION
Cardinalidad: 1:N
CONDUCTOR: participacion parcial (puede estar disponible sin asignaciones)
ASIGNACION: participacion total (toda asignacion tiene un conductor)

R-16 -- UTILIZA_VEHICULO
VEHICULO o|--- <UTILIZA_VEHICULO> ---< ASIGNACION
Cardinalidad: 1:N
VEHICULO: participacion parcial
ASIGNACION: participacion total (toda asignacion tiene un vehiculo)

R-17 -- UTILIZA_REMOLQUE
REMOLQUE o|--- <UTILIZA_REMOLQUE> ---o< ASIGNACION
Cardinalidad: 1:N
REMOLQUE: participacion parcial
ASIGNACION: participacion parcial (vehiculos rigidos no necesitan remolque)

R-18 -- DOCUMENTA_VEHICULO
VEHICULO ||--- <DOCUMENTA_VEHICULO> ---< DOCUMENTO_RECURSO
Cardinalidad: 1:N
VEHICULO: participacion parcial (modelado por FK opcional en DOCUMENTO_RECURSO)
DOCUMENTO_RECURSO: participacion total cuando el documento es de vehiculo

R-19 -- DOCUMENTA_REMOLQUE
REMOLQUE ||--- <DOCUMENTA_REMOLQUE> ---< DOCUMENTO_RECURSO
Cardinalidad: 1:N
REMOLQUE: participacion parcial
DOCUMENTO_RECURSO: participacion total cuando el documento es de remolque

R-20 -- DOCUMENTA_CONDUCTOR
CONDUCTOR ||--- <DOCUMENTA_CONDUCTOR> ---< DOCUMENTO_RECURSO
Cardinalidad: 1:N
CONDUCTOR: participacion parcial
DOCUMENTO_RECURSO: participacion total cuando el documento es de conductor
```

---

## 4. Relaciones N:M y entidades asociativas

### 4.1 ASIGNACION como entidad asociativa (no rombo)

En el diagrama, **ASIGNACION no debe dibujarse como rombo**.
Debe dibujarse como **rectangulo**, porque:
- Tiene atributos propios: `fecha_asignacion`, `es_activa`, `motivo_cambio`
- Tiene un ciclo de vida independiente (historial de asignaciones)
- Puede existir como registro incluso cuando ya no esta activa

ASIGNACION resuelve tres relaciones N:M del dominio:
- CONDUCTOR (N) -- SERVICIO (M): un conductor realiza muchos servicios; un servicio puede tener varios conductores historicos
- VEHICULO (N) -- SERVICIO (M): un vehiculo participa en muchos servicios; un servicio puede haber usado varios vehiculos
- REMOLQUE (N) -- SERVICIO (M): lo mismo

Representacion en el diagrama:

```
CONDUCTOR ---[R-15]---+
VEHICULO  ---[R-16]---+---> [[ ASIGNACION ]] ---[R-14]---> SERVICIO
REMOLQUE  ---[R-17]---+
```

### 4.2 REGISTRO_AUDITORIA como entidad transversal

**REGISTRO_AUDITORIA no se conecta con lineas directas a otras entidades.**
En el diagrama se representa:
- Como rectangulo separado, en una esquina del lienzo
- Con una nota o comentario explicando que es una entidad transversal
- Sin flechas que la conecten a otras entidades
- La referencia a otras entidades se hace por texto (entidad_afectada) e ID numerico

Representacion sugerida en draw.io:
- Colocar REGISTRO_AUDITORIA en la esquina inferior derecha o en una banda horizontal inferior
- Usar una linea discontinua o un texto anotado indicando "registra operaciones sobre cualquier entidad"

---

## 5. Mapa global del modelo para el diagrama

Distribucion recomendada del lienzo:

```
Fila superior:
  [FACTURA] ----R-04---- [CLIENTE] ----R-01---- [CONTACTO]
                |                    \----R-02---- [DIRECCION_OPERATIVA]
               R-05                                    |
                |                                      | R-07 (opt)
  Columna central:                                     |
  [SERVICIO] <---R-03--- (CLIENTE)           [PUNTO_SERVICIO] <---R-06--- [SERVICIO]
      |
      +---R-08---< [EVENTO_SEGUIMIENTO]
      |
      +---R-09---< [MERCANCIA]             (1:N, varios lotes por servicio)
      |
      +---R-10---< [REQUISITO_ESPECIAL]
      |
      +---R-11---< [INCIDENCIA]
      |
      +---R-12---< [COSTE_OPERATIVO]
      |
      +---R-13---< [DOCUMENTO_SERVICIO]
      |
      +---R-14---< [[ ASIGNACION ]]
                          |
           +--------------+---------------+
           R-15           R-16           R-17 (opt)
           |              |              |
      [CONDUCTOR]    [VEHICULO]      [REMOLQUE]
           |              |              |
          R-20           R-18           R-19
           |              |              |
           +------+--------+------+------+
                  |               |
           [DOCUMENTO_RECURSO]   (cada uno usa la misma entidad
           (conductor)           con FK opcionales)


[REGISTRO_AUDITORIA]  -- esquina separada, entidad transversal
```

---

## 6. Resumen de relaciones por tipo

| Tipo | Relaciones |
|---|---|
| **1:N total-total** | R-06 (SERVICIO-PUNTO_SERVICIO), R-08 (SERVICIO-EVENTO_SEGUIMIENTO) |
| **1:N parcial en 1, total en N** | R-01, R-02, R-03, R-04, R-09, R-10, R-11, R-12, R-13, R-14, R-15, R-16 |
| **1:N parcial en ambos extremos** | R-17 (REMOLQUE-ASIGNACION), R-07 |
| **1:N especial con 3 FKs** | R-18, R-19, R-20 (DOCUMENTO_RECURSO con FK opcionales) |
| **1:N FACTURA-SERVICIO** | R-05 (total en FACTURA, parcial en SERVICIO) |
| **N:M resuelta** | CONDUCTOR/VEHICULO/REMOLQUE -- SERVICIO, resueltas por [[ASIGNACION]] |

---

## 7. Instrucciones para draw.io

### Paso 1 -- Preparar entorno
- draw.io (app.diagrams.net) > Nuevo > En blanco
- Activar Entity Relation shapes: More Shapes > Entity Relation

### Paso 2 -- Crear entidades
- Cada entidad: forma Entity (rectangulo con cabecera)
- PK subrayada; atributos obligatorios con asterisco
- ASIGNACION: con doble borde o indicacion "entidad asociativa"
- REGISTRO_AUDITORIA: rectangulo con nota "Entidad transversal"

### Paso 3 -- Trazar relaciones con crow's foot
- Etiqueta de cada linea: codigo + nombre (ej: "R-09 CONTIENE_MERCANCIA")
- Lado 1 total: doble barra ||
- Lado 1 parcial: circulo y barra o|
- Lado N: pata de cuervo
- Lado N parcial: pata de cuervo con circulo

### Paso 4 -- ASIGNACION
- Centrar ASIGNACION en el lienzo entre SERVICIO (arriba) y los tres recursos (abajo)
- Conectar con R-14, R-15, R-16, R-17
- Indicar que R-17 (REMOLQUE) es opcional en la asignacion

### Paso 5 -- DOCUMENTO_RECURSO
- Conectar con tres lineas separadas a VEHICULO, REMOLQUE y CONDUCTOR
- Anadir nota: "Exactamente una de las tres FK tiene valor por registro"

### Paso 6 -- Exportar
- PNG alta resolucion, fondo blanco
- Guardar .drawio en borradores/
- Copiar PNG a /diagramas/modelo_conceptual.png
