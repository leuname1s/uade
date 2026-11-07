-- 10) Crear un procedimiento que realice un listado utilizando de la composición de los productos. El formato del listado es el siguiente:
-- Producto Componente cantidad precio
-- XXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXX 999 999.99
-- XXXXXXXXXXXXXXXXXXXXX 999 999.99
-- XXXXXXXXXXXXXXXXXXXXX 999 999.99
-- XXXXXXXXXXXXXXXXXXXXX 999 999.99
-- Total del producto XXXXXXXXXXXXXXXXXXXXXXXX 9999 999.99
-- XXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXX 999 999.99
-- XXXXXXXXXXXXXXXXXXXXX 999 999.99
-- Total del producto XXXXXXXXXXXXXXXXXXXXXXXX 9999 999.99

CREATE OR REPLACE PROCEDURE sp_listado_composicion_productos()
LANGUAGE plpgsql
AS $$
DECLARE
    v_padre RECORD;
    v_comp RECORD;
    v_es_primer_comp BOOLEAN;
    v_total_cantidad INT;
    v_total_precio NUMERIC(12,2);
BEGIN
    -- encabezado de columnas
    RAISE NOTICE '% % % %', 
        RPAD('Producto', 25), 
        RPAD('Componente', 25), 
        LPAD('cantidad', 10), 
        LPAD('precio', 12);
	RAISE NOTICE '--------------------------------------------------------------------------------------------------------------';

    -- Bucle para productos compuestos
    FOR v_padre IN (
        SELECT DISTINCT p.codProducto, p.descripcion
        FROM productos p
        JOIN composiciones c ON p.codProducto = c.codProducto
        ORDER BY p.codProducto
    ) LOOP
        v_es_primer_comp := TRUE;
        v_total_cantidad := 0;
        v_total_precio := 0.00;

        -- bucle componentes del producto actual
        FOR v_comp IN (
            SELECT 
                pc.descripcion AS desc_componente,
                c.cantidad,
                pc.precio AS precio_componente
            FROM composiciones c
            JOIN productos pc ON c.codProductoComponente = pc.codProducto
            WHERE c.codProducto = v_padre.codProducto
            ORDER BY pc.descripcion
        ) LOOP
            -- Acumular totales
            v_total_cantidad := v_total_cantidad + v_comp.cantidad;
            v_total_precio := v_total_precio + (v_comp.cantidad * v_comp.precio_componente);

            -- Si es el primer componente mostramos el nombre del producto padre
			-- en los siguientes dejamos el espacio en blanco
            IF v_es_primer_comp THEN
                RAISE NOTICE '% % % %', 
                    RPAD(v_padre.descripcion, 25),
                    RPAD(v_comp.desc_componente, 25),
                    LPAD(v_comp.cantidad::TEXT, 10),
                    LPAD((v_comp.precio_componente::MONEY)::VARCHAR, 12);
                v_es_primer_comp := FALSE;
            ELSE
                RAISE NOTICE '% % % %', 
                    RPAD('', 25),
                    RPAD(v_comp.desc_componente, 25),
                    LPAD(v_comp.cantidad::TEXT, 10),
                    LPAD((v_comp.precio_componente::MONEY)::VARCHAR, 12);
            END IF;
        END LOOP;

        -- linea de totales del producto
        RAISE NOTICE 'Total del producto % % %', 
            RPAD(v_padre.descripcion,32),
            LPAD(v_total_cantidad::TEXT, 10),
            LPAD((v_total_precio::MONEY)::VARCHAR, 12);
		RAISE NOTICE '------------------------------------------------------------------------------------';

    END LOOP;
END;
$$;

-- CALL sp_listado_composicion_productos();