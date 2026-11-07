-- Crear un trigger que impida el borrado o modificación de las facturas. 
-- Solo deber permitir que la misma se marque como anulada indicando al operador que la hizo. 
-- Incluir estas operaciones en el log creado para el punto anterior (modifique o cree las tablas como crea necesario para cumplir este objetivo).

CREATE OR REPLACE FUNCTION fn_control_inmutabilidad_facturas()
RETURNS TRIGGER AS $$
BEGIN
    -- bloquear eliminacion
    IF TG_OP = 'DELETE' THEN
        RAISE EXCEPTION 'Las facturas no pueden ser eliminadas';
    END IF;


    IF TG_OP = 'UPDATE' THEN
        -- no permitir cambios en facturas anuladas
        IF OLD.anulada THEN
            RAISE EXCEPTION 'La factura N° % ya se encuentra anulada y no admite cambios', OLD.nroFactura;
        END IF;

        -- Validar que no se modifique nada de la factura (salvo por anulada)
        IF NEW.nroFactura IS DISTINCT FROM OLD.nroFactura OR
           NEW.fecha IS DISTINCT FROM OLD.fecha OR
           NEW.codCliente IS DISTINCT FROM OLD.codCliente OR
           NEW.codPedido IS DISTINCT FROM OLD.codPedido OR
           NEW.bruto IS DISTINCT FROM OLD.bruto OR
           NEW.iva IS DISTINCT FROM OLD.iva OR
           NEW.iibb IS DISTINCT FROM OLD.iibb OR
           NEW.final IS DISTINCT FROM OLD.final THEN
            RAISE EXCEPTION 'No se admiten cambios en las facturas. Solo se permite su anulación.';
        END IF;

        -- Permitir solo si se marca como anulada
        IF NEW.anulada IS TRUE AND OLD.anulada IS FALSE THEN
			NEW.usuarioAnulacion := SESSION_USER;
        ELSE
            RAISE EXCEPTION 'Cambio no válido en la factura';
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_control_inmutabilidad_facturas ON facturas;

CREATE TRIGGER trg_control_inmutabilidad_facturas
BEFORE UPDATE OR DELETE ON facturas
FOR EACH ROW
EXECUTE FUNCTION fn_control_inmutabilidad_facturas();

