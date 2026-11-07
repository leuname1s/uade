-- Crear una función que determine la cantidad de dinero pagado (facturado a un
-- cliente) de aquellos productos que poseen al menos 4 productos en su
-- composición.

CREATE OR REPLACE FUNCTION fn_monto_facturado_productos_compuestos(
p_codCliente INT
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$ DECLARE v_monto_total NUMERIC(12, 2) := 0.00; v_existe_cliente BOOLEAN; BEGIN 

SELECT COALESCE(SUM(inf.cantidad * inf.precio * (1.00 - (inf.descuento / 100.00))), 0.00) INTO v_monto_total 
FROM itemsFactura inf JOIN facturas f ON inf.nroFactura = f.nroFactura 
WHERE f.codCliente = p_codCliente AND inf.codProducto IN ( 
	SELECT c.codProducto FROM composiciones c GROUP BY c.codProducto 
	HAVING COUNT(DISTINCT c.codProductoComponente) >= 4 );
RETURN v_monto_total; END; $$;


-- SELECT fn_monto_facturado_productos_compuestos(1);

-- facturo el producto 10 con 10% desc por $900
-- SELECT fn_monto_facturado_productos_compuestos(2);
