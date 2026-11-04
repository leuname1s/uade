-- 7) Crear un procedimiento que reciba el nombre de un cliente y un entero correspondiente a un trimestre del año (1: enero a marzo, 2: abril a junio, etc.) y realice las siguientes acciones:
--  Verifique que el nombre ingresado corresponda a un cliente existente, caso contrario emita un mensaje de error.
--  Verifique el número de trimestre sea válido y que el cliente tenga facturación en ese trimestre, caso contrario emita un mensaje de error.
--  Crear una tabla denominada Facturación más el número de cliente más el trimestre (por ejemplo, para el cliente cuyo número es el 523 y la facturación del 3 trimestre serio Facturacion_523_3”). Si existe eliminarla y volverla a crear con la siguiente estructura:
	-- o Nro. Factura
	-- o Fecha Factura
	-- o nombre Cliente
	-- o Nro. Pedido
	-- o Fecha Pedido
	-- o cantidad de productos en la factura
	-- o cantidad de unidades totales en la factura
	-- o importe bruto
	-- o importe IVA
	-- o importe IIBB
	-- o importe final neto
--  Insertar la información en la tabla creada en el punto anterior.
--  Devolver en variables de output la cantidad de registros insertados y el importe total del trimestre.

CREATE OR REPLACE PROCEDURE sp_facturacion_cliente_trimestre(
    p_nombre_cliente VARCHAR,
    p_trimestre INT,
    OUT p_cant_registros INT,
    OUT p_importe_total NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_cod_cliente INT;
    v_nombre_tabla VARCHAR(100);
BEGIN
	p_cant_registros := 0;
    p_importe_total := 0.00;
    -- Verificar que el nombre ingresado corresponda a un cliente existente
    SELECT codCliente INTO v_cod_cliente
    FROM clientes
    WHERE LOWER(nombre) = LOWER(p_nombre_cliente);

    IF v_cod_cliente IS NULL THEN
        RAISE NOTICE 'Error: El cliente "%" no existe.', p_nombre_cliente;
        RETURN;
    END IF;

    -- Verificar que el trimestre sea un entero válido (1 a 4)
    IF p_trimestre IS NULL OR p_trimestre < 1 OR p_trimestre > 4 THEN
        RAISE NOTICE 'Error: El número de trimestre % no es válido. Debe ser un entero entre 1 y 4.', p_trimestre;
        RETURN;
    END IF;

    -- Verificar que el cliente tenga facturación en ese trimestre
    SELECT COUNT(*), COALESCE(SUM(f.final), 0)
    INTO p_cant_registros, p_importe_total
    FROM facturas f
    WHERE f.codCliente = v_cod_cliente
      AND EXTRACT(QUARTER FROM f.fecha) = p_trimestre;

    IF p_cant_registros = 0 THEN
        RAISE NOTICE 'Error: El cliente "%" (ID %) no registra facturación en el trimestre %.', p_nombre_cliente, v_cod_cliente, p_trimestre;
        RETURN;
    END IF;

    -- Definir el nombre de la tabla dinámica: Facturacion_<codCliente>_<trimestre>
    v_nombre_tabla := 'facturacion_' || v_cod_cliente || '_' || p_trimestre;

    -- Si existe la tabla, eliminarla y volverla a crear
    EXECUTE format('DROP TABLE IF EXISTS %I CASCADE;', v_nombre_tabla);

    EXECUTE format('
        CREATE TABLE %I (
            nroFactura INT,
            fechaFactura DATE,
            nombreCliente VARCHAR(200),
            nroPedido INT,
            fechaPedido DATE,
            cantProductos INT,
            cantUnidadesTotales INT,
            bruto NUMERIC(12,2),
            iva NUMERIC(12,2),
            iibb NUMERIC(12,2),
            finalNeto NUMERIC(12,2)
        );', v_nombre_tabla);

    -- Insertar la información en la tabla recién creada
    EXECUTE format('
        INSERT INTO %I (
            nroFactura, fechaFactura, nombreCliente, nroPedido, fechaPedido,
            cantProductos, cantUnidadesTotales, bruto, iva, iibb, finalNeto
        )
        SELECT 
            f.nroFactura,
            f.fecha AS fechaFactura,
            c.nombre AS nombreCliente,
            f.codPedido AS nroPedido,
            p.fecha AS fechaPedido,
            COALESCE(COUNT(DISTINCT fi.codProducto), 0) AS cantProductos,
            COALESCE(SUM(fi.cantidad), 0) AS cantUnidadesTotales,
            f.bruto,
            f.iva,
            f.iibb,
            f.final AS finalNeto
        FROM facturas f
        JOIN clientes c ON f.codCliente = c.codCliente
        LEFT JOIN pedidos p ON f.codPedido = p.nroPedido
        LEFT JOIN itemsFactura fi ON f.nroFactura = fi.nroFactura
        WHERE f.codCliente = %L
          AND EXTRACT(QUARTER FROM f.fecha) = %L
        GROUP BY f.nroFactura, f.fecha, c.nombre, f.codPedido, p.fecha, f.bruto, f.iva, f.iibb, f.final;',
        v_nombre_tabla, v_cod_cliente, p_trimestre);

    RAISE NOTICE 'Tabla "%" creada exitosamente. Se insertaron % registros por un total de %.', 
        v_nombre_tabla, p_cant_registros, p_importe_total;
END;
$$;

DO $$
DECLARE
    v_cant INT;
    v_total NUMERIC;
BEGIN
    CALL sp_facturacion_cliente_trimestre('Tech Solutions S.A.', 3, v_cant, v_total);
    RAISE NOTICE 'Cant: %, Total: %', v_cant, v_total;
END $$;