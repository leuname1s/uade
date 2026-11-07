-- Definir un trigger para generar un registro de los pedidos que fueron facturados, almacenándolos en una nueva tabla llamada logs 
-- (la tabla debe ser creada previamente fuera del trigger).
-- Incluir en el log el numero de pedido, el numero de factura, la fecha y hora de la modificación y el usuario que está conectado y las filas involucradas en la operación 
-- (cantidad de filas que involucro la grabación de la factura).

-- Este ejercicio tambien incluye la operación de Anulación del ejercicio 3 parte C

CREATE OR REPLACE FUNCTION fn_log_facturas()
RETURNS TRIGGER AS $$
DECLARE
    v_cant_filas INT := 0;
BEGIN
    -- Determinar la cantidad de filas involucradas (primero se intenta con el pedido)
    IF NEW.codPedido IS NOT NULL THEN
        SELECT COUNT(*) INTO v_cant_filas FROM itemsPedido WHERE nroPedido = NEW.codPedido;
    ELSE -- si no se tiene un numero de pedido se asume que los items se cargaron previamente en la factura
        SELECT COUNT(*) INTO v_cant_filas FROM itemsFactura WHERE nroFactura = NEW.nroFactura;
    END IF;

    -- facturacion
    IF TG_OP = 'INSERT' THEN
        INSERT INTO logs (operacion, nroPedido, nroFactura, fechaHora, usuario, filasInvolucradas)
        VALUES ('FACTURACION', NEW.codPedido, NEW.nroFactura, CURRENT_TIMESTAMP, SESSION_USER, v_cant_filas+1); -- El +1 es para contar la factura en si misma

    -- anulacion
    ELSIF TG_OP = 'UPDATE' THEN
		INSERT INTO logs (operacion, nroPedido, nroFactura, fechaHora, usuario, filasInvolucradas)
		VALUES ('ANULACION', NEW.codPedido, NEW.nroFactura, CURRENT_TIMESTAMP, SESSION_USER, v_cant_filas+1); -- El +1 es para contar la factura en si misma
    END IF;

	-- Eso del +1 es algo que tambien lo pregunté la ultima clase

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_log_facturas ON facturas;

CREATE TRIGGER trg_log_facturas
AFTER INSERT OR UPDATE OF anulada ON facturas
FOR EACH ROW
EXECUTE FUNCTION fn_log_facturas();