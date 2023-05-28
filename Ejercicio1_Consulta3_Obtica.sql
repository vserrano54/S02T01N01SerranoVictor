
/*
	Lista a los diferentes proveedores que han suministrado gafas vendidas con éxito por la óptica.
*/
SELECT DISTINCT  tp.NOMBRE AS PROVEEDOR, tm.DESCRIPCION AS MARCA,
(SELECT SUM(dv.PRECIO * dv.CANTIDAD) WHERE vt.ID_VENTA = dv.ID_VENTA) AS TOTAL_VENTA
FROM TBL_VENTA vt
INNER JOIN TBL_DETALLE_VENTA  dv ON vt.ID_VENTA = dv.ID_VENTA
INNER JOIN TBL_GAFA tg on dv.ID_GAFA = tg.ID_GAFA
INNER JOIN TBL_MARCA tm on tg.ID_MARCA = tm.ID_MARCA
INNER JOIN TBL_PROVEEDOR_MARCA pm on tg.ID_MARCA = pm.ID_MARCA
INNER JOIN TBL_PROVEEDOR tp on pm.ID_PROVEEDOR = tp.ID_PROVEEDOR
/*WHERE vt.FECHA_REGISTRO BETWEEN '2023-01-01' AND '2023-12-31'*/
GROUP BY tm.DESCRIPCION
ORDER BY tm.DESCRIPCION;