-- Crear un trigger que impida el borrado o modificación de las facturas. 
-- Solo deber permitir que la misma se marque como anulada indicando al operador que la hizo. 
-- Incluir estas operaciones en el log creado para el punto anterior (modifique o cree las tablas como crea necesario para cumplir este objetivo).

CREATE OR REPLACE FUNCTION fn_control_inmutabilidad_facturas()
RETURNS TRIGGER AS $$
BEGIN
    -- Bloquear cualquier intento de eliminación física (DELETE)
    IF TG_OP = 'DELETE' THEN
        RAISE EXCEPTION 'Operación no permitida: Las facturas no pueden ser eliminadas del sistema.';
    END IF;

    -- Control sobre modificaciones (UPDATE)
    IF TG_OP = 'UPDATE' THEN
        -- Si la factura ya estaba anulada previo a este intento de UPDATE
        IF OLD.anulada THEN
            RAISE EXCEPTION 'Operación no permitida: La factura N° % ya se encuentra anulada y no admite cambios.', OLD.nroFactura;
        END IF;

        -- Validar que no se modifique ningún dato intrínseco de la factura
        IF NEW.nroFactura IS DISTINCT FROM OLD.nroFactura OR
           NEW.fecha IS DISTINCT FROM OLD.fecha OR
           NEW.codCliente IS DISTINCT FROM OLD.codCliente OR
           NEW.codPedido IS DISTINCT FROM OLD.codPedido OR
           NEW.bruto IS DISTINCT FROM OLD.bruto OR
           NEW.iva IS DISTINCT FROM OLD.iva OR
           NEW.iibb IS DISTINCT FROM OLD.iibb OR
           NEW.final IS DISTINCT FROM OLD.final THEN
            RAISE EXCEPTION 'Operación no permitida: No se pueden modificar los datos de una factura existente. Solo se permite su anulación.';
        END IF;

        -- Permitir el cambio ÚNICAMENTE si se está marcando como anulada
        IF NEW.anulada IS TRUE AND OLD.anulada IS FALSE THEN
            -- Se asigna el usuario/operador actual si no viene especificado en la consulta
            IF NEW.usuarioAnulacion IS NULL THEN
                NEW.usuarioAnulacion := SESSION_USER;
            END IF;
        ELSE
            RAISE EXCEPTION 'Operación no permitida: Cambio no válido en la factura.';
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