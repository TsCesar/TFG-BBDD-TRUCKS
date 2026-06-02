# TODO -- FASE 5

> FASE 4 completada con commit a5e8c62. FASE 5 completada el 2026-06-02.

## Estado actual

Fase completada. Consultas ejecutadas en phpMyAdmin el 2026-06-02.
Las 7 capturas reales estan enlazadas en entregables/capturas_consultas_basicas.md.

---

## Tareas completadas

- [x] Revisar datos de prueba cargados en FASE 4 (schema + datos_prueba.sql verificados)
- [x] Planificar operaciones DML con razon de negocio real
- [x] Escribir INSERT (actividad 1): contacto nuevo, coste operativo, cliente de prueba para DELETE
- [x] Escribir UPDATE (actividad 2): email de cliente, documentacion_completa, estado de incidencia
- [x] Escribir DELETE (actividad 3): cliente de prueba con CIF='TEST-DELETE-01'
- [x] Escribir SELECT clientes activos (actividad 4)
- [x] Escribir SELECT servicios por estado (actividad 5)
- [x] Escribir SELECT vehiculos disponibles (actividad 6)
- [x] Escribir SELECT conductores disponibles (actividad 6)
- [x] Escribir SELECT facturas pendientes (actividad 7)
- [x] Escribir SELECT incidencias abiertas (actividad 7)
- [x] Redactar explicacion_consultas_basicas.md
- [x] Redactar plantilla capturas_consultas_basicas.md
- [x] Copiar script a sql/consultas_basicas.sql
- [x] Ejecutar consultas_basicas.sql en phpMyAdmin (seccion por seccion)
- [x] Tomar captura cap01_insert.png (resultado INSERT filas afectadas)
- [x] Tomar captura cap02_update.png (resultado UPDATE filas afectadas)
- [x] Tomar captura cap03_delete.png (resultado DELETE confirmacion)
- [x] Tomar captura cap04_clientes_activos.png (resultado SELECT activos)
- [x] Tomar captura cap05_servicios_estado.png (resultado SELECT por estado)
- [x] Tomar captura cap06_recursos_disponibles.png (vehiculos + conductores disponibles)
- [x] Tomar captura cap07_facturas_incidencias.png (facturas pendientes + incidencias)
- [x] Actualizar capturas_consultas_basicas.md con capturas reales enlazadas
- [x] Marcar checklist del README como completado

---

## Notas

- El DELETE se hace sobre el cliente con CIF='TEST-DELETE-01' creado en la misma sesion.
  No afecta a ninguno de los 5 clientes reales de FASE 4.
- El UPDATE sobre incidencia id=2 (Pharma, demora frontera) pasa de 'Abierta' a 'En_gestion'.
  Es un cambio realista que no rompe datos de FASE 6.
- El UPDATE sobre SRV-2026-0004 marca documentacion_completa=1.
  Esto es coherente con el estado 'Planificado' del servicio.
- No se borran costes operativos, eventos ni asignaciones existentes de FASE 4.
