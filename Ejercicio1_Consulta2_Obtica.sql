/*
2-Lista los diferentes modelos de gafas que ha vendido un empleado durante un año.
voy a tomar como modelos las diferentes marcas.alter
y vamos a examinar el vendor SERGIO LOPEZ ID = 2
*/
SELECT tm.DESCRIPCION AS MARCA, CONCAT(vd.NOMBRE,' ', vd.APELLIDO) AS VENDEDOR
FROM TBL_VENTA vt
INNER JOIN TBL_VENDEDOR vd ON vt.ID_VENDEDOR = vd.ID_VENDEDOR
INNER JOIN TBL_DETALLE_VENTA  dv ON vt.ID_VENTA = dv.ID_VENTA
INNER JOIN TBL_GAFA tg on dv.ID_GAFA = tg.ID_GAFA
INNER JOIN TBL_MARCA tm on tg.ID_MARCA = tm.ID_MARCA
WHERE vd.ID_VENDEDOR = 2 
AND vt.FECHA_REGISTRO BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY tm.DESCRIPCION
ORDER BY tm.ID_MARCA;