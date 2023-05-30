
/*
Lista cuántos pedidos ha efectuado un determinado empleado/a.
Voy a consultar el ID_EMPLEADO = 5 ROGER PEREZ
*/
SELECT COUNT(pd.ID_PEDIDO) AS 'Pedidos realizados por el empleado ROGER PEREZ'
FROM TBL_PEDIDO pd
INNER JOIN TBL_EMPLEADO em on pd.ID_EMPLEADO = em.ID_EMPLEADO
WHERE em.NOMBRE = 'ROGER' AND em.APELLIDO = 'PEREZ';
