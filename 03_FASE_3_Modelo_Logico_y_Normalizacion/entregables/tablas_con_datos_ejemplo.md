# Tablas con Datos de Ejemplo

**Proyecto:** Diseño, creación y explotación de una base de datos para la gestión integral
de una empresa de transporte intracomunitario por carretera (UE) en MySQL (phpMyAdmin)
**Fase:** 3 - Modelo Lógico y Normalización
**Módulo:** Proyecto 2 DAM - Centro FP María Auxiliadora - Curso 2024-26

---

## Propósito y criterios de los datos de ejemplo

Los datos de este documento tienen como finalidad **demostrar** la coherencia del modelo
relacional, la correcta resolución de las relaciones entre tablas y la ausencia de
redundancias características de un esquema normalizado en 3FN.

**Criterios aplicados:**
- Todos los valores de claves foráneas referencian registros existentes en este documento.
- Los datos son realistas y coherentes con el dominio del transporte internacional EU.
- Se incluyen escenarios variados: servicios FTL y LTL, servicios con y sin incidencias,
  facturas cobradas y pendientes, documentos de recursos vigentes y próximos a caducar.
- No se incluye SQL ni sentencias de inserción; los datos se presentan exclusivamente
  en formato tabla Markdown.

**Escenario narrativo:**
- **3 clientes:** una empresa textil española, un distribuidor farmacéutico alemán y
  una empresa de alimentación francesa.
- **3 servicios activos:** uno FTL cerrado y facturado, uno urgente en tránsito con
  control de temperatura, uno LTL con incidencia resuelta.
- **2 vehículos y 2 remolques** de la flota propia.
- **2 conductores** en plantilla.

---

## Área 1 — Clientes y terceros

### CLIENTE

| id_cliente | nombre_razon_social | cif_nif | pais | ciudad | direccion_sede | telefono | email | condiciones_pago | activo |
|:---:|---|---|---|---|---|---|---|---|:---:|
| 1 | Industrias Textiles Lenz S.L. | B-28441029 | España | Zaragoza | Av. de la Hispanidad 45, 50012 | +34 976 441 200 | logistica@lenz.es | 30 días fin de mes | TRUE |
| 2 | Pharma Distribution GmbH | DE298741003 | Alemania | München | Industriestraße 82, 80339 | +49 89 3214 8800 | transport@pharmadist.de | 60 días fecha factura | TRUE |
| 3 | Boulangerie Du Nord SARL | FR75812034521 | Francia | Lille | Rue des Moulins 12, 59800 | +33 3 2045 1100 | achats@boulangerie-nord.fr | 45 días fin de mes | TRUE |

---

### CONTACTO

| id_contacto | id_cliente | nombre | apellidos | cargo | telefono | email | es_principal |
|:---:|:---:|---|---|---|---|---|:---:|
| 1 | 1 | Marta | Serrano Blanco | Responsable de Logística | +34 616 200 110 | m.serrano@lenz.es | TRUE |
| 2 | 1 | Jordi | Puig Roca | Director de Compras | +34 616 200 120 | j.puig@lenz.es | FALSE |
| 3 | 2 | Klaus | Hoffmann | Supply Chain Manager | +49 173 4512 8800 | k.hoffmann@pharmadist.de | TRUE |
| 4 | 3 | Amélie | Renard | Responsable Achats | +33 6 7800 4412 | a.renard@boulangerie-nord.fr | TRUE |

---

### DIRECCION_OPERATIVA

| id_direccion | id_cliente | descripcion | direccion | ciudad | pais | telefono | horario | activa |
|:---:|:---:|---|---|---|---|---|---|:---:|
| 1 | 1 | Almacén Central Zaragoza | Pol. Ind. Malpica, C/ Río Ebro 8, 50016 | Zaragoza | España | +34 976 441 201 | L-V 07:00-20:00 | TRUE |
| 2 | 1 | Planta de Producción Barcelona | C/ Pallars 112, Nave 3, 08018 | Barcelona | España | +34 932 210 800 | L-V 06:00-22:00 | TRUE |
| 3 | 2 | Centro de Distribución München | Landsberger Str. 300, 80687 | München | Alemania | +49 89 3214 8810 | L-V 06:00-18:00 | TRUE |
| 4 | 3 | Depósito Lille | Zone Industrielle des Près, Rue Lavoisier 5, 59650 | Villeneuve d'Ascq | Francia | +33 3 2054 2200 | L-S 05:00-14:00 | TRUE |

---

## Área 7 — Facturación y cobros

> Se define FACTURA antes que SERVICIO porque SERVICIO referencia opcionalmente a FACTURA.

### FACTURA

| id_factura | id_cliente | numero_factura | fecha_emision | fecha_vencimiento | importe_base | porcentaje_iva | importe_total | estado_cobro | fecha_cobro | metodo_cobro |
|:---:|:---:|---|---|---|---:|---:|---:|---|---|---|
| 1 | 1 | FAC-2026-0001 | 2026-04-10 | 2026-05-10 | 1450.00 | 21.00 | 1754.50 | Cobrada | 2026-05-08 | Transferencia bancaria |
| 2 | 2 | FAC-2026-0002 | 2026-04-15 | 2026-06-14 | 2380.00 | 0.00 | 2380.00 | Pendiente | NULL | NULL |

> *Nota:* FAC-2026-0002 tiene IVA 0 % por tratarse de un servicio de transporte intracomunitario
> entre España y Alemania, operación exenta de IVA según normativa EU (artículo 9.1.c LIVA).

---

## Área 2 — Servicios y seguimiento

### SERVICIO

| id_servicio | id_cliente | id_factura | numero_servicio | fecha_solicitud | fecha_prevista_recogida | tipo_servicio | nivel_urgencia | estado_actual | documentacion_completa | observaciones |
|:---:|:---:|:---:|---|---|---|---|---|---|:---:|---|
| 1 | 1 | 1 | SRV-2026-0001 | 2026-03-28 | 2026-04-01 | FTL | Estandar | Cerrado | TRUE | Carga textil palé completo Zaragoza → München |
| 2 | 2 | NULL | SRV-2026-0002 | 2026-04-18 | 2026-04-21 | FTL | Urgente | En_transito | FALSE | Distribución farmacéutica temperatura controlada München → Madrid |
| 3 | 3 | NULL | SRV-2026-0003 | 2026-04-20 | 2026-04-23 | LTL | Estandar | Entregado | TRUE | Reparto alimentación Lille → Gante + Brujas |

> *id_factura NULL en SRV-2026-0002 y SRV-2026-0003:* estos servicios aún no han sido
> facturados, lo que demuestra la participación parcial de SERVICIO en la relación R-05.

---

### PUNTO_SERVICIO

| id_punto | id_servicio | id_direccion | tipo | orden | direccion | ciudad | pais | ventana_inicio | ventana_fin | fecha_ejecucion_real | estado | observaciones |
|:---:|:---:|:---:|---|:---:|---|---|---|---|---|---|---|---|
| 1 | 1 | 1 | Recogida | 1 | Pol. Ind. Malpica, C/ Río Ebro 8, 50016 | Zaragoza | España | 2026-04-01 08:00 | 2026-04-01 12:00 | 2026-04-01 09:15 | Completado | Acceso por puerta norte |
| 2 | 1 | 3 | Entrega | 2 | Landsberger Str. 300, 80687 | München | Alemania | 2026-04-03 07:00 | 2026-04-03 15:00 | 2026-04-03 11:40 | Completado | Cita previa con Klaus Hoffmann |
| 3 | 2 | 3 | Recogida | 1 | Landsberger Str. 300, 80687 | München | Alemania | 2026-04-21 06:00 | 2026-04-21 10:00 | 2026-04-21 07:30 | Completado | NULL |
| 4 | 2 | NULL | Entrega | 2 | Av. de la Industria 40, Nave 12, 28108 | Alcobendas | España | 2026-04-23 07:00 | 2026-04-23 14:00 | NULL | Pendiente | Depósito FARMAD - requiere identificación conductor |
| 5 | 3 | 4 | Recogida | 1 | Zone Industrielle des Près, Rue Lavoisier 5, 59650 | Villeneuve d'Ascq | Francia | 2026-04-23 05:30 | 2026-04-23 08:00 | 2026-04-23 06:00 | Completado | Carga antes del amanecer |
| 6 | 3 | NULL | Entrega | 2 | Rue de Gand 200, 9000 | Gante | Bélgica | 2026-04-23 13:00 | 2026-04-23 16:00 | 2026-04-23 14:20 | Completado | NULL |
| 7 | 3 | NULL | Entrega | 3 | Mariastraat 14, 8000 | Brujas | Bélgica | 2026-04-23 17:00 | 2026-04-23 20:00 | 2026-04-23 17:45 | Completado | NULL |

> *id_direccion NULL en puntos 4, 6 y 7:* son puntos ad hoc no registrados como
> direcciones operativas del cliente, lo que demuestra la participación parcial de R-07.

---

### EVENTO_SEGUIMIENTO

| id_evento | id_servicio | tipo_evento | descripcion | fecha_hora | estado_resultante | usuario_responsable | observaciones |
|:---:|:---:|---|---|---|---|---|---|
| 1 | 1 | Servicio_creado | Servicio SRV-2026-0001 creado por encargo de Lenz S.L. | 2026-03-28 10:05 | Pendiente | trafico.garcia | NULL |
| 2 | 1 | Planificado | Ruta planificada: Zaragoza → München. Distancia estimada 1.620 km | 2026-03-29 09:30 | Planificado | trafico.garcia | NULL |
| 3 | 1 | Asignado | Asignados conductor C. Martínez y vehículo 4121-HKJ con remolque RE-2024-001 | 2026-03-30 11:00 | Asignado | trafico.garcia | NULL |
| 4 | 1 | Recogida_completada | Recogida completada en almacén Zaragoza. 22 palés cargados | 2026-04-01 09:20 | En_transito | conductor.martinez | NULL |
| 5 | 1 | Entrega_completada | Entrega completada en München. Albarán firmado por K. Hoffmann | 2026-04-03 11:45 | Entregado | conductor.martinez | NULL |
| 6 | 1 | Cerrado | Servicio cerrado. Documentación recibida. Listo para facturar | 2026-04-05 08:00 | Cerrado | trafico.garcia | NULL |
| 7 | 2 | Servicio_creado | Servicio SRV-2026-0002 creado. Prioridad urgente: distribución farmacéutica | 2026-04-18 14:10 | Pendiente | trafico.lopez | NULL |
| 8 | 2 | Asignado | Asignada conductora A. García con vehículo 8834-KPL y remolque frigorífico RE-2024-002 | 2026-04-19 09:00 | Asignado | trafico.lopez | NULL |
| 9 | 2 | Recogida_completada | Recogida completada en München. 6 palés producto farmacéutico. Temperatura verificada: -2°C | 2026-04-21 07:35 | En_transito | conductor.garcia | NULL |
| 10 | 3 | Servicio_creado | Servicio SRV-2026-0003 creado. LTL con 2 entregas en Bélgica | 2026-04-20 09:15 | Pendiente | trafico.garcia | NULL |
| 11 | 3 | Incidencia_registrada | Incidencia de acceso registrada en punto Villeneuve d'Ascq | 2026-04-23 06:15 | Con_incidencia | conductor.martinez | NULL |
| 12 | 3 | Entrega_completada | Ambas entregas completadas en Bélgica. Documentación entregada | 2026-04-23 18:00 | Entregado | conductor.martinez | NULL |

---

## Área 3 — Mercancía y requisitos

### MERCANCIA

| id_mercancia | id_servicio | descripcion | tipo_carga | num_bultos_palets | peso_kg | volumen_m3 | valor_declarado | observaciones |
|:---:|:---:|---|---|:---:|---:|---:|---:|---|
| 1 | 1 | Tejidos técnicos y ropa confeccionada de temporada | Paletizada | 22 | 14200.00 | 52.800 | 85000.00 | Palés de 120x80 cm, fleje y film retráctil |
| 2 | 2 | Medicamentos refrigerados: vacunas y biológicos | Paletizada | 6 | 3800.00 | 12.600 | 420000.00 | GDP compliant. Temperatura: -2°C a +8°C |
| 3 | 3 | Harinas especiales y mezclas para panadería | Bultos | 340 | 8500.00 | 24.000 | 18700.00 | Sacos de 25 kg. Mantener seco |

> La restricción UNIQUE sobre `id_servicio` en MERCANCIA garantiza que cada servicio tiene
> exactamente una descripción de carga, materializando la relación 1:1 (R-09).

---

### REQUISITO_ESPECIAL

| id_requisito | id_servicio | tipo | descripcion | temperatura_min | temperatura_max | instrucciones | verificacion_obligatoria |
|:---:|:---:|---|---|:---:|:---:|---|:---:|
| 1 | 2 | Temperatura_controlada | Transporte de medicamentos refrigerados. Cadena de frío continua obligatoria | -2.0 | 8.0 | Verificar temperatura del remolque antes de carga. Registrar temperatura cada 2 horas. Adjuntar gráfico al CMR | TRUE |
| 2 | 2 | Documentacion_adicional | Requiere certificado GDP y hoja de datos de seguridad por partida | NULL | NULL | Entregar documentación al responsable de almacén antes de descarga. No aceptar sin firma de conformidad | TRUE |
| 3 | 3 | Restriccion_acceso | Acceso zona industrial Villeneuve d'Ascq restringido a vehículos < 3,5 m de altura | NULL | NULL | Acceso por Rue Lavoisier sentido oeste. Barrera automática: código 4421 | FALSE |

> El servicio 2 tiene dos requisitos especiales de tipos distintos, lo que justifica la
> existencia de REQUISITO_ESPECIAL como entidad independiente con relación 1:N a SERVICIO.

---

## Área 4 — Incidencias

### INCIDENCIA

| id_incidencia | id_servicio | tipo | descripcion | fecha_apertura | prioridad | estado | fecha_ultima_actualizacion | responsable_gestion | fecha_cierre | descripcion_resolucion | genera_coste_adicional |
|:---:|:---:|---|---|---|---|---|---|---|---|---|:---:|
| 1 | 3 | Problema_acceso | Barrera de acceso a zona industrial bloqueada por avería. Espera de 45 minutos hasta resolución por el personal del polígono | 2026-04-23 06:10 | Baja | Cerrada | 2026-04-23 07:00 | trafico.garcia | 2026-04-23 07:00 | Personal del polígono reparó la barrera. No hubo pérdida de ventana horaria | FALSE |

---

## Área 5 — Recursos

### VEHICULO

| id_vehiculo | matricula | tipo | marca | modelo | anio_matriculacion | capacidad_carga_kg | estado_operativo |
|:---:|---|---|---|---|:---:|---:|---|
| 1 | 4121-HKJ | Cabeza_tractora | Volvo | FH16 540 | 2022 | 26000.00 | Asignado |
| 2 | 8834-KPL | Cabeza_tractora | Mercedes-Benz | Actros 1853 | 2021 | 26000.00 | Asignado |

---

### REMOLQUE

| id_remolque | matricula | tipo | capacidad_carga_kg | longitud_m | apto_temperatura | estado_operativo |
|:---:|---|---|---:|---:|:---:|---|
| 1 | RE-2024-001 | Lona | 24000.00 | 13.60 | FALSE | Asignado |
| 2 | RE-2024-002 | Frigorifico | 22000.00 | 13.60 | TRUE | Asignado |

---

### CONDUCTOR

| id_conductor | numero_empleado | nombre | apellidos | fecha_nacimiento | telefono | email | numero_permiso | categorias_permiso | estado_disponibilidad |
|:---:|---|---|---|---|---|---|---|---|---|
| 1 | EMP-0042 | Carlos | Martínez López | 1985-03-14 | +34 655 100 200 | c.martinez@transportes.eu | B-1985-ZGZ-7842 | C, CE | Asignado |
| 2 | EMP-0071 | Ana | García Ruiz | 1990-11-08 | +34 655 100 210 | a.garcia@transportes.eu | M-1990-MAD-3301 | C, CE | Asignado |

---

### ASIGNACION

| id_asignacion | id_servicio | id_conductor | id_vehiculo | id_remolque | fecha_asignacion | es_activa | motivo_cambio | observaciones |
|:---:|:---:|:---:|:---:|:---:|---|:---:|---|---|
| 1 | 1 | 1 | 1 | 1 | 2026-03-30 11:00 | FALSE | Servicio completado; registro histórico | NULL |
| 2 | 2 | 2 | 2 | 2 | 2026-04-19 09:00 | TRUE | NULL | Remolque frigorífico obligatorio por requisito de temperatura |
| 3 | 3 | 1 | 1 | 1 | 2026-04-22 08:00 | TRUE | NULL | LTL Bélgica; conductor Carlos disponible tras cierre de SRV-0001 |

> La asignación 1 tiene `es_activa = FALSE` porque el servicio 1 ya está cerrado. La asignación
> se mantiene como registro histórico, tal como establece RF-017.
> El remolque es NULL-safe: en este modelo todos los servicios activos usan remolque, pero
> `id_remolque` admite NULL para vehículos rígidos (ver ASIGNACION.id_remolque nullable).

---

## Área 6 — Costes operativos

### COSTE_OPERATIVO

| id_coste | id_servicio | tipo_coste | importe | fecha | descripcion | justificante_disponible |
|:---:|:---:|---|---:|---|---|:---:|
| 1 | 1 | Combustible | 380.00 | 2026-04-01 | Repostaje Zaragoza salida | TRUE |
| 2 | 1 | Peajes | 142.50 | 2026-04-02 | Peajes AP-2 y autopistas francesas | TRUE |
| 3 | 1 | Combustible | 290.00 | 2026-04-02 | Repostaje Lyon trayecto | TRUE |
| 4 | 1 | Dietas | 60.00 | 2026-04-02 | Dieta conductor noche en ruta | TRUE |
| 5 | 2 | Combustible | 520.00 | 2026-04-21 | Repostaje München inicio servicio urgente | TRUE |
| 6 | 2 | Peajes | 88.00 | 2026-04-21 | Peajes Austria (Brenner) | TRUE |
| 7 | 3 | Combustible | 195.00 | 2026-04-23 | Repostaje Lille inicio LTL Bélgica | TRUE |
| 8 | 3 | Peajes | 22.50 | 2026-04-23 | Vignette autopistas belgas | FALSE |

> Los costes de SRV-0001 suman 872,50 € frente a un ingreso de 1.450 € (importe_base
> de FAC-2026-0001), demostrando que la estructura permite calcular rentabilidad por servicio
> (RF-022) mediante operaciones de agregación sobre esta tabla.

---

## Área 8 — Documentación y control interno

### DOCUMENTO_SERVICIO

| id_documento_srv | id_servicio | tipo_documento | descripcion | fecha_documento | recibido | fecha_recepcion | referencia_archivo |
|:---:|:---:|---|---|---|:---:|---|---|
| 1 | 1 | CMR | Carta de Porte CMR firmada en origen (Zaragoza) y destino (München) | 2026-04-01 | TRUE | 2026-04-07 | /docs/2026/SRV-0001/CMR-001.pdf |
| 2 | 1 | Albaran_entrega | Albarán de entrega firmado por K. Hoffmann en München | 2026-04-03 | TRUE | 2026-04-07 | /docs/2026/SRV-0001/ALB-001.pdf |
| 3 | 2 | CMR | Carta de Porte CMR firmada en origen München. Pendiente firma destino | 2026-04-21 | FALSE | NULL | NULL |
| 4 | 2 | Registro_temperatura | Registro de temperatura continua del remolque RE-2024-002 | 2026-04-21 | FALSE | NULL | NULL |
| 5 | 3 | CMR | Carta de Porte CMR LTL. Tres apartados: Lille, Gante y Brujas | 2026-04-23 | TRUE | 2026-04-24 | /docs/2026/SRV-0003/CMR-001.pdf |
| 6 | 3 | Albaran_entrega | Albarán entrega Gante firmado | 2026-04-23 | TRUE | 2026-04-24 | /docs/2026/SRV-0003/ALB-001.pdf |
| 7 | 3 | Albaran_entrega | Albarán entrega Brujas firmado | 2026-04-23 | TRUE | 2026-04-24 | /docs/2026/SRV-0003/ALB-002.pdf |

> Los documentos 3 y 4 (SRV-0002) tienen `recibido = FALSE` porque el servicio sigue
> en tránsito. Esto explica por qué `SERVICIO.documentacion_completa = FALSE` para SRV-0002.

---

### DOCUMENTO_RECURSO

| id_documento_rec | id_vehiculo | id_remolque | id_conductor | tipo_documento | numero_documento | fecha_emision | fecha_caducidad | organismo_emisor | referencia_archivo |
|:---:|:---:|:---:|:---:|---|---|---|---|---|---|
| 1 | 1 | NULL | NULL | ITV | ITV-2024-ZGZ-41100 | 2024-10-15 | 2026-10-15 | Estación ITV Zaragoza Norte | /docs/vehiculos/4121-HKJ/ITV-2024.pdf |
| 2 | 1 | NULL | NULL | Seguro | POL-2025-ZGZ-8821 | 2025-01-01 | 2026-12-31 | Mapfre Transporte | /docs/vehiculos/4121-HKJ/SEGURO-2025.pdf |
| 3 | 1 | NULL | NULL | Tacografo_calibracion | TAC-2023-ZGZ-0042 | 2023-07-10 | 2025-07-10 | Taller Autorizado VDO Zaragoza | /docs/vehiculos/4121-HKJ/TAC-2023.pdf |
| 4 | 2 | NULL | NULL | ITV | ITV-2025-MAD-72200 | 2025-03-20 | 2027-03-20 | Estación ITV Madrid Sur | /docs/vehiculos/8834-KPL/ITV-2025.pdf |
| 5 | 2 | NULL | NULL | Seguro | POL-2025-MAD-3310 | 2025-01-01 | 2026-12-31 | Allianz Fleet | /docs/vehiculos/8834-KPL/SEGURO-2025.pdf |
| 6 | NULL | 1 | NULL | ITV | ITV-2024-ZGZ-41101 | 2024-10-15 | 2026-10-15 | Estación ITV Zaragoza Norte | /docs/remolques/RE-2024-001/ITV-2024.pdf |
| 7 | NULL | 1 | NULL | Seguro | POL-2025-ZGZ-8822 | 2025-01-01 | 2026-12-31 | Mapfre Transporte | /docs/remolques/RE-2024-001/SEGURO-2025.pdf |
| 8 | NULL | 2 | NULL | ITV | ITV-2025-MAD-72201 | 2025-03-20 | 2027-03-20 | Estación ITV Madrid Sur | /docs/remolques/RE-2024-002/ITV-2025.pdf |
| 9 | NULL | 2 | NULL | Tacografo_calibracion | TAC-2024-MAD-0080 | 2024-09-05 | 2026-09-05 | Taller Autorizado Stoneridge Madrid | /docs/remolques/RE-2024-002/TAC-2024.pdf |
| 10 | NULL | NULL | 1 | Permiso_conducir | B-1985-ZGZ-7842 | 2015-06-20 | 2025-06-20 | DGT Zaragoza | /docs/conductores/EMP-0042/PERMISO.pdf |
| 11 | NULL | NULL | 1 | CAP | CAP-ZGZ-0042 | 2021-09-10 | 2026-09-10 | Centro Formación CETM | /docs/conductores/EMP-0042/CAP-2021.pdf |
| 12 | NULL | NULL | 1 | Tarjeta_tacografo | TT-ES-042-2019 | 2019-04-01 | 2024-04-01 | DGT Jefatura Tráfico Aragón | /docs/conductores/EMP-0042/TT-2019.pdf |
| 13 | NULL | NULL | 2 | Permiso_conducir | M-1990-MAD-3301 | 2020-11-15 | 2025-11-15 | DGT Madrid | /docs/conductores/EMP-0071/PERMISO.pdf |
| 14 | NULL | NULL | 2 | CAP | CAP-MAD-0071 | 2022-03-22 | 2027-03-22 | Centro Formación ASTIC | /docs/conductores/EMP-0071/CAP-2022.pdf |
| 15 | NULL | NULL | 2 | Tarjeta_tacografo | TT-ES-071-2022 | 2022-08-15 | 2027-08-15 | DGT Jefatura Tráfico Madrid | /docs/conductores/EMP-0071/TT-2022.pdf |

> **Documentos vencidos o próximos a vencer (referencia para RF-028):**
> - Reg. 3 (TAC calibración vehículo 1): caducó 2025-07-10 — requiere renovación urgente
> - Reg. 10 (Permiso conductor 1): caducó 2025-06-20 — requiere renovación
> - Reg. 12 (Tarjeta tacógrafo conductor 1): caducó 2024-04-01 — requiere renovación urgente
>
> Estos casos demuestran el valor del control de caducidades en la base de datos (RF-028).

---

### REGISTRO_AUDITORIA

| id_auditoria | tipo_operacion | entidad_afectada | id_registro_afectado | usuario | fecha_hora | descripcion |
|:---:|---|---|:---:|---|---|---|
| 1 | Crear | SERVICIO | 1 | trafico.garcia | 2026-03-28 10:05 | Creación del servicio SRV-2026-0001 para cliente id=1 |
| 2 | Cambio_estado | SERVICIO | 1 | trafico.garcia | 2026-03-29 09:30 | Estado anterior: Pendiente → nuevo estado: Planificado |
| 3 | Asignar | ASIGNACION | 1 | trafico.garcia | 2026-03-30 11:00 | Asignación id=1 creada: conductor 1, vehículo 1, remolque 1 → servicio 1 |
| 4 | Cambio_estado | SERVICIO | 1 | conductor.martinez | 2026-04-01 09:20 | Estado anterior: Asignado → nuevo estado: En_transito (recogida completada) |
| 5 | Cambio_estado | SERVICIO | 1 | conductor.martinez | 2026-04-03 11:45 | Estado anterior: En_transito → nuevo estado: Entregado |
| 6 | Cambio_estado | SERVICIO | 1 | trafico.garcia | 2026-04-05 08:00 | Estado anterior: Entregado → nuevo estado: Cerrado |
| 7 | Facturar | FACTURA | 1 | admin.finanzas | 2026-04-10 09:00 | Factura FAC-2026-0001 emitida. Servicios incluidos: id=1. Importe: 1754,50 € |
| 8 | Cobrar | FACTURA | 1 | admin.finanzas | 2026-05-08 10:30 | Cobro registrado de FAC-2026-0001. Método: Transferencia bancaria. Estado: Cobrada |
| 9 | Crear | SERVICIO | 2 | trafico.lopez | 2026-04-18 14:10 | Creación del servicio SRV-2026-0002 para cliente id=2. Urgente |
| 10 | Asignar | ASIGNACION | 2 | trafico.lopez | 2026-04-19 09:00 | Asignación id=2 creada: conductor 2, vehículo 2, remolque 2 → servicio 2 |
| 11 | Cambio_estado | SERVICIO | 2 | conductor.garcia | 2026-04-21 07:35 | Estado anterior: Asignado → nuevo estado: En_transito |
| 12 | Crear | INCIDENCIA | 1 | conductor.martinez | 2026-04-23 06:10 | Incidencia de acceso aperturada en SRV-2026-0003. Prioridad: Baja |
| 13 | Cambio_estado | INCIDENCIA | 1 | trafico.garcia | 2026-04-23 07:00 | Incidencia id=1 cerrada. Resolución documentada |

> REGISTRO_AUDITORIA no tiene FK a ninguna otra tabla. Las referencias se realizan mediante
> `entidad_afectada` (nombre de tabla) e `id_registro_afectado` (PK del registro afectado).
> Esto permite auditar operaciones sobre cualquier entidad del sistema sin acoplamiento
> estructural, incluyendo potenciales registros eliminados en el futuro.
