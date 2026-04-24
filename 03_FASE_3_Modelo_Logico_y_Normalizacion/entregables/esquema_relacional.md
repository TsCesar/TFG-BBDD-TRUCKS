# Esquema Relacional

**Proyecto:** Diseno, creacion y explotacion de una base de datos para la gestion integral
de una empresa de transporte intracomunitario por carretera (UE) en MySQL (phpMyAdmin)
**Fase:** 3 - Modelo Logico y Normalizacion
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora - Curso 2024-26

> Transformacion completa del modelo Entidad-Relacion de FASE 2 al modelo relacional logico.
> Incluye las 18 tablas resultantes con sus atributos, tipos logicos, restricciones, claves
> primarias y claves foraneas. No contiene SQL ni tipos fisicos de MySQL.

---

## Convenciones

### Restricciones de columna

| Simbolo | Significado |
|---|---|
| PK | Clave primaria (Primary Key) |
| FK | Clave foranea (Foreign Key) |
| AI | Autoincrementable (valor generado automaticamente) |
| NN | Not Null — valor obligatorio |
| UQ | Unique — valor unico en toda la tabla |
| OPT | Opcional — puede quedar sin valor (nulo) |

### Tipos logicos

| Tipo | Descripcion |
|---|---|
| Entero | Numero entero sin decimales |
| Cadena(n) | Cadena de caracteres de longitud variable, maximo n |
| Texto | Cadena de longitud indefinida |
| Decimal(p,e) | Numero decimal con p digitos totales y e decimales |
| Fecha | Solo fecha (dia, mes, ano) |
| FechaHora | Fecha y hora (dia, mes, ano, hora, minuto, segundo) |
| Booleano | Valor logico verdadero / falso |
| Enumerado{...} | Valor restringido a los literales indicados entre llaves |

### Notacion de las referencias

`FK columna → TABLA_REFERENCIADA` indica que el valor de esa columna debe existir
como clave primaria en la tabla referenciada.

Cuando una FK es `OPT` la columna puede ser nula, lo que indica ausencia de vinculacion.

---

## Reglas de transformacion E/R → Relacional aplicadas

| Caso E/R | Regla aplicada |
|---|---|
| Entidad con PK artificial | Tabla con columna id autoincrementable como PK |
| Relacion 1:N | FK en la tabla del lado N apuntando al lado 1 |
| Relacion 1:1 (R-09) | FK id_servicio en MERCANCIA con restriccion UQ |
| Entidad asociativa N:N (ASIGNACION) | Tabla propia con FK a las tres entidades participantes |
| Atributo total (participacion obligatoria) | FK marcada NN |
| Atributo parcial (participacion opcional) | FK marcada OPT |
| Tres FK opcionales exclusivas (DOCUMENTO_RECURSO) | Tres columnas FK con OPT; restriccion check de exclusividad |

---

## Area 1 — Clientes y terceros

### Tabla 1: CLIENTE

```
CLIENTE
────────────────────────────────────────────────────────────────────────
Columna                 Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_cliente          Entero AI        NN
    nombre_razon_social Cadena(200)      NN
    cif_nif             Cadena(20)       NN, UQ
    pais                Cadena(100)      NN
    ciudad              Cadena(100)      OPT
    direccion_sede      Cadena(255)      OPT
    telefono            Cadena(30)       OPT
    email               Cadena(150)      OPT
    condiciones_pago    Texto            OPT
    activo              Booleano         NN
────────────────────────────────────────────────────────────────────────
Clave primaria: id_cliente
Claves unicas:  cif_nif
Sin claves foraneas
```

---

### Tabla 2: CONTACTO

```
CONTACTO
────────────────────────────────────────────────────────────────────────
Columna                 Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_contacto         Entero AI        NN
    nombre              Cadena(100)      NN
    apellidos           Cadena(150)      NN
    cargo               Cadena(100)      OPT
    telefono            Cadena(30)       OPT
    email               Cadena(150)      OPT
    es_principal        Booleano         NN
FK  id_cliente          Entero           NN → CLIENTE
────────────────────────────────────────────────────────────────────────
Clave primaria:  id_contacto
Clave foranea:   id_cliente → CLIENTE(id_cliente)   [R-01]
```

---

### Tabla 3: DIRECCION_OPERATIVA

```
DIRECCION_OPERATIVA
────────────────────────────────────────────────────────────────────────
Columna                 Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_direccion        Entero AI        NN
    descripcion         Cadena(200)      OPT
    direccion           Cadena(255)      NN
    ciudad              Cadena(100)      NN
    pais                Cadena(100)      NN
    telefono            Cadena(30)       OPT
    horario             Cadena(200)      OPT
    activa              Booleano         NN
FK  id_cliente          Entero           NN → CLIENTE
────────────────────────────────────────────────────────────────────────
Clave primaria:  id_direccion
Clave foranea:   id_cliente → CLIENTE(id_cliente)   [R-02]
```

---

## Area 2 — Servicios y seguimiento

### Tabla 4: SERVICIO

```
SERVICIO
────────────────────────────────────────────────────────────────────────
Columna                  Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_servicio          Entero AI        NN
    numero_servicio      Cadena(30)       NN, UQ
    fecha_solicitud      Fecha            NN
    fecha_prev_recogida  Fecha            NN
    tipo_servicio        Enumerado        NN
                         {FTL, LTL, Especial}
    nivel_urgencia       Enumerado        NN
                         {Estandar, Urgente, Fecha_garantizada, Nocturno}
    estado_actual        Enumerado        NN
                         {Pendiente, Planificado, Asignado, En_transito,
                          Entregado, Cerrado, Cancelado, Con_incidencia}
    documentacion_comp.  Booleano         NN
    observaciones        Texto            OPT
FK  id_cliente           Entero           NN → CLIENTE
FK  id_factura           Entero           OPT → FACTURA
────────────────────────────────────────────────────────────────────────
Clave primaria:  id_servicio
Claves unicas:   numero_servicio
Claves foraneas: id_cliente  → CLIENTE(id_cliente)   [R-03]
                 id_factura  → FACTURA(id_factura)    [R-05, opcional]
```

> Nota: id_factura es opcional (OPT) porque un servicio puede estar sin facturar.
> La cardinalidad R-05 admite que una factura agrupe varios servicios.

---

### Tabla 5: PUNTO_SERVICIO

```
PUNTO_SERVICIO
────────────────────────────────────────────────────────────────────────
Columna                 Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_punto            Entero AI        NN
    tipo                Enumerado        NN
                        {Recogida, Entrega}
    orden               Entero           NN
    direccion           Cadena(255)      NN
    ciudad              Cadena(100)      NN
    pais                Cadena(100)      NN
    ventana_inicio      FechaHora        OPT
    ventana_fin         FechaHora        OPT
    fecha_ejec_real     FechaHora        OPT
    estado              Enumerado        NN
                        {Pendiente, En_proceso, Completado, Fallido}
    observaciones       Texto            OPT
FK  id_servicio         Entero           NN → SERVICIO
FK  id_direccion        Entero           OPT → DIRECCION_OPERATIVA
────────────────────────────────────────────────────────────────────────
Clave primaria:  id_punto
Claves foraneas: id_servicio  → SERVICIO(id_servicio)                [R-06]
                 id_direccion → DIRECCION_OPERATIVA(id_direccion)    [R-07, opcional]
```

---

### Tabla 6: EVENTO_SEGUIMIENTO

```
EVENTO_SEGUIMIENTO
────────────────────────────────────────────────────────────────────────
Columna                 Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_evento           Entero AI        NN
    tipo_evento         Enumerado        NN
                        {Servicio_creado, Planificado, Asignado,
                         Recogida_completada, En_transito, Llegada_punto,
                         Entrega_completada, Incidencia_registrada,
                         Cerrado, Cancelado, Otro}
    descripcion         Texto            NN
    fecha_hora          FechaHora        NN
    estado_resultante   Enumerado        NN
                        {Pendiente, Planificado, Asignado, En_transito,
                         Entregado, Cerrado, Cancelado, Con_incidencia}
    usuario_responsable Cadena(100)      NN
    observaciones       Texto            OPT
FK  id_servicio         Entero           NN → SERVICIO
────────────────────────────────────────────────────────────────────────
Clave primaria:  id_evento
Clave foranea:   id_servicio → SERVICIO(id_servicio)   [R-08]
```

---

## Area 3 — Mercancia y requisitos

### Tabla 7: MERCANCIA

```
MERCANCIA
────────────────────────────────────────────────────────────────────────
Columna                 Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_mercancia        Entero AI        NN
    descripcion         Texto            NN
    tipo_carga          Enumerado        NN
                        {Paletizada, Bultos, Granel, Maquinaria,
                         Piezas_especiales, Otro}
    num_bultos_palets   Entero           OPT
    peso_kg             Decimal(10,2)    OPT
    volumen_m3          Decimal(8,3)     OPT
    valor_declarado     Decimal(12,2)    OPT
    observaciones       Texto            OPT
FK  id_servicio         Entero           NN, UQ → SERVICIO
────────────────────────────────────────────────────────────────────────
Clave primaria:  id_mercancia
Claves unicas:   id_servicio   (garantiza la cardinalidad 1:1 de R-09)
Clave foranea:   id_servicio → SERVICIO(id_servicio)   [R-09]
```

> Nota: La restriccion UQ sobre id_servicio implementa la cardinalidad 1:1 entre
> SERVICIO y MERCANCIA definida en la relacion R-09 del modelo conceptual.

---

### Tabla 8: REQUISITO_ESPECIAL

```
REQUISITO_ESPECIAL
────────────────────────────────────────────────────────────────────────
Columna                 Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_requisito        Entero AI        NN
    tipo                Enumerado        NN
                        {Temperatura_controlada, Manipulacion_especial,
                         Seguro_adicional, Restriccion_acceso,
                         Documentacion_adicional, Otro}
    descripcion         Texto            NN
    temperatura_min     Decimal(5,1)     OPT
    temperatura_max     Decimal(5,1)     OPT
    instrucciones       Texto            OPT
    verificacion_oblig. Booleano         NN
FK  id_servicio         Entero           NN → SERVICIO
────────────────────────────────────────────────────────────────────────
Clave primaria:  id_requisito
Clave foranea:   id_servicio → SERVICIO(id_servicio)   [R-10]
```

---

## Area 4 — Incidencias

### Tabla 9: INCIDENCIA

```
INCIDENCIA
────────────────────────────────────────────────────────────────────────
Columna                  Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_incidencia         Entero AI        NN
    tipo                  Enumerado        NN
                          {Averia_vehiculo, Accidente, Demora_significativa,
                           Mercancia_danada, Rechazo_entrega,
                           Problema_documentacion, Problema_acceso, Otro}
    descripcion           Texto            NN
    fecha_apertura        FechaHora        NN
    prioridad             Enumerado        NN
                          {Baja, Media, Alta, Critica}
    estado                Enumerado        NN
                          {Abierta, En_gestion, Resuelta, Cerrada}
    fecha_ultima_act.     FechaHora        OPT
    responsable_gestion   Cadena(150)      OPT
    fecha_cierre          FechaHora        OPT
    descripcion_resolucion Texto           OPT
    genera_coste_adicional Booleano        NN
FK  id_servicio            Entero          NN → SERVICIO
────────────────────────────────────────────────────────────────────────
Clave primaria:  id_incidencia
Clave foranea:   id_servicio → SERVICIO(id_servicio)   [R-11]
```

---

## Area 5 — Recursos

### Tabla 10: VEHICULO

```
VEHICULO
────────────────────────────────────────────────────────────────────────
Columna                 Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_vehiculo         Entero AI        NN
    matricula           Cadena(15)       NN, UQ
    tipo                Enumerado        NN
                        {Cabeza_tractora, Rigido}
    marca               Cadena(50)       OPT
    modelo              Cadena(100)      OPT
    anio_matriculacion  Entero           OPT
    capacidad_carga_kg  Decimal(10,2)    OPT
    estado_operativo    Enumerado        NN
                        {Disponible, Asignado, Mantenimiento, Baja}
────────────────────────────────────────────────────────────────────────
Clave primaria:  id_vehiculo
Claves unicas:   matricula
Sin claves foraneas
```

---

### Tabla 11: REMOLQUE

```
REMOLQUE
────────────────────────────────────────────────────────────────────────
Columna                 Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_remolque         Entero AI        NN
    matricula           Cadena(15)       NN, UQ
    tipo                Enumerado        NN
                        {Lona, Frigorifico, Cisterna, Portacoches,
                         Caja_cerrada, Otro}
    capacidad_carga_kg  Decimal(10,2)    OPT
    longitud_m          Decimal(4,2)     OPT
    apto_temperatura    Booleano         OPT
    estado_operativo    Enumerado        NN
                        {Disponible, Asignado, Mantenimiento, Baja}
────────────────────────────────────────────────────────────────────────
Clave primaria:  id_remolque
Claves unicas:   matricula
Sin claves foraneas
```

---

### Tabla 12: CONDUCTOR

```
CONDUCTOR
────────────────────────────────────────────────────────────────────────
Columna                 Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_conductor        Entero AI        NN
    numero_empleado     Cadena(20)       NN, UQ
    nombre              Cadena(100)      NN
    apellidos           Cadena(150)      NN
    fecha_nacimiento    Fecha            OPT
    telefono            Cadena(30)       OPT
    email               Cadena(150)      OPT
    numero_permiso      Cadena(30)       NN, UQ
    categorias_permiso  Cadena(50)       NN
    estado_disponib.    Enumerado        NN
                        {Disponible, Asignado, Vacaciones,
                         Baja_temporal, Baja_definitiva}
────────────────────────────────────────────────────────────────────────
Clave primaria:  id_conductor
Claves unicas:   numero_empleado, numero_permiso
Sin claves foraneas
```

---

### Tabla 13: ASIGNACION

```
ASIGNACION
────────────────────────────────────────────────────────────────────────
Columna                 Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_asignacion       Entero AI        NN
    fecha_asignacion    FechaHora        NN
    es_activa           Booleano         NN
    motivo_cambio       Texto            OPT
    observaciones       Texto            OPT
FK  id_servicio         Entero           NN → SERVICIO
FK  id_conductor        Entero           NN → CONDUCTOR
FK  id_vehiculo         Entero           NN → VEHICULO
FK  id_remolque         Entero           OPT → REMOLQUE
────────────────────────────────────────────────────────────────────────
Clave primaria:  id_asignacion
Claves foraneas: id_servicio  → SERVICIO(id_servicio)     [R-14]
                 id_conductor → CONDUCTOR(id_conductor)   [R-15]
                 id_vehiculo  → VEHICULO(id_vehiculo)     [R-16]
                 id_remolque  → REMOLQUE(id_remolque)     [R-17, opcional]
```

---

## Area 6 — Costes operativos

### Tabla 14: COSTE_OPERATIVO

```
COSTE_OPERATIVO
────────────────────────────────────────────────────────────────────────
Columna                 Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_coste            Entero AI        NN
    tipo_coste          Enumerado        NN
                        {Combustible, Peajes, Dietas, Reparacion,
                         Seguro_adicional, Mantenimiento, Otro}
    importe             Decimal(10,2)    NN
    fecha               Fecha            NN
    descripcion         Texto            OPT
    justificante_disp.  Booleano         NN
FK  id_servicio         Entero           NN → SERVICIO
────────────────────────────────────────────────────────────────────────
Clave primaria:  id_coste
Clave foranea:   id_servicio → SERVICIO(id_servicio)   [R-12]
```

---

## Area 7 — Facturacion y cobros

### Tabla 15: FACTURA

```
FACTURA
────────────────────────────────────────────────────────────────────────
Columna                 Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_factura          Entero AI        NN
    numero_factura      Cadena(30)       NN, UQ
    fecha_emision       Fecha            NN
    fecha_vencimiento   Fecha            NN
    importe_base        Decimal(12,2)    NN
    porcentaje_iva      Decimal(5,2)     NN
    importe_total       Decimal(12,2)    NN
    estado_cobro        Enumerado        NN
                        {Pendiente, Cobrada, Vencida, En_mora, Anulada}
    fecha_cobro         Fecha            OPT
    metodo_cobro        Cadena(100)      OPT
FK  id_cliente          Entero           NN → CLIENTE
────────────────────────────────────────────────────────────────────────
Clave primaria:  id_factura
Claves unicas:   numero_factura
Clave foranea:   id_cliente → CLIENTE(id_cliente)   [R-04]
```

> Nota: importe_total se almacena como atributo propio y no como valor derivado
> porque el importe legalmente facturado debe ser inmutable una vez emitida la factura,
> con independencia de posibles cambios en la logica de calculo.

---

## Area 8 — Documentacion y control interno

### Tabla 16: DOCUMENTO_SERVICIO

```
DOCUMENTO_SERVICIO
────────────────────────────────────────────────────────────────────────
Columna                 Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_documento_srv    Entero AI        NN
    tipo_documento      Enumerado        NN
                        {CMR, Albaran_entrega, Parte_incidencia,
                         Registro_temperatura, Certificado, Foto, Otro}
    descripcion         Texto            OPT
    fecha_documento     Fecha            NN
    recibido            Booleano         NN
    fecha_recepcion     Fecha            OPT
    referencia_archivo  Cadena(255)      OPT
FK  id_servicio         Entero           NN → SERVICIO
────────────────────────────────────────────────────────────────────────
Clave primaria:  id_documento_srv
Clave foranea:   id_servicio → SERVICIO(id_servicio)   [R-13]
```

---

### Tabla 17: DOCUMENTO_RECURSO

```
DOCUMENTO_RECURSO
────────────────────────────────────────────────────────────────────────
Columna                 Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_documento_rec    Entero AI        NN
    tipo_documento      Enumerado        NN
                        {Permiso_circulacion, Seguro, ITV,
                         Tacografo_calibracion, Permiso_conducir,
                         CAP, Tarjeta_tacografo,
                         Autorizacion_especial, Otro}
    numero_documento    Cadena(60)       OPT
    fecha_emision       Fecha            OPT
    fecha_caducidad     Fecha            NN
    organismo_emisor    Cadena(150)      OPT
    referencia_archivo  Cadena(255)      OPT
FK  id_vehiculo         Entero           OPT → VEHICULO
FK  id_remolque         Entero           OPT → REMOLQUE
FK  id_conductor        Entero           OPT → CONDUCTOR
────────────────────────────────────────────────────────────────────────
Clave primaria:  id_documento_rec
Claves foraneas: id_vehiculo  → VEHICULO(id_vehiculo)     [R-18, opcional]
                 id_remolque  → REMOLQUE(id_remolque)     [R-19, opcional]
                 id_conductor → CONDUCTOR(id_conductor)   [R-20, opcional]

Restriccion de exclusividad: exactamente una de las tres FK debe tener valor
en cada registro. Las otras dos deben ser nulas.
CHECK: (id_vehiculo IS NOT NULL)::int +
       (id_remolque IS NOT NULL)::int +
       (id_conductor IS NOT NULL)::int = 1
```

---

### Tabla 18: REGISTRO_AUDITORIA

```
REGISTRO_AUDITORIA
────────────────────────────────────────────────────────────────────────
Columna                 Tipo             Restricciones
────────────────────────────────────────────────────────────────────────
PK  id_auditoria        Entero AI        NN
    tipo_operacion      Enumerado        NN
                        {Crear, Modificar, Eliminar, Cambio_estado,
                         Asignar, Facturar, Cobrar}
    entidad_afectada    Cadena(50)       NN
    id_registro_afect.  Entero           NN
    usuario             Cadena(100)      NN
    fecha_hora          FechaHora        NN
    descripcion         Texto            OPT
────────────────────────────────────────────────────────────────────────
Clave primaria:  id_auditoria
Sin claves foraneas (entidad transversal; referencia por nombre e identificador)
```

---

## Resumen del esquema relacional

| # | Tabla | FK propias | Apuntada por |
|:---:|---|:---:|:---:|
| 1 | CLIENTE | 0 | CONTACTO, DIRECCION_OPERATIVA, SERVICIO, FACTURA |
| 2 | CONTACTO | 1 (id_cliente) | — |
| 3 | DIRECCION_OPERATIVA | 1 (id_cliente) | PUNTO_SERVICIO |
| 4 | SERVICIO | 2 (id_cliente, id_factura opt) | PUNTO_SERVICIO, EVENTO_SEGUIMIENTO, MERCANCIA, REQUISITO_ESPECIAL, INCIDENCIA, ASIGNACION, COSTE_OPERATIVO, DOCUMENTO_SERVICIO |
| 5 | PUNTO_SERVICIO | 2 (id_servicio, id_direccion opt) | — |
| 6 | EVENTO_SEGUIMIENTO | 1 (id_servicio) | — |
| 7 | MERCANCIA | 1 (id_servicio UQ) | — |
| 8 | REQUISITO_ESPECIAL | 1 (id_servicio) | — |
| 9 | INCIDENCIA | 1 (id_servicio) | — |
| 10 | VEHICULO | 0 | ASIGNACION, DOCUMENTO_RECURSO |
| 11 | REMOLQUE | 0 | ASIGNACION, DOCUMENTO_RECURSO |
| 12 | CONDUCTOR | 0 | ASIGNACION, DOCUMENTO_RECURSO |
| 13 | ASIGNACION | 4 (id_servicio, id_conductor, id_vehiculo, id_remolque opt) | — |
| 14 | COSTE_OPERATIVO | 1 (id_servicio) | — |
| 15 | FACTURA | 1 (id_cliente) | SERVICIO |
| 16 | DOCUMENTO_SERVICIO | 1 (id_servicio) | — |
| 17 | DOCUMENTO_RECURSO | 3 opt (id_vehiculo, id_remolque, id_conductor) | — |
| 18 | REGISTRO_AUDITORIA | 0 (transversal) | — |

**Total: 18 tablas, 21 relaciones FK implementadas**
