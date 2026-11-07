-- funcion trigger
CREATE OR REPLACE FUNCTION fn_verificar_incremento_precio()
RETURNS TRIGGER AS $$
BEGIN
    -- si el precio cambia
    IF NEW.precio IS DISTINCT FROM OLD.precio THEN
        IF NEW.precio < (OLD.precio * 1.17) THEN
            RAISE EXCEPTION 'el nuevo precio debe ser al menos un 17%% mayor que el actual ';
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- limpiar trigger
DROP TRIGGER IF EXISTS trg_verificar_incremento_precio ON productos;

-- creación del Trigger
CREATE TRIGGER trg_verificar_incremento_precio
BEFORE UPDATE OF precio ON productos
FOR EACH ROW
EXECUTE FUNCTION fn_verificar_incremento_precio();


-- UPDATE productos SET precio = 360.00 WHERE codProducto = 1;



