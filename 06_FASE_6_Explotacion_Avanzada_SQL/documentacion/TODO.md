# TODO -- FASE 6

> FASE 5 completada. FASE 6 completada el 2026-06-02.

## Estado actual

Fase completada. Trigger cargado, consultas avanzadas ejecutadas y auditoria verificada
en phpMyAdmin el 2026-06-02. Las 8 capturas reales estan enlazadas en
entregables/capturas_consultas_avanzadas.md.

---

## Tareas completadas

- [x] Revisar requerimientos funcionales RF-001 a RF-030 de FASE 1
- [x] Planificar mapa RF -> consulta para relacion_requerimientos.md
- [x] Escribir consulta JOIN servicios con cliente, conductor y vehiculo (actividad 1+2)
- [x] Escribir consulta JOIN incidencias con servicios (actividad 3)
- [x] Escribir consulta costes totales y margen por servicio (actividad 4)
- [x] Escribir consulta facturacion por cliente y periodo (actividad 5)
- [x] Escribir consulta servicios sin facturar (actividad 6a)
- [x] Escribir consulta servicios con documentacion incompleta (actividad 6b)
- [x] Escribir consulta documentos caducados (actividad 7a)
- [x] Escribir consulta documentos proximos a caducar 90 dias (actividad 7b)
- [x] Escribir consulta resumen operativo general de la empresa
- [x] Disenar e implementar trigger trg_auditoria_cambio_estado_servicio (actividad 8)
- [x] Redactar explicacion_consultas_avanzadas.md
- [x] Redactar relacion_requerimientos.md con tabla RF -> consulta (actividad 9)
- [x] Redactar plantilla capturas_consultas_avanzadas.md
- [x] Copiar scripts a sql/consultas_avanzadas.sql y sql/trigger_auditoria.sql
- [x] Cargar trigger_auditoria.sql en phpMyAdmin (cambiando delimitador a //)
- [x] Ejecutar consultas_avanzadas.sql en phpMyAdmin seccion por seccion
- [x] Tomar captura cap01_servicios_completos.png
- [x] Tomar captura cap02_incidencias_servicios.png
- [x] Tomar captura cap03_costes_totales.png
- [x] Tomar captura cap04_facturacion_cliente_periodo.png
- [x] Tomar captura cap05_servicios_sin_facturar_doc_incompleta.png
- [x] Tomar captura cap06_documentos_caducados.png
- [x] Tomar captura cap07_trigger_creado.png (confirmacion de creacion)
- [x] Tomar captura cap08_auditoria_generada.png (registro generado automaticamente)
- [x] Actualizar capturas_consultas_avanzadas.md con capturas reales enlazadas
- [x] Marcar checklist del README como completado

---

## Notas sobre el trigger

El trigger `trg_auditoria_cambio_estado_servicio` se activa AFTER UPDATE en servicio.
Solo inserta en registro_auditoria cuando cambia el campo estado_actual.
Para probarlo: ejecutar el UPDATE de prueba incluido al final de trigger_auditoria.sql
y verificar con SELECT sobre registro_auditoria ORDER BY id_auditoria DESC LIMIT 5.

En phpMyAdmin, para ejecutar el DELIMITER // se recomienda usar la pestana SQL
y cambiar el delimitador en el campo "Delimitador" antes de ejecutar.
