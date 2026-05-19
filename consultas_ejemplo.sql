-- ==============================================
-- EJEMPLOS DE DOMINIO SQL - JUAN BERNARDO MARTINEZ
-- Enfoque: Integración y análisis de datos comerciales
-- ==============================================

-- 🔹 CONSULTA 1: Unir tablas para obtener información completa
-- Objetivo: Relacionar ventas con datos de clientes y productos
SELECT 
    v.id_venta,
    c.nombre_cliente,
    p.nombre_producto,
    v.cantidad,
    v.fecha_venta,
    (v.cantidad * p.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
WHERE v.fecha_venta BETWEEN '2026-01-01' AND '2026-04-30';

-- 🔹 CONSULTA 2: Análisis de rendimiento y métricas (Agrupación)
-- Objetivo: Ver rendimiento por categoría
SELECT 
    p.categoria,
    COUNT(v.id_venta) AS total_transacciones,
    SUM(v.cantidad) AS unidades_vendidas,
    SUM(v.cantidad * p.precio_unitario) AS ingreso_total,
    ROUND(AVG(p.precio_unitario),2) AS precio_promedio
FROM ventas v
JOIN productos p ON v.id_producto = p.id_producto
GROUP BY p.categoria
ORDER BY ingreso_total DESC;

-- 🔹 CONSULTA 3: Limpieza y validación de datos
-- Objetivo: Detectar o corregir registros inconsistentes
UPDATE productos
SET precio_unitario = precio_unitario * 1.10
WHERE categoria = 'Electrónica' AND precio_unitario < 100;

-- Eliminar registros duplicados
DELETE FROM ventas 
WHERE id_venta NOT IN (
    SELECT MIN(id_venta) 
    FROM ventas 
    GROUP BY fecha_venta, id_producto, id_cliente
);
