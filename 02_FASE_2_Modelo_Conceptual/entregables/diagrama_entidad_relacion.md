# Diagrama E/R -- Representacion Textual

**Proyecto:** Diseno, creacion y explotacion de una base de datos para la gestion integral
de una empresa de transporte intracomunitario por carretera (UE) en MySQL (phpMyAdmin)
**Fase:** 2 - Modelo Conceptual
**Modulo:** Proyecto 2 DAM - Centro FP Maria Auxiliadora - Curso 2023-24

> Representacion textual del Diagrama Entidad-Relacion. Sirve como guia directa
> para construir el diagrama en draw.io o diagrams.net.

---

## 1. Entidades con sus atributos principales

```
Area: Clientes y terceros
+--------------------+   +--------------------+   +----------------------+
|      CLIENTE       |   |     CONTACTO       |   | DIRECCION_OPERATIVA  |
+--------------------+   +--------------------+   +----------------------+
| PK id_cliente      |   | PK id_contacto     |   | PK id_direccion      |
| nombre_rs *        |   | nombre *           |   | descripcion          |
| cif_nif * [U]      |   | apellidos *        |   | direccion *          |
| pais *             |   | cargo              |   | ciudad *             |
| ciudad             |   | telefono           |   | pais *               |
| direccion_sede     |   | email              |   | telefono             |
| telefono           |   | es_principal *     |   | horario              |
| email              |   | FK id_cliente      |   | activa *             |
| condiciones_pago   |   +--------------------+   | FK id_cliente        |
| activo *           |                            +----------------------+
+--------------------+

Area: Servicios y seguimiento
+--------------------+   +--------------------+   +----------------------+
|     SERVICIO       |   |  PUNTO_SERVICIO    |   | EVENTO_SEGUIMIENTO   |
+--------------------+   +--------------------+   +----------------------+
| PK id_servicio     |   | PK id_punto        |   | PK id_evento         |
| numero_servicio * [U] | | tipo *            |   | tipo_evento *        |
| fecha_solicitud *  |   | orden *            |   | descripcion *        |
| fecha_prev_recog * |   | direccion *        |   | fecha_hora *         |
| tipo_servicio *    |   | ciudad *           |   | estado_resultante *  |
| nivel_urgencia *   |   | pais *             |   | usuario_resp. *      |
| estado_actual *    |   | ventana_inicio     |   | observaciones        |
| doc_completa *     |   | ventana_fin        |   | FK id_servicio       |
| observaciones      |   | fecha_ejec_real    |   +----------------------+
| FK id_cliente      |   | estado *           |
| FK id_factura      |   | observaciones      |
+--------------------+   | FK id_servicio     |
                         | FK id_direccion    | (opt)
                         +--------------------+

Area: Mercancia y requisitos
+--------------------+   +--------------------+
|     MERCANCIA      |   | REQUISITO_ESPECIAL |
+--------------------+   +--------------------+
| PK id_mercancia    |   | PK id_requisito    |
| descripcion *      |   | tipo *             |
| tipo_carga *       |   | descripcion *      |
| num_bultos_palets  |   | temperatura_min    |
| peso_kg            |   | temperatura_max    |
| volumen_m3         |   | instrucciones      |
| valor_declarado    |   | verif_obligat. *   |
| observaciones      |   | FK id_servicio     |
| FK id_servicio     |   +--------------------+
+--------------------+

Area: Incidencias
+--------------------+
|     INCIDENCIA     |
+--------------------+
| PK id_incidencia   |
| tipo *             |
| descripcion *      |
| fecha_apertura *   |
| prioridad *        |
| estado *           |
| fecha_ultima_act.  |
| responsable_gest.  |
| fecha_cierre       |
| desc_resolucion    |
| genera_coste * |
| FK id_servicio     |
+--------------------+

Area: Recursos
+--------------------+   +--------------------+   +--------------------+
|     VEHICULO       |   |     REMOLQUE       |   |     CONDUCTOR      |
+--------------------+   +--------------------+   +--------------------+
| PK id_vehiculo     |   | PK id_remolque     |   | PK id_conductor    |
| matricula * [U]    |   | matricula * [U]    |   | numero_empleado *  |
| tipo *             |   | tipo *             |   | nombre *           |
| marca              |   | capacidad_kg       |   | apellidos *        |
| modelo             |   | longitud_m         |   | fecha_nacimiento   |
| anio_matr.         |   | apto_temperatura   |   | telefono           |
| capacidad_kg       |   | estado_operativo * |   | email              |
| estado_operativo * |   +--------------------+   | num_permiso * [U]  |
+--------------------+                            | categ_permiso *    |
                                                  | estado_dispon. *   |
+----------------------------------------------+  +--------------------+
|                  ASIGNACION                  |
| (entidad asociativa)                         |
+----------------------------------------------+
| PK id_asignacion                             |
| fecha_asignacion *                           |
| es_activa *                                  |
| motivo_cambio                                |
| observaciones                                |
| FK id_servicio *                             |
| FK id_conductor *                            |
| FK id_vehiculo *                             |
| FK id_remolque (opcional)                    |
+----------------------------------------------+

Area: Costes operativos
+--------------------+
|  COSTE_OPERATIVO   |
+--------------------+
| PK id_coste        |
| tipo_coste *       |
| importe *          |
| fecha *            |
| descripcion        |
| justificante *     |
| FK id_servicio     |
+--------------------+

Area: Facturacion y cobros
+--------------------+
|      FACTURA       |
+--------------------+
| PK id_factura      |
| numero_factura * [U] |
| fecha_emision *    |
| fecha_vencimiento *|
| importe_base *     |
| porcentaje_iva *   |
| importe_total *    |
| estado_cobro *     |
| fecha_cobro        |
| metodo_cobro       |
| FK id_cliente      |
+--------------------+

Area: Documentacion y control interno
+--------------------+   +--------------------+   +--------------------+
| DOCUMENTO_SERVICIO |   | DOCUMENTO_RECURSO  |   | REGISTRO_AUDITORIA |
+--------------------+   +--------------------+   +--------------------+
| PK id_doc_srv      |   | PK id_doc_rec      |   | PK id_auditoria    |
| tipo_documento *   |   | tipo_documento *   |   | tipo_operacion *   |
| descripcion        |   | numero_documento   |   | entidad_afectada * |
| fecha_documento *  |   | fecha_emision      |   | id_reg_afectado *  |
| recibido *         |   | fecha_caducidad *  |   | usuario *          |
| fecha_recepcion    |   | organismo_emisor   |   | fecha_hora *       |
| referencia_archivo |   | referencia_archivo |   | descripcion        |
| FK id_servicio     |   | FK id_vehiculo (opt)|  +--------------------+
+--------------------+   | FK id_remolque (opt)|
                         | FK id_conductor(opt)|
                         +--------------------+

(*) = atributo obligatorio
[U] = atributo con restriccion de unicidad
(opt) = FK opcional (exactamente una de las tres con valor)
```

---

## 2. Diagrama de relaciones con cardinalidades

```
Notacion utilizada:
  ||---   participacion total, lado uno
  o|---   participacion parcial, lado uno
  ---||   participacion total, lado uno (lado derecho)
  ---<    lado muchos (crow's foot)
  ---o<   lado muchos con participacion parcial en ese extremo

                      R-01 (1:N, CONTACTO total)
CLIENTE ||---TIENE_CONTACTO---< CONTACTO

                      R-02 (1:N, DIRECCION total)
CLIENTE ||---TIENE_DIRECCION---< DIRECCION_OPERATIVA

                      R-03 (1:N, SERVICIO total)
CLIENTE o|---CONTRATA---< SERVICIO

                      R-04 (1:N, FACTURA total)
CLIENTE o|---EMITIDA_A---< FACTURA

                      R-05 (1:N, SERVICIO parcial)
FACTURA ||---SE_FACTURA_EN---o< SERVICIO

                      R-06 (1:N, ambos total)
SERVICIO ||---TIENE_PUNTO---< PUNTO_SERVICIO

                      R-07 (N:1, ambos parciales)
PUNTO_SERVICIO o|---REFERENCIA_DIRECCION---o|| DIRECCION_OPERATIVA

                      R-08 (1:N, EVENTO total)
SERVICIO ||---TIENE_EVENTO---< EVENTO_SEGUIMIENTO

                      R-09 (1:1, ambos total)
SERVICIO ||---DESCRIBE_CARGA---|| MERCANCIA

                      R-10 (1:N, REQUISITO total, SERVICIO parcial)
SERVICIO o|---TIENE_REQUISITO---< REQUISITO_ESPECIAL

                      R-11 (1:N, INCIDENCIA total, SERVICIO parcial)
SERVICIO o|---GENERA_INCIDENCIA---< INCIDENCIA

                      R-12 (1:N, COSTE total, SERVICIO parcial)
SERVICIO o|---GENERA_COSTE---< COSTE_OPERATIVO

                      R-13 (1:N, DOCUMENTO_SERVICIO total, SERVICIO parcial)
SERVICIO o|---TIENE_DOCUMENTO---< DOCUMENTO_SERVICIO

                      R-14 (1:N, ASIGNACION total, SERVICIO parcial)
SERVICIO o|---TIENE_ASIGNACION---< ASIGNACION

                      R-15 (1:N, ASIGNACION total, CONDUCTOR parcial)
CONDUCTOR o|---REALIZA---< ASIGNACION

                      R-16 (1:N, ASIGNACION total, VEHICULO parcial)
VEHICULO o|---UTILIZA_VEHICULO---< ASIGNACION

                      R-17 (1:N, ambos parciales)
REMOLQUE o|---UTILIZA_REMOLQUE---o< ASIGNACION

                      R-18 (1:N, DOCUMENTO_RECURSO total cuando es de vehiculo)
VEHICULO ||---DOCUMENTA_VEHICULO---< DOCUMENTO_RECURSO

                      R-19 (1:N, DOCUMENTO_RECURSO total cuando es de remolque)
REMOLQUE ||---DOCUMENTA_REMOLQUE---< DOCUMENTO_RECURSO

                      R-20 (1:N, DOCUMENTO_RECURSO total cuando es de conductor)
CONDUCTOR ||---DOCUMENTA_CONDUCTOR---< DOCUMENTO_RECURSO
```

---

## 3. Mapa global del modelo

```
             [CONTACTO]    [DIRECCION_OPERATIVA]
                 |  R-01               |  R-02
                 |  1:N                |  1:N
                 |                     |
[FACTURA]--R-04--[CLIENTE]--R-03--[SERVICIO]--R-06--[PUNTO_SERVICIO]
    |       1:N       |        1:N         |   1:N        |   1:N
    |                 |                    |              |
    +--R-05--< incluye N servicios         |         R-07 (opt)
        1:N                                |         N:1
                                           |
                                     R-08  | 
                                     1:N   |
                                           |
                                  [EVENTO_SEGUIMIENTO]
                                           |
                                           +--R-09--[MERCANCIA]
                                           |   1:1
                                           |
                                           +--R-10--< [REQUISITO_ESPECIAL]
                                           |   1:N
                                           |
                                           +--R-11--< [INCIDENCIA]
                                           |   1:N
                                           |
                                           +--R-12--< [COSTE_OPERATIVO]
                                           |   1:N
                                           |
                                           +--R-13--< [DOCUMENTO_SERVICIO]
                                           |   1:N
                                           |
                                           +--R-14--< [ASIGNACION]
                                               1:N
                                                 |
                                  +--------------+--------------+
                                  |              |              |
                               R-15           R-16         R-17 (opt)
                               1:N            1:N             1:N
                                  |              |              |
                             [CONDUCTOR]     [VEHICULO]     [REMOLQUE]
                                  |              |              |
                               R-20           R-18           R-19
                               1:N            1:N            1:N
                                  |              |              |
                         [DOCUMENTO_RECURSO] [DOCUMENTO_RECURSO] [DOCUMENTO_RECURSO]
                            (conductor)         (vehículo)         (remolque)

[REGISTRO_AUDITORIA] -- Entidad transversal: registra operaciones y cambios relevantes sobre cualquier entidad del sistema
```

---

## 4. Instrucciones paso a paso para draw.io

### Paso 1 -- Preparar el entorno
- Abrir draw.io (app.diagrams.net)
- Nuevo diagrama > En blanco
- Activar formas Entity Relation: Format > Shapes > Entity Relation

### Paso 2 -- Distribucion recomendada del lienzo

```
Fila superior:     CLIENTE -- CONTACTO -- DIRECCION_OPERATIVA -- FACTURA
Fila central:                          SERVICIO (en el centro)
Bloque derecho:    PUNTO_SERVICIO -- EVENTO_SEGUIMIENTO
Bloque izquierdo:  MERCANCIA -- REQUISITO_ESPECIAL -- INCIDENCIA
                   COSTE_OPERATIVO -- DOCUMENTO_SERVICIO
Fila inferior:     CONDUCTOR -- ASIGNACION -- VEHICULO -- REMOLQUE
Fila base:                        DOCUMENTO_RECURSO (x3 instancias)
Esquina:           REGISTRO_AUDITORIA (separado, entidad transversal)
```

### Paso 3 -- Crear las entidades
Para cada entidad del diccionario_entidades.md:
- Insertar una forma Entity (Entity Relation)
- Rellenar con los atributos del diccionario
- Subrayar la PK
- Marcar atributos [oblig] con asterisco o negrita segun preferencia del evaluador

### Paso 4 -- Trazar las relaciones con notacion crow's foot
Para cada relacion del diccionario_relaciones.md:
- Trazar la linea entre entidades
- Lado "1" total: doble barra vertical ||
- Lado "1" parcial: circulo y barra o|
- Lado "N": crow's foot (tres lineas en abanico)
- Lado "N" parcial: crow's foot con circulo o<
- Etiquetar la linea con el nombre de la relacion (R-01 a R-20)

### Paso 5 -- Notas especiales
- ASIGNACION debe quedar en el centro conectando SERVICIO, CONDUCTOR, VEHICULO y REMOLQUE
- DOCUMENTO_RECURSO puede representarse como una sola entidad conectada a las tres
  entidades de recurso, con nota aclaratoria sobre las FK opcionales
- REGISTRO_AUDITORIA se conecta con una linea discontinua o se coloca con una nota
  indicando que es transversal al sistema

### Paso 6 -- Exportar
- Exportar como PNG con fondo blanco (alta resolucion)
- Guardar el archivo .drawio en la carpeta borradores/ del repositorio
- Copiar el PNG a /diagramas/modelo_conceptual.png del repositorio
