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

<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=5,IE=9" ><![endif]-->
<!DOCTYPE html>
<html>
<head>
<title>ER.html</title>
<meta charset="utf-8"/>
</head>
<body>
<div class="mxgraph" style="max-width:100%;border:1px solid transparent;" data-mxgraph="{&quot;highlight&quot;:&quot;#0000ff&quot;,&quot;nav&quot;:true,&quot;resize&quot;:true,&quot;xml&quot;:&quot;&lt;mxfile host=\&quot;app.diagrams.net\&quot;&gt;&lt;diagram name=\&quot;Página-1\&quot; id=\&quot;edhCZ15y6NKdUqKztVfU\&quot;&gt;&lt;mxGraphModel dx=\&quot;1338\&quot; dy=\&quot;765\&quot; grid=\&quot;1\&quot; gridSize=\&quot;10\&quot; guides=\&quot;1\&quot; tooltips=\&quot;1\&quot; connect=\&quot;1\&quot; arrows=\&quot;1\&quot; fold=\&quot;1\&quot; page=\&quot;1\&quot; pageScale=\&quot;1\&quot; pageWidth=\&quot;827\&quot; pageHeight=\&quot;1169\&quot; math=\&quot;0\&quot; shadow=\&quot;0\&quot;&gt;&lt;root&gt;&lt;mxCell id=\&quot;0\&quot;/&gt;&lt;mxCell id=\&quot;1\&quot; parent=\&quot;0\&quot;/&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-1\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;CONTACTO\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;120\&quot; x=\&quot;340\&quot; y=\&quot;370\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-2\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;DIRECCIÓN&amp;lt;br&amp;gt;OPERATIVA\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;120\&quot; x=\&quot;670\&quot; y=\&quot;370\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-3\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-1\&quot; style=\&quot;endArrow=classic;html=1;rounded=0;exitX=0.5;exitY=1;exitDx=0;exitDy=0;entryX=0.5;entryY=0;entryDx=0;entryDy=0;\&quot; target=\&quot;-cXPDa8QdQueRM5cQc8K-5\&quot; value=\&quot;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint x=\&quot;600\&quot; y=\&quot;530\&quot; as=\&quot;sourcePoint\&quot;/&gt;&lt;mxPoint x=\&quot;400\&quot; y=\&quot;540\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-4\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-3\&quot; style=\&quot;edgeLabel;resizable=0;html=1;;align=center;verticalAlign=middle;\&quot; value=\&quot;R-01&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-8\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-5\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint x=\&quot;230\&quot; y=\&quot;585\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-9\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-8\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-04&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;0.1091\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-35\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-5\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;Array as=\&quot;points\&quot;&gt;&lt;mxPoint x=\&quot;400\&quot; y=\&quot;710\&quot;/&gt;&lt;mxPoint x=\&quot;400\&quot; y=\&quot;710\&quot;/&gt;&lt;/Array&gt;&lt;mxPoint x=\&quot;230\&quot; y=\&quot;710\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-5\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;CLIENTE\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;120\&quot; x=\&quot;340\&quot; y=\&quot;555\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-11\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-10\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint x=\&quot;170\&quot; y=\&quot;680\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-12\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-11\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-05\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;-0.2\&quot; y=\&quot;2\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-10\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;FACTURA\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;120\&quot; x=\&quot;110\&quot; y=\&quot;555\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-18\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-13\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;entryX=0.5;entryY=1;entryDx=0;entryDy=0;\&quot; target=\&quot;-cXPDa8QdQueRM5cQc8K-10\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-19\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-18\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-05&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;0.2\&quot; y=\&quot;-3\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-33\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-13\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;entryX=0.5;entryY=1;entryDx=0;entryDy=0;\&quot; target=\&quot;-cXPDa8QdQueRM5cQc8K-5\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-36\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-33\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;INCLUYE N SERVICIOS\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;0.283\&quot; y=\&quot;-1\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint y=\&quot;1\&quot; as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-13\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;INCLUYE N&amp;lt;div&amp;gt;SERVICIOS&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;120\&quot; x=\&quot;110\&quot; y=\&quot;680\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-20\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-5\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;exitX=1;exitY=0.5;exitDx=0;exitDy=0;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint x=\&quot;470\&quot; y=\&quot;580\&quot; as=\&quot;sourcePoint\&quot;/&gt;&lt;mxPoint x=\&quot;740\&quot; y=\&quot;585\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-21\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-20\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-03&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;0.0897\&quot; y=\&quot;-1\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-14\&quot; parent=\&quot;1\&quot; style=\&quot;shape=umlActor;verticalLabelPosition=bottom;verticalAlign=top;html=1;outlineConnect=0;\&quot; value=\&quot;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;30\&quot; width=\&quot;10\&quot; x=\&quot;440\&quot; y=\&quot;570\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-17\&quot; parent=\&quot;1\&quot; style=\&quot;shape=umlActor;verticalLabelPosition=bottom;verticalAlign=top;html=1;outlineConnect=0;\&quot; value=\&quot;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;30\&quot; width=\&quot;10\&quot; x=\&quot;440\&quot; y=\&quot;385\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-25\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-22\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint x=\&quot;930\&quot; y=\&quot;585\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-26\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-25\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-06&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;0.0462\&quot; y=\&quot;2\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint x=\&quot;1\&quot; as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-38\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-22\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;Array as=\&quot;points\&quot;&gt;&lt;mxPoint x=\&quot;740\&quot; y=\&quot;830\&quot;/&gt;&lt;/Array&gt;&lt;mxPoint x=\&quot;210\&quot; y=\&quot;880\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-50\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-38\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-09&amp;lt;div&amp;gt;1:1&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;0.922\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-40\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-22\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;Array as=\&quot;points\&quot;&gt;&lt;mxPoint x=\&quot;740\&quot; y=\&quot;830\&quot;/&gt;&lt;/Array&gt;&lt;mxPoint x=\&quot;380\&quot; y=\&quot;880\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-51\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-40\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-10&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;0.8944\&quot; y=\&quot;-2\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-42\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-22\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;entryX=0.5;entryY=0;entryDx=0;entryDy=0;\&quot; target=\&quot;-cXPDa8QdQueRM5cQc8K-43\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;Array as=\&quot;points\&quot;&gt;&lt;mxPoint x=\&quot;740\&quot; y=\&quot;830\&quot;/&gt;&lt;mxPoint x=\&quot;570\&quot; y=\&quot;830\&quot;/&gt;&lt;/Array&gt;&lt;mxPoint x=\&quot;520\&quot; y=\&quot;880\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-52\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-42\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-11&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;0.8529\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-44\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-22\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint x=\&quot;740\&quot; y=\&quot;880\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-54\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-44\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-12&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;0.7811\&quot; y=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-46\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-22\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;Array as=\&quot;points\&quot;&gt;&lt;mxPoint x=\&quot;740\&quot; y=\&quot;830\&quot;/&gt;&lt;/Array&gt;&lt;mxPoint x=\&quot;910\&quot; y=\&quot;880\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-55\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-46\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-13&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;0.8667\&quot; y=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-48\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-22\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;Array as=\&quot;points\&quot;&gt;&lt;mxPoint x=\&quot;740\&quot; y=\&quot;830\&quot;/&gt;&lt;/Array&gt;&lt;mxPoint x=\&quot;1070\&quot; y=\&quot;880\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-56\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-48\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-14&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;0.8992\&quot; y=\&quot;3\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-22\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;SERVICIO\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;120\&quot; x=\&quot;680\&quot; y=\&quot;555\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-23\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-2\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;entryX=0.417;entryY=0.083;entryDx=0;entryDy=0;entryPerimeter=0;\&quot; target=\&quot;-cXPDa8QdQueRM5cQc8K-22\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-24\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-23\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-02&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;-0.1841\&quot; y=\&quot;-3\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint y=\&quot;1\&quot; as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-28\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-27\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint x=\&quot;990\&quot; y=\&quot;670\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-30\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-28\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;&amp;lt;br&amp;gt;&amp;lt;div&amp;gt;R-07&amp;lt;/div&amp;gt;&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;-0.2\&quot; y=\&quot;-4\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint y=\&quot;-1\&quot; as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-27\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;PUNTO&amp;lt;div&amp;gt;SERVICIO&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;120\&quot; x=\&quot;930\&quot; y=\&quot;555\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-29\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;DIRECCIÓN&amp;lt;div&amp;gt;OPERATIVA&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;120\&quot; x=\&quot;930\&quot; y=\&quot;672\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-39\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;MERCANCIA\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;120\&quot; x=\&quot;150\&quot; y=\&quot;880\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-41\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;REQUISITO&amp;lt;div&amp;gt;ESPECIAL&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;120\&quot; x=\&quot;320\&quot; y=\&quot;880\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-43\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;INCIDENCIA\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;120\&quot; x=\&quot;510\&quot; y=\&quot;880\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-45\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;COSTE&amp;lt;div&amp;gt;OPERATIVO&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;120\&quot; x=\&quot;680\&quot; y=\&quot;880\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-47\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;DOCUMENTO&amp;lt;div&amp;gt;SERVICIO&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;120\&quot; x=\&quot;850\&quot; y=\&quot;880\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-57\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-49\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;Array as=\&quot;points\&quot;&gt;&lt;mxPoint x=\&quot;1070\&quot; y=\&quot;1000\&quot;/&gt;&lt;/Array&gt;&lt;mxPoint x=\&quot;920\&quot; y=\&quot;1060\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-67\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-57\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-15&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;0.7185\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-58\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-49\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint x=\&quot;1070\&quot; y=\&quot;1060\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-68\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-58\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-16&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;0.3\&quot; y=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-59\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-49\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;Array as=\&quot;points\&quot;&gt;&lt;mxPoint x=\&quot;1070\&quot; y=\&quot;1000\&quot;/&gt;&lt;mxPoint x=\&quot;1220\&quot; y=\&quot;1000\&quot;/&gt;&lt;mxPoint x=\&quot;1220\&quot; y=\&quot;1060\&quot;/&gt;&lt;/Array&gt;&lt;mxPoint x=\&quot;1220\&quot; y=\&quot;1060\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-69\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-59\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-17&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;0.6889\&quot; y=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-49\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;ASIGNACION\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;120\&quot; x=\&quot;1010\&quot; y=\&quot;880\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-64\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-60\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;Array as=\&quot;points\&quot;&gt;&lt;mxPoint x=\&quot;920\&quot; y=\&quot;1160\&quot;/&gt;&lt;/Array&gt;&lt;mxPoint x=\&quot;1070\&quot; y=\&quot;1200\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-72\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-64\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-20&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;-0.8348\&quot; y=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-60\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;CONDUCTOR\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;120\&quot; x=\&quot;860\&quot; y=\&quot;1060\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-63\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-61\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint x=\&quot;1070\&quot; y=\&quot;1200\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-70\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-63\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-18&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;-0.45\&quot; y=\&quot;2\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-61\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;VEHICULO\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;120\&quot; x=\&quot;1010\&quot; y=\&quot;1060\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-65\&quot; edge=\&quot;1\&quot; parent=\&quot;1\&quot; source=\&quot;-cXPDa8QdQueRM5cQc8K-62\&quot; style=\&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; as=\&quot;geometry\&quot;&gt;&lt;Array as=\&quot;points\&quot;&gt;&lt;mxPoint x=\&quot;1220\&quot; y=\&quot;1160\&quot;/&gt;&lt;/Array&gt;&lt;mxPoint x=\&quot;1070\&quot; y=\&quot;1200\&quot; as=\&quot;targetPoint\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-71\&quot; connectable=\&quot;0\&quot; parent=\&quot;-cXPDa8QdQueRM5cQc8K-65\&quot; style=\&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];\&quot; value=\&quot;R-19&amp;lt;div&amp;gt;1:N&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry relative=\&quot;1\&quot; x=\&quot;-0.8261\&quot; y=\&quot;2\&quot; as=\&quot;geometry\&quot;&gt;&lt;mxPoint as=\&quot;offset\&quot;/&gt;&lt;/mxGeometry&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-62\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;REMOLQUE\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;120\&quot; x=\&quot;1160\&quot; y=\&quot;1060\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-66\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;DOCUMENTO&amp;lt;div&amp;gt;RECURSO&amp;lt;/div&amp;gt;&amp;lt;div&amp;gt;(conductor, vehiculo, remolque)&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;180\&quot; x=\&quot;980\&quot; y=\&quot;1200\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;mxCell id=\&quot;-cXPDa8QdQueRM5cQc8K-73\&quot; parent=\&quot;1\&quot; style=\&quot;rounded=0;whiteSpace=wrap;html=1;\&quot; value=\&quot;REGISTRO AUDITORIA&amp;lt;div&amp;gt;(ENTIDAD TRANVERSAL: REGISTRA OPERACIONES Y CAMBIOS RELEVANTES SOBRE CUALQUIER ENTIDAD DEL SISTEMA)&amp;lt;/div&amp;gt;\&quot; vertex=\&quot;1\&quot;&gt;&lt;mxGeometry height=\&quot;60\&quot; width=\&quot;1160\&quot; x=\&quot;150\&quot; y=\&quot;1280\&quot; as=\&quot;geometry\&quot;/&gt;&lt;/mxCell&gt;&lt;/root&gt;&lt;/mxGraphModel&gt;&lt;/diagram&gt;&lt;/mxfile&gt;&quot;,&quot;toolbar&quot;:&quot;pages zoom layers lightbox&quot;,&quot;page&quot;:0}"></div>
<script type="text/javascript" src="https://app.diagrams.net/js/viewer-static.min.js"></script>
</body>
</html>

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
