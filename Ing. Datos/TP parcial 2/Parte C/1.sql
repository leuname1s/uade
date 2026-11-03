-- 1. Creación de la función del trigger
CREATE OR REPLACE FUNCTION fn_verificar_incremento_precio()
RETURNS TRIGGER AS $$
BEGIN
    -- Se evalúa únicamente cuando el precio cambia
    IF NEW.precio IS DISTINCT FROM OLD.precio THEN
        -- Comprueba si el nuevo precio es menor al 17% de incremento respecto al anterior
        IF NEW.precio < (OLD.precio * 1.17) THEN
            RAISE EXCEPTION 'Actualización no permitida: el nuevo precio (%), debe ser al menos un 17%% mayor que el actual (%). El precio mínimo debe ser %.', 
                NEW.precio, OLD.precio, ROUND(OLD.precio * 1.17, 2);
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 2. Creación del Trigger
DROP TRIGGER IF EXISTS trg_verificar_incremento_precio ON productos;

CREATE TRIGGER trg_verificar_incremento_precio
BEFORE UPDATE OF precio ON productos
FOR EACH ROW
EXECUTE FUNCTION fn_verificar_incremento_precio();


-- Prueba 1: Fallo (Incremento del 10% -> $330.00)
-- Resultado esperado: Cancela el UPDATE y muestra el mensaje de error.
-- UPDATE productos SET precio = 330.00 WHERE codProducto = 1;

-- Prueba 2: Éxito (Incremento del 20% -> $360.00)
-- Resultado esperado: La actualización se efectúa correctamente.
-- UPDATE productos SET precio = 360.00 WHERE codProducto = 1;

