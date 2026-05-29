# Diagrama E/R -- Guia Completa para Dibujar a Mano

**Proyecto:** Diseno, creacion y explotacion de una base de datos para la gestion integral
de una empresa de transporte intracomunitario por carretera (UE)
**Fase:** 2 - Modelo Conceptual
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora - Curso 2024-26

> Guia detallada para construir el Diagrama Entidad-Relacion a mano o en draw.io.
> Incluye las 19 entidades, las 21 relaciones (20 directas + 1 N:M con rombo),
> cardinalidades, participacion total/parcial y reglas de representacion grafica.

---

## 1. Leyenda de simbolos y notacion

### En el diagrama fisico (papel o draw.io):

| Elemento | Figura | Uso |
|---|---|---|
| Entidad regular | **Rectangulo** | Cada entidad del modelo |
| Entidad asociativa | **Rectangulo con doble borde** | ASIGNACION |
| Entidad transversal | **Rectangulo** con nota | REGISTRO_AUDITORIA |
| Entidad catalogo | **Rectangulo** | CATEGORIA_PERMISO |
| Relacion 1:N, 1:1 | **Rombo** | Todas las relaciones 1:N |
| Relacion N:M directa | **Rombo** | Solo R-21 POSEE_CATEGORIA |
| Atributo | **Ovalo** (opcional) | Si el evaluador lo pide |
| Clave primaria | Atributo subrayado | PK de cada entidad |
| Participacion total | Doble linea en el extremo | Obligatorio participar |
| Participacion parcial | Linea simple con circulo | Opcional participar |
| Cardinalidad lado 1 | `1` junto a la linea | El extremo "uno" |
| Cardinalidad lado N | `N` junto a la linea | El extremo "muchos" |
| Cardinalidad N:M | `N` y `M` en cada extremo | Solo R-21 |

### Notacion textual usada en este documento:

```
[ENTIDAD]           = rectangulo
[[ENTIDAD]]         = rectangulo doble (entidad asociativa)
<RELACION>          = rombo
||---               = participacion total, extremo izquierdo
o|---               = participacion parcial, extremo izquierdo
---||               = participacion total, extremo derecho
---o|               = participacion parcial, extremo derecho
---N                = lado muchos sin participacion especial
```

---

## 2. Las 19 entidades -- que dibujar y como

Cada entidad se dibuja como **rectangulo**. Dentro van: nombre en cabecera y atributos
principales. La PK va subrayada o marcada con asterisco.

### Area 1: Clientes y terceros

```
[CLIENTE]
  _id_cliente_ (PK)
  nombre_razon_social *
  cif_nif * [UNICO]
  pais *
  condiciones_pago
  activo *

[CONTACTO]
  _id_contacto_ (PK)
  nombre *
  apellidos *
  cargo
  telefono
  email
  es_principal *

[DIRECCION_OPERATIVA]
  _id_direccion_ (PK)
  descripcion
  direccion *
  ciudad *
  pais *
  horario
  activa *
```

### Area 2: Servicios y seguimiento

```
[SERVICIO]  <-- ENTIDAD CENTRAL del modelo
  _id_servicio_ (PK)
  numero_servicio * [UNICO]
  fecha_solicitud *
  fecha_prev_recogida *
  tipo_servicio * (FTL / LTL / Especial)
  nivel_urgencia * (Estandar / Urgente / Nocturno...)
  estado_actual * (Pendiente / En_transito / Entregado...)
  documentacion_completa *
  observaciones

[PUNTO_SERVICIO]
  _id_punto_ (PK)
  tipo * (Recogida / Entrega)
  orden *
  direccion *
  ciudad *
  pais *
  ventana_inicio
  ventana_fin
  fecha_ejecucion_real
  estado *

[EVENTO_SEGUIMIENTO]
  _id_evento_ (PK)
  tipo_evento *
  descripcion *
  fecha_hora *
  estado_resultante *
  usuario_responsable *
```

### Area 3: Mercancia y requisitos

```
[MERCANCIA]
  _id_mercancia_ (PK)
  descripcion *
  tipo_carga * (Paletizada / Granel / Maquinaria...)
  num_bultos_palets
  peso_kg
  volumen_m3
  valor_declarado

[REQUISITO_ESPECIAL]
  _id_requisito_ (PK)
  tipo * (Temperatura / Manipulacion / ADR...)
  descripcion *
  temperatura_min
  temperatura_max
  instrucciones
  verificacion_obligatoria *
```

### Area 4: Incidencias

```
[INCIDENCIA]
  _id_incidencia_ (PK)
  tipo *
  descripcion *
  fecha_apertura *
  prioridad * (Baja / Media / Alta / Critica)
  estado * (Abierta / En_gestion / Resuelta / Cerrada)
  responsable_gestion
  fecha_cierre
  descripcion_resolucion
```

### Area 5: Recursos

```
[VEHICULO]
  _id_vehiculo_ (PK)
  matricula * [UNICO]
  tipo * (Cabeza_tractora / Rigido)
  marca
  modelo
  capacidad_carga_kg
  estado_operativo *

[REMOLQUE]
  _id_remolque_ (PK)
  matricula * [UNICO]
  tipo * (Lona / Frigorifico / Cisterna...)
  capacidad_carga_kg
  apto_temperatura
  estado_operativo *

[CONDUCTOR]
  _id_conductor_ (PK)
  numero_empleado * [UNICO]
  nombre *
  apellidos *
  numero_permiso * [UNICO]
  estado_disponibilidad *
  (categorias: ver R-21 con CATEGORIA_PERMISO)

[[ASIGNACION]]  <-- ENTIDAD ASOCIATIVA (rectangulo con doble borde)
  _id_asignacion_ (PK)
  fecha_asignacion *
  es_activa *
  motivo_cambio
  (FK: id_servicio, id_conductor, id_vehiculo, id_remolque[opt])

[CATEGORIA_PERMISO]  <-- ENTIDAD CATALOGO
  _id_categoria_ (PK)
  codigo_categoria * [UNICO]   (C / CE / C1 / C1E / D / B+E...)
  descripcion *
  activa *
```

### Area 6: Costes operativos

```
[COSTE_OPERATIVO]
  _id_coste_ (PK)
  tipo_coste * (Combustible / Peajes / Dietas / Reparacion...)
  importe *
  fecha *
  descripcion
  justificante_disponible *
```

### Area 7: Facturacion y cobros

```
[FACTURA]
  _id_factura_ (PK)
  numero_factura * [UNICO]
  fecha_emision *
  fecha_vencimiento *
  importe_base *
  porcentaje_iva *
  importe_total *
  estado_cobro * (Pendiente / Cobrada / Vencida / En_mora...)
  fecha_cobro
  metodo_cobro
```

### Area 8: Documentacion y control interno

```
[DOCUMENTO_SERVICIO]
  _id_documento_srv_ (PK)
  tipo_documento * (CMR / Albaran / Parte_incidencia...)
  descripcion
  fecha_documento *
  recibido *
  fecha_recepcion
  referencia_archivo

[DOCUMENTO_RECURSO]
  _id_documento_rec_ (PK)
  tipo_documento * (Seguro / ITV / CAP / Permiso_conducir...)
  numero_documento
  fecha_emision
  fecha_caducidad *
  organismo_emisor
  (FK: id_vehiculo [opt] / id_remolque [opt] / id_conductor [opt])
  Restriccion: exactamente una de las tres FK tiene valor

[REGISTRO_AUDITORIA]  <-- ENTIDAD TRANSVERSAL (sin FK directas)
  _id_auditoria_ (PK)
  tipo_operacion *
  entidad_afectada * (nombre como texto)
  id_registro_afectado *
  usuario *
  fecha_hora *
  descripcion
```

---

## 3. Las 21 relaciones -- como dibujar cada una

### Formato de cada relacion:

```
[ENTIDAD_A] -- <NOMBRE_RELACION> -- [ENTIDAD_B]
Codigo: R-xx
Cardinalidad: X:Y
Participacion: descripcion de cada extremo
Representacion: instruccion para dibujarlo
```

---

### R-01 -- TIENE_CONTACTO

```
[CLIENTE] -- <TIENE_CONTACTO> -- [CONTACTO]
Cardinalidad: 1:N
Participacion CLIENTE: parcial (linea simple con circulo en extremo CLIENTE)
Participacion CONTACTO: total (doble linea en extremo CONTACTO)
Representacion: Rombo con etiqueta "TIENE_CONTACTO".
  Lado CLIENTE: o|--- (circulo + barra)
  Lado CONTACTO: ---< (crow's foot)
```

---

### R-02 -- TIENE_DIRECCION

```
[CLIENTE] -- <TIENE_DIRECCION> -- [DIRECCION_OPERATIVA]
Cardinalidad: 1:N
Participacion CLIENTE: parcial
Participacion DIRECCION_OPERATIVA: total
Representacion: Rombo. Mismo esquema que R-01.
```

---

### R-03 -- CONTRATA

```
[CLIENTE] -- <CONTRATA> -- [SERVICIO]
Cardinalidad: 1:N
Participacion CLIENTE: parcial (puede no tener servicios todavia)
Participacion SERVICIO: total (todo servicio tiene un cliente)
Representacion: Rombo central. CLIENTE con circulo; SERVICIO con doble linea.
```

---

### R-04 -- EMITIDA_A

```
[CLIENTE] -- <EMITIDA_A> -- [FACTURA]
Cardinalidad: 1:N
Participacion CLIENTE: parcial
Participacion FACTURA: total (toda factura va a un cliente)
Representacion: Rombo. Igual que R-03.
```

---

### R-05 -- AGRUPA_SERVICIOS

```
[FACTURA] -- <AGRUPA_SERVICIOS> -- [SERVICIO]
Cardinalidad: 1:N
Participacion FACTURA: total (toda factura incluye al menos un servicio)
Participacion SERVICIO: parcial (puede no estar facturado todavia)
Representacion: Rombo con etiqueta "AGRUPA_SERVICIOS".
  Lado FACTURA: ||--- (doble barra)
  Lado SERVICIO: ---o< (crow's foot con circulo)
IMPORTANTE: "incluye N servicios" NO es una caja ni entidad.
Es la relacion AGRUPA_SERVICIOS representada como rombo.
```

---

### R-06 -- TIENE_PUNTO

```
[SERVICIO] -- <TIENE_PUNTO> -- [PUNTO_SERVICIO]
Cardinalidad: 1:N
Participacion SERVICIO: total (todo servicio tiene al menos un punto)
Participacion PUNTO_SERVICIO: total
Representacion: Rombo. Ambos extremos con doble linea.
```

---

### R-07 -- REFERENCIA_DIRECCION

```
[PUNTO_SERVICIO] -- <REFERENCIA_DIRECCION> -- [DIRECCION_OPERATIVA]
Cardinalidad: N:1
Participacion PUNTO_SERVICIO: parcial (puede ser un punto ad hoc)
Participacion DIRECCION_OPERATIVA: parcial (puede no estar referenciada)
Representacion: Rombo. Ambos extremos con circulo (participacion parcial).
  Lado PUNTO_SERVICIO: o|--- (N, parcial)
  Lado DIRECCION_OPERATIVA: ---o|| (1, parcial)
```

---

### R-08 -- REGISTRA_EVENTO

```
[SERVICIO] -- <REGISTRA_EVENTO> -- [EVENTO_SEGUIMIENTO]
Cardinalidad: 1:N
Participacion SERVICIO: total (todo servicio registra al menos el evento de creacion)
Participacion EVENTO_SEGUIMIENTO: total
Representacion: Rombo. Ambos extremos con doble linea.
```

---

### R-09 -- CONTIENE_MERCANCIA

```
[SERVICIO] -- <CONTIENE_MERCANCIA> -- [MERCANCIA]
Cardinalidad: 1:N
Participacion SERVICIO: total (todo servicio tiene al menos un lote de mercancia)
Participacion MERCANCIA: total
Representacion: Rombo. Ambos extremos con doble linea.
Nota: Antes era 1:1. Se cambio a 1:N para modelar servicios LTL con varios lotes.
```

---

### R-10 -- REQUIERE_CONDICION

```
[SERVICIO] -- <REQUIERE_CONDICION> -- [REQUISITO_ESPECIAL]
Cardinalidad: 1:N
Participacion SERVICIO: parcial (la mayoria de servicios no tienen requisitos especiales)
Participacion REQUISITO_ESPECIAL: total
Representacion: Rombo.
  Lado SERVICIO: o|--- (circulo)
  Lado REQUISITO_ESPECIAL: ---< (crow's foot sin circulo)
```

---

### R-11 -- GENERA_INCIDENCIA

```
[SERVICIO] -- <GENERA_INCIDENCIA> -- [INCIDENCIA]
Cardinalidad: 1:N
Participacion SERVICIO: parcial (la mayoria sin incidencias)
Participacion INCIDENCIA: total
Representacion: Rombo. Igual que R-10.
```

---

### R-12 -- GENERA_COSTE

```
[SERVICIO] -- <GENERA_COSTE> -- [COSTE_OPERATIVO]
Cardinalidad: 1:N
Participacion SERVICIO: parcial
Participacion COSTE_OPERATIVO: total
Representacion: Rombo. Igual que R-10.
```

---

### R-13 -- TIENE_DOCUMENTO_SERVICIO

```
[SERVICIO] -- <TIENE_DOCUMENTO_SERVICIO> -- [DOCUMENTO_SERVICIO]
Cardinalidad: 1:N
Participacion SERVICIO: parcial (puede no tener documentos archivados todavia)
Participacion DOCUMENTO_SERVICIO: total
Representacion: Rombo. Igual que R-10.
```

---

### R-14 -- TIENE_ASIGNACION

```
[SERVICIO] -- <TIENE_ASIGNACION> -- [[ASIGNACION]]
Cardinalidad: 1:N
Participacion SERVICIO: parcial (servicios en estado Pendiente pueden no tener asignacion)
Participacion ASIGNACION: total
Representacion: Rombo conecta SERVICIO con la entidad asociativa ASIGNACION.
```

---

### R-15 -- REALIZA

```
[CONDUCTOR] -- <REALIZA> -- [[ASIGNACION]]
Cardinalidad: 1:N
Participacion CONDUCTOR: parcial (puede estar disponible sin asignaciones activas)
Participacion ASIGNACION: total (toda asignacion tiene un conductor)
Representacion: Rombo entre CONDUCTOR y ASIGNACION.
```

---

### R-16 -- UTILIZA_VEHICULO

```
[VEHICULO] -- <UTILIZA_VEHICULO> -- [[ASIGNACION]]
Cardinalidad: 1:N
Participacion VEHICULO: parcial
Participacion ASIGNACION: total (toda asignacion tiene un vehiculo)
Representacion: Rombo entre VEHICULO y ASIGNACION.
```

---

### R-17 -- UTILIZA_REMOLQUE

```
[REMOLQUE] -- <UTILIZA_REMOLQUE> -- [[ASIGNACION]]
Cardinalidad: 1:N
Participacion REMOLQUE: parcial
Participacion ASIGNACION: parcial (vehiculos rigidos no necesitan remolque)
Representacion: Rombo. Ambos extremos con circulo (participacion parcial en ambos).
```

---

### R-18 -- DOCUMENTA_VEHICULO

```
[VEHICULO] -- <DOCUMENTA_VEHICULO> -- [DOCUMENTO_RECURSO]
Cardinalidad: 1:N
Participacion VEHICULO: parcial (modelado por FK opcional en DOCUMENTO_RECURSO)
Participacion DOCUMENTO_RECURSO: total (cuando el documento es de vehiculo)
Representacion: Rombo.
Nota: DOCUMENTO_RECURSO comparte entidad con R-19 y R-20. En el diagrama puede
representarse como una sola entidad DOCUMENTO_RECURSO con tres conexiones.
```

---

### R-19 -- DOCUMENTA_REMOLQUE

```
[REMOLQUE] -- <DOCUMENTA_REMOLQUE> -- [DOCUMENTO_RECURSO]
Cardinalidad: 1:N
Participacion REMOLQUE: parcial
Participacion DOCUMENTO_RECURSO: total (cuando el documento es de remolque)
Representacion: Rombo.
```

---

### R-20 -- DOCUMENTA_CONDUCTOR

```
[CONDUCTOR] -- <DOCUMENTA_CONDUCTOR> -- [DOCUMENTO_RECURSO]
Cardinalidad: 1:N
Participacion CONDUCTOR: parcial
Participacion DOCUMENTO_RECURSO: total (cuando el documento es de conductor)
Representacion: Rombo.
```

---

### R-21 -- POSEE_CATEGORIA  *** UNICA RELACION N:M DIRECTA ***

```
[CONDUCTOR] -- <POSEE_CATEGORIA> -- [CATEGORIA_PERMISO]
Cardinalidad: N:M
Participacion CONDUCTOR: TOTAL (todo conductor debe tener al menos una categoria habilitante)
Participacion CATEGORIA_PERMISO: PARCIAL (puede existir una categoria sin conductores)
Representacion: ROMBO con N en el lado CONDUCTOR y M en el lado CATEGORIA_PERMISO.
  Lado CONDUCTOR: ||---N  (doble linea = total, N = muchos)
  Lado CATEGORIA_PERMISO: M---o|  (circulo = parcial, M = muchos)

IMPORTANTE: Esta relacion se dibuja con ROMBO, no con entidad intermedia.
En FASE 3 se transformara en tabla intermedia CONDUCTOR_CATEGORIA_PERMISO.
```

Aspecto visual en el diagrama:

```
                     N                  M
[CONDUCTOR] =======<POSEE_CATEGORIA>o====== [CATEGORIA_PERMISO]
(total)         N:M - se representa con rombo   (parcial)
```

---

## 4. Entidades asociativas y transversales -- reglas especiales

### ASIGNACION (entidad asociativa)

- Se dibuja como **rectangulo con doble borde** (o rectangulo normal con nota "entidad asociativa")
- Conecta SERVICIO, CONDUCTOR, VEHICULO y REMOLQUE
- NO es un rombo porque tiene atributos propios: `fecha_asignacion`, `es_activa`, `motivo_cambio`
- El remolque es opcional (R-17 tiene participacion parcial en ASIGNACION)
- En el diagrama debe quedar en el centro inferior, con cuatro lineas que salen hacia los cuatro rectangulos

```
        [SERVICIO]
            |
      <TIENE_ASIGNACION> (rombo, 1:N)
            |
       [[ASIGNACION]]
       /    |    \
 R-15  R-16  R-17(opt)
  /      |      \
[COND.] [VEH.] [REM.]
```

### REGISTRO_AUDITORIA (entidad transversal)

- Se dibuja como rectangulo normal, **separado del resto del modelo**
- No tiene flechas que la conecten a otras entidades
- Se puede colocar en una esquina del lienzo con una nota explicativa
- Las referencias son por texto (campo `entidad_afectada`) no por FK
- Sugerencia: rodear con linea discontinua o poner comentario "Entidad transversal"

---

## 5. Distribucion recomendada del lienzo por bloques

El modelo se organiza en **5 bloques funcionales** mas una entidad transversal aislada.
Distribuir el lienzo segun este mapa evita que las lineas se crucen y facilita
dibujar el E/R de forma ordenada.

---

### 5.1 Vision global de los bloques

```
+============================+====================================+
||  BLOQUE A                 ||  BLOQUE B                        ||
||  Clientes y facturacion   ||  Nucleo operativo                ||
||                           ||                                  ||
||  [CONTACTO]  [FACTURA]    ||  [PUNTO_SERVICIO] [EVENTO_SEG.] ||
||       \       /           ||          |              |        ||
||      [CLIENTE]            ||          +---[SERVICIO]-+        ||
||       /   \               ||              (hub central)       ||
||  [DIR_OP]  ---> SERVICIO  ||                                  ||
+============================+====================================+
||  BLOQUE C                 ||  BLOQUE D                        ||
||  Carga, incidencias       ||  Recursos y asignacion           ||
||  y costes                 ||                                  ||
||                           ||  [CONDUCTOR]--R-21--[CATEG_PER.] ||
||  [MERCANCIA]              ||        |      N:M                ||
||  [REQUISITO_ESPECIAL]     ||   [[ASIGNACION]]                 ||
||  [INCIDENCIA]             ||    /    |     \                  ||
||  [COSTE_OPERATIVO]        ||  [VEH.][REM.][COND.]            ||
+============================+====================================+
||  BLOQUE E                 ||  [REGISTRO_AUDITORIA]            ||
||  Documentacion            ||  (transversal, aislado)          ||
||                           ||  Sin FK. Separado del modelo.    ||
||  [DOCUMENTO_SERVICIO]     ||                                  ||
||  [DOCUMENTO_RECURSO]      ||                                  ||
+============================+==================================++
```

Referencia rapida:
- BLOQUE A (superior izq.): CLIENTE, CONTACTO, DIRECCION_OPERATIVA, FACTURA
- BLOQUE B (superior der.): SERVICIO, PUNTO_SERVICIO, EVENTO_SEGUIMIENTO
- BLOQUE C (inferior izq.): MERCANCIA, REQUISITO_ESPECIAL, INCIDENCIA, COSTE_OPERATIVO
- BLOQUE D (inferior der.): CONDUCTOR, VEHICULO, REMOLQUE, [[ASIGNACION]], CATEGORIA_PERMISO
- BLOQUE E (fila base): DOCUMENTO_SERVICIO, DOCUMENTO_RECURSO
- TRANSVERSAL (esquina separada): REGISTRO_AUDITORIA

---

### 5.2 BLOQUE A -- Clientes y facturacion

Posicion: zona superior izquierda del lienzo

```
  [CONTACTO]             [DIRECCION_OPERATIVA]
       |                          |
    R-01 (1:N)                 R-02 (1:N)
    parc./total                parc./total
       |                          |
       +-------->[CLIENTE]<-------+
                   |      |
               R-04|      |R-03
               1:N |      | 1:N
            (p./t.)|      |(p./t.)
                   |      |
             [FACTURA]  [SERVICIO]----> (Bloque B)
                |
              R-05 (1:N)
           (total/parcial)
                |
             [SERVICIO]----> (Bloque B)
```

Notas:
- CLIENTE es el hub de este bloque: cuatro relaciones hacia fuera
- DIRECCION_OPERATIVA conecta tambien con PUNTO_SERVICIO via R-07 (desde Bloque B)
- R-03 y R-05 son las dos salidas del bloque hacia SERVICIO -- dibujar como lineas largas

---

### 5.3 BLOQUE B -- Nucleo operativo

Posicion: zona central del lienzo (SERVICIO en el centro absoluto)

```
[PUNTO_SERVICIO] <----R-06 (1:N, total/total)---- [SERVICIO]
       |                                                |
    R-07 (N:1)                                      R-08 (1:N)
  ambos parcial                                    total/total
       |                                                |
[DIRECCION_OPERATIVA]                         [EVENTO_SEGUIMIENTO]
   (en Bloque A)
```

SERVICIO recibe conexiones de entrada:
- R-03 desde CLIENTE (Bloque A)
- R-05 desde FACTURA (Bloque A)

SERVICIO lanza conexiones de salida hacia:
- R-06 PUNTO_SERVICIO, R-08 EVENTO_SEGUIMIENTO (este bloque)
- R-09 a R-13 hacia Bloques C y E
- R-14 hacia [[ASIGNACION]] (Bloque D)

Nota: colocar SERVICIO en el CENTRO DEL LIENZO. Todas las demas entidades orbitan desde el.

---

### 5.4 BLOQUE C -- Carga, incidencias y costes

Posicion: zona inferior izquierda, bajo SERVICIO

```
                  [SERVICIO] (Bloque B)
                       |
       +---------------+----------+-----------+
       |               |          |           |
     R-09            R-10       R-11        R-12
     1:N             1:N        1:N         1:N
  (total/total)  (parc./tot) (parc./tot) (parc./tot)
       |               |          |           |
 [MERCANCIA]  [REQ_ESPECIAL] [INCIDENCIA] [COSTE_OP.]
```

Notas:
- Las cuatro entidades son hojas: no conectan a nada mas
- R-09 CONTIENE_MERCANCIA: doble linea en ambos extremos (total/total)
- R-10, R-11, R-12: circulo en el extremo SERVICIO (participacion parcial en SERVICIO)
- Distribuir las cuatro entidades en fila horizontal bajo SERVICIO

---

### 5.5 BLOQUE D -- Recursos y asignacion

Posicion: zona inferior central-derecha

```
              [SERVICIO] (Bloque B)
                   |
                 R-14
                 1:N (SERVICIO parcial / ASIGNACION total)
                   |
             [[ASIGNACION]]   <-- doble borde (entidad asociativa)
             /      |      \
          R-15    R-16    R-17
          1:N      1:N    1:N
       (p./t.)  (p./t.)  (p./p.)
          |        |        |
     [CONDUCTOR] [VEHICULO] [REMOLQUE]
          |        |        |
        R-20     R-18     R-19   ------> (Bloque E, DOCUMENTO_RECURSO)


  RELACION N:M directa -- R-21 POSEE_CATEGORIA (unica N:M del modelo):

              N                              M
[CONDUCTOR] =====<POSEE_CATEGORIA>===== [CATEGORIA_PERMISO]
 (total)         rombo N:M                 (parcial)

  Extremo CONDUCTOR:       doble linea + N  (total, muchos)
  Extremo CATEGORIA_PERMISO: circulo + M    (parcial, muchos)
```

Notas:
- [[ASIGNACION]] se dibuja con DOBLE BORDE (entidad asociativa)
- R-17 UTILIZA_REMOLQUE: circulo en AMBOS extremos (parcial/parcial)
- R-21: UNICO rombo N:M del modelo -- dibujar con N y M visibles en los extremos
- CATEGORIA_PERMISO se coloca junto a CONDUCTOR (a la derecha o debajo)

---

### 5.6 BLOQUE E -- Documentacion

Posicion: zona base del lienzo, fila inferior

```
[SERVICIO] (Bloque B)
    |
  R-13 (1:N)
  SERVICIO parcial / DOCUMENTO_SERVICIO total
    |
[DOCUMENTO_SERVICIO]


[VEHICULO]  ---R-18 (1:N)---\
[REMOLQUE]  ---R-19 (1:N)----+---> [DOCUMENTO_RECURSO]
[CONDUCTOR] ---R-20 (1:N)---/

(Una sola caja DOCUMENTO_RECURSO -- tres rombos distintos que llegan desde Bloque D)
```

Notas:
- DOCUMENTO_RECURSO es UNA SOLA entidad en el diagrama, no tres cajas separadas
- Tres rombos R-18, R-19 y R-20 llegan a la misma caja desde VEHICULO, REMOLQUE y CONDUCTOR
- Anadir nota en la caja DOCUMENTO_RECURSO: "Exactamente una FK activa por registro"
- DOCUMENTO_SERVICIO es una hoja (conecta solo con SERVICIO)

---

### 5.7 REGISTRO_AUDITORIA -- Entidad transversal

Posicion: esquina del lienzo, fuera del area de los 5 bloques

```
+--------------------------------------+
|  [REGISTRO_AUDITORIA]               |
|  Entidad transversal                |
|  Sin FK directas                    |
|  Referencia otras entidades         |
|  por entidad_afectada (texto, no FK)|
+--------------------------------------+
```

Notas:
- No trazar ninguna linea de conexion desde esta entidad
- Colocar fuera del area principal con espacio visible de separacion
- Opcional: rodear con linea discontinua o poner etiqueta "Transversal"

---

### 5.8 Mapa global de referencia

```
+-- BLOQUE A ----------------------+   +-- BLOQUE B ----------------+
|  [CONTACTO]                     |   |  [PUNTO_SERVICIO]          |
|      | R-01(1:N)                |   |       | R-06(1:N)          |
|  [CLIENTE]  [FACTURA]           |   |       |          R-07(N:1) |
|   |  |   \    | R-05(1:N)      |   |   [SERVICIO] <--> [DIR_OP] |
|R-02 R-03   R-04  \             |   |       | R-08(1:N)          |
|   |   \        \  \            |   |  [EVENTO_SEG.]             |
|[DIR_OP][SERVICIO..]            |   +----------------------------+
+---------------------------------+

          [SERVICIO] (centro)
          /   |   |   |   |   \
        R-09 R-10 R-11 R-12 R-13  R-14
         |    |    |    |    |     |
       [MER][REQ][INC][COS][DOC_S] [[ASIGNACION]]
        Bloque C                   /     |     \
                                R-15   R-16  R-17(opt)
                                  |      |      |
                             [CONDUCTOR][VEH.][REMOLQUE]
                                  |      |      |
                                R-20   R-18   R-19
                                   \    |    /
                              [DOCUMENTO_RECURSO]   Bloque E

         N                              M
[CONDUCTOR] =====<POSEE_CATEGORIA>===== [CATEGORIA_PERMISO]
                 R-21 (unica N:M)

+------------------------------------------+
|  [REGISTRO_AUDITORIA] (transversal)      |
|  Sin conexiones FK. Esquina separada.    |
+------------------------------------------+
```

Abreviaturas del mapa: MER=MERCANCIA, REQ=REQUISITO_ESPECIAL, INC=INCIDENCIA,
COS=COSTE_OPERATIVO, DOC_S=DOCUMENTO_SERVICIO, DIR_OP=DIRECCION_OPERATIVA

---

## 6. Resumen de todas las relaciones por tipo

| Cod | Nombre | Entidades | Cardinalidad | Figura | Notas |
|:---:|---|---|:---:|---|---|
| R-01 | TIENE_CONTACTO | CLIENTE -- CONTACTO | 1:N | Rombo | CLIENTE parcial, CONTACTO total |
| R-02 | TIENE_DIRECCION | CLIENTE -- DIRECCION_OPERATIVA | 1:N | Rombo | CLIENTE parcial, DIR total |
| R-03 | CONTRATA | CLIENTE -- SERVICIO | 1:N | Rombo | CLIENTE parcial, SERVICIO total |
| R-04 | EMITIDA_A | CLIENTE -- FACTURA | 1:N | Rombo | CLIENTE parcial, FACTURA total |
| R-05 | AGRUPA_SERVICIOS | FACTURA -- SERVICIO | 1:N | Rombo | FACTURA total, SERVICIO parcial |
| R-06 | TIENE_PUNTO | SERVICIO -- PUNTO_SERVICIO | 1:N | Rombo | Ambos total |
| R-07 | REFERENCIA_DIRECCION | PUNTO_SERVICIO -- DIRECCION_OPERATIVA | N:1 | Rombo | Ambos parcial |
| R-08 | REGISTRA_EVENTO | SERVICIO -- EVENTO_SEGUIMIENTO | 1:N | Rombo | Ambos total |
| R-09 | CONTIENE_MERCANCIA | SERVICIO -- MERCANCIA | 1:N | Rombo | Ambos total |
| R-10 | REQUIERE_CONDICION | SERVICIO -- REQUISITO_ESPECIAL | 1:N | Rombo | SERVICIO parcial |
| R-11 | GENERA_INCIDENCIA | SERVICIO -- INCIDENCIA | 1:N | Rombo | SERVICIO parcial |
| R-12 | GENERA_COSTE | SERVICIO -- COSTE_OPERATIVO | 1:N | Rombo | SERVICIO parcial |
| R-13 | TIENE_DOCUMENTO_SERVICIO | SERVICIO -- DOCUMENTO_SERVICIO | 1:N | Rombo | SERVICIO parcial |
| R-14 | TIENE_ASIGNACION | SERVICIO -- ASIGNACION | 1:N | Rombo | SERVICIO parcial |
| R-15 | REALIZA | CONDUCTOR -- ASIGNACION | 1:N | Rombo | CONDUCTOR parcial |
| R-16 | UTILIZA_VEHICULO | VEHICULO -- ASIGNACION | 1:N | Rombo | VEHICULO parcial |
| R-17 | UTILIZA_REMOLQUE | REMOLQUE -- ASIGNACION | 1:N | Rombo | Ambos parcial |
| R-18 | DOCUMENTA_VEHICULO | VEHICULO -- DOCUMENTO_RECURSO | 1:N | Rombo | VEHICULO parcial |
| R-19 | DOCUMENTA_REMOLQUE | REMOLQUE -- DOCUMENTO_RECURSO | 1:N | Rombo | REMOLQUE parcial |
| R-20 | DOCUMENTA_CONDUCTOR | CONDUCTOR -- DOCUMENTO_RECURSO | 1:N | Rombo | CONDUCTOR parcial |
| **R-21** | **POSEE_CATEGORIA** | **CONDUCTOR -- CATEGORIA_PERMISO** | **N:M** | **Rombo** | **CONDUCTOR total, CATEGORIA parcial** |

---

## 7. Instrucciones para draw.io paso a paso

### Paso 1: Preparar el lienzo
- Abrir draw.io (app.diagrams.net) > Nuevo > En blanco
- Activar formas ER: More Shapes > Entity Relation
- Tamanio de lienzo recomendado: A2 horizontal

### Paso 2: Crear las 19 entidades (rectangulos)
- Usar forma "Entity" para cada entidad
- Nombre de la entidad en la cabecera (negrita)
- Listar atributos principales dentro
- Subrayar o marcar la PK (atributo clave)
- ASIGNACION: usar doble borde o anotar "entidad asociativa"
- CATEGORIA_PERMISO: anotar "catalogo" o usar color diferente
- REGISTRO_AUDITORIA: colocar separado con nota "Transversal"

### Paso 3: Crear los 21 rombos (relaciones)
- Usar forma "Relation" (rombo) para cada relacion
- Escribir el nombre de la relacion dentro del rombo
- Conectar con lineas a las dos entidades
- En cada extremo de la linea marcar la cardinalidad (1, N, M)
- Para participacion total: doble linea o marca ||
- Para participacion parcial: circulo o O en el extremo

### Paso 4: La N:M POSEE_CATEGORIA (R-21)
- Dibujar un rombo entre CONDUCTOR y CATEGORIA_PERMISO
- Dentro del rombo: "POSEE_CATEGORIA"
- Lado CONDUCTOR: marcar N con doble linea (total)
- Lado CATEGORIA_PERMISO: marcar M con circulo (parcial)
- Esta es la UNICA N:M directa del modelo

### Paso 5: ASIGNACION y sus conexiones
- Colocar ASIGNACION en el centro-inferior del lienzo
- Conectar con rombo TIENE_ASIGNACION desde SERVICIO
- Conectar con rombo REALIZA desde CONDUCTOR
- Conectar con rombo UTILIZA_VEHICULO desde VEHICULO
- Conectar con rombo UTILIZA_REMOLQUE desde REMOLQUE (linea discontinua o circulo = opcional)

### Paso 6: DOCUMENTO_RECURSO
- Una sola caja DOCUMENTO_RECURSO
- Conectar con tres rombos separados: DOCUMENTA_VEHICULO, DOCUMENTA_REMOLQUE, DOCUMENTA_CONDUCTOR
- Anadir nota: "Exactamente una de las tres FK tiene valor por registro"

### Paso 7: Exportar
- Exportar como PNG (fondo blanco, alta resolucion)
- Guardar .drawio en borradores/
- Copiar PNG a /diagramas/modelo_conceptual.png
