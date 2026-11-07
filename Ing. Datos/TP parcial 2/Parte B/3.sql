-- 3) Crear un procedimiento que reciba el numero de un pedido y el nombre de un
-- cliente y facture el pedido realizando las siguientes acciones.
--  Verificar que el cliente ingresado exista y coincida con el cliente almacenado
-- en el pedido. Si no es correcto enviar un mensaje de error.
--  Crear la factura y los ítems de factura.
--  Devolver en variables output el número de la factura, el importe bruto y el
-- neto


CREATE OR REPLACE PROCEDURE sp_facturar_pedido(
p_nro_pedido INT,
p_nombre_cliente VARCHAR,
OUT p_nro_factura INT,
OUT p_bruto NUMERIC(12,2),
OUT p_neto NUMERIC(12,2)
)
LANGUAGE plpgsql
AS $$
DECLARE
v_cod_cliente INT;
v_cod_cliente_pedido INT;
v_nombre_cliente_real VARCHAR(200);
v_factura_existente INT;
v_cant_items INT;
v_iva NUMERIC(12, 2);
v_iibb NUMERIC(12, 2);
v_siguiente_nro_factura INT;
BEGIN

SELECT codCliente INTO v_cod_cliente_pedido
FROM pedidos
WHERE nroPedido = p_nro_pedido;

IF v_cod_cliente_pedido IS NULL THEN
    RAISE EXCEPTION 'El pedido numero % no existe.', p_nro_pedido;
END IF;

SELECT codCliente, nombre INTO v_cod_cliente, v_nombre_cliente_real
FROM clientes
WHERE LOWER(TRIM(nombre)) = LOWER(TRIM(p_nombre_cliente));

IF v_cod_cliente IS NULL THEN
    RAISE EXCEPTION 'el cliente "%" no existe', p_nombre_cliente;
END IF;

-- el codigo de cliente ingresado tiene que coicidir con el codigo cliente del pedido
IF v_cod_cliente <> v_cod_cliente_pedido THEN
    RAISE EXCEPTION 'El pedido N° % no pertenece al cliente ingresado ID %.',p_nro_pedido , v_cod_cliente;
END IF;


-- calcular valores
SELECT COALESCE(SUM(ip.cantidad * pr.precio), 0.00) INTO p_bruto
FROM itemsPedido ip JOIN productos pr ON ip.codProducto = pr.codProducto
WHERE ip.nroPedido = p_nro_pedido;

v_iva  := ROUND(p_bruto * 0.21, 2);
v_iibb := ROUND(p_bruto * 0.03, 2);  
p_neto := p_bruto + v_iva + v_iibb;

-- Obtener siguiente número correlativo de factura
-- No se utilizan valores de factura autogenerados
SELECT COALESCE(MAX(nroFactura), 0) + 1 INTO v_siguiente_nro_factura FROM facturas;

INSERT INTO facturas (nroFactura, fecha, codCliente, codPedido, bruto, iva, iibb, final)
VALUES (v_siguiente_nro_factura, CURRENT_DATE, v_cod_cliente, p_nro_pedido, p_bruto, v_iva, v_iibb, p_neto);

-- crear items de factura
INSERT INTO itemsFactura (codProducto, nroFactura, cantidad, precio)
	SELECT ip.codProducto, v_siguiente_nro_factura, ip.cantidad, pr.precio
	FROM itemsPedido ip JOIN productos pr ON ip.codProducto = pr.codProducto
	WHERE ip.nroPedido = p_nro_pedido;

-- Asignar número de factura al parámetro de lsalida
p_nro_factura := v_siguiente_nro_factura;

RAISE NOTICE 'Factura N° % generada con éxito. Valor bruto: $% Valor neto: $%.', p_nro_factura, p_bruto, p_neto;
END; $$;

-- CALL sp_facturar_pedido(3, 'Empresa Tenologica del norte', NULL, NULL, NULL);
