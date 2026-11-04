-- 8) Crear un procedimiento que cree una tabla de referencias cruzadas para los productos en un rango de fechas determinado. La estructura seria la siguientes:
--  En cada fila se indicará un producto.
--  En cada columna el mes y el año (0110 seria enero del 2010), cada uno correspondiente al rango de fechas ingresado (si se ingresa el rango de fechas 05/02/2015 – 10/01/2016 serian 12 columnas)
--  En la intersección de las filas y las columnas la cantidad total unidades facturadas en las facturas de ese mes y año.
--  Verificar que el rango de fechas sea válido (debe tener al menos un trimestre). Caso contrario enviar un mensaje y finalizar el procedimiento.
--  Debe existir información para ese trimestre. Caso contrario enviar un mensaje y finalizar el procedimiento.
--  Devolver en una variable de output la cantidad de registros leídos para hacer la tabla de referencias cruzadas.
--  El nombre de la tabla será RC_ + el rango de fechas (por ejemplo, si puso 05/01/2010 y 26/07/2013 el nombre será RC_0110_0713)

CREATE OR REPLACE PROCEDURE sp_referencias_cruzadas_productos(
    p_fecha_desde DATE,
    p_fecha_hasta DATE,
    OUT p_cant_registros INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_nombre_tabla VARCHAR(100);
    v_cols_def TEXT := '';
    v_cols_select TEXT := '';
    v_mes_rec RECORD;
    v_cubre_trimestre BOOLEAN := FALSE;
	v_anio_desde INT;
    v_anio_hasta INT;
BEGIN
    p_cant_registros := 0;

    -- Verificar que el rango de fechas sea válido
    IF p_fecha_desde IS NULL OR p_fecha_hasta IS NULL OR p_fecha_desde > p_fecha_hasta THEN
        RAISE NOTICE 'Error: El rango de fechas ingresado no es válido.';
        RETURN;
    END IF;
	
    -- Verificar que el rango cubra COMPLETAMENTE al menos uno de los 4 trimestres calendario:
	v_anio_desde := EXTRACT(YEAR FROM p_fecha_desde);
    v_anio_hasta := EXTRACT(YEAR FROM p_fecha_hasta);

    -- año inicial
    IF (p_fecha_desde <= MAKE_DATE(v_anio_desde, 1, 1)  AND p_fecha_hasta >= MAKE_DATE(v_anio_desde, 3, 31))  OR -- Q1
          (p_fecha_desde <= MAKE_DATE(v_anio_desde, 4, 1)  AND p_fecha_hasta >= MAKE_DATE(v_anio_desde, 6, 30))  OR -- Q2
          (p_fecha_desde <= MAKE_DATE(v_anio_desde, 7, 1)  AND p_fecha_hasta >= MAKE_DATE(v_anio_desde, 9, 30))  OR -- Q3
          (p_fecha_desde <= MAKE_DATE(v_anio_desde, 10, 1) AND p_fecha_hasta >= MAKE_DATE(v_anio_desde, 12, 31)) THEN -- Q4
        v_cubre_trimestre := TRUE;

    -- años consecutivos
    ELSIF (p_fecha_desde <= MAKE_DATE(v_anio_hasta, 1, 1)  AND p_fecha_hasta >= MAKE_DATE(v_anio_hasta, 3, 31))-- Q1
    THEN
        v_cubre_trimestre := TRUE;
    END IF;

    -- Validación final
    IF NOT v_cubre_trimestre THEN
        RAISE NOTICE 'Error: El rango de fechas (% a %) no cubre completamente al menos un trimestre calendario.', p_fecha_desde, p_fecha_hasta;
        RETURN;
    END IF;

    -- 3. Verificar que exista información facturada en el rango indicado
    SELECT COUNT(*) INTO p_cant_registros
    FROM facturas f
    JOIN itemsFactura fi ON f.nroFactura = fi.nroFactura
    WHERE f.fecha BETWEEN p_fecha_desde AND p_fecha_hasta;

    IF p_cant_registros = 0 THEN
        RAISE NOTICE 'Error: No existe información de facturación registrada en el rango de fechas % a %.', p_fecha_desde, p_fecha_hasta;
        RETURN;
    END IF;

    -- 4. Definir nombre dinámico de la tabla: RC_<MMYY_desde>_<MMYY_hasta>
    v_nombre_tabla := 'rc_' || TO_CHAR(p_fecha_desde, 'mmyy') || '_' || TO_CHAR(p_fecha_hasta, 'mmyy');

    -- 5. Construir dinámicamente las partes de la consulta
    FOR v_mes_rec IN
        SELECT DISTINCT TO_CHAR(m, 'mmyy') AS mmyy, DATE_TRUNC('month', m) AS mes_inicio
        FROM generate_series(
            DATE_TRUNC('month', p_fecha_desde),
            DATE_TRUNC('month', p_fecha_hasta),
            INTERVAL '1 month'
        ) AS m
        ORDER BY mes_inicio
    LOOP
        v_cols_def := v_cols_def ||', "'|| v_mes_rec.mmyy || '" INT DEFAULT 0' ;
        v_cols_select := v_cols_select || format(
            ', COALESCE(SUM(CASE WHEN TO_CHAR(f.fecha, ''mmyy'') = %L THEN fi.cantidad END), 0)::INT AS %I',
            v_mes_rec.mmyy, v_mes_rec.mmyy
        );	END LOOP;

    -- 6. Eliminar la tabla si ya existe
    EXECUTE format('DROP TABLE IF EXISTS %I CASCADE;', v_nombre_tabla);

    -- 7. Crear la tabla usando EXECUTE format(...)
    EXECUTE format('
        CREATE TABLE %I (
            codProducto INT
            %s
        );',
        v_nombre_tabla,
        v_cols_def
    );
	RAISE NOTICE 'TABLA CREADA';
    -- 8. Insertar datos en la tabla usando EXECUTE format(...) sin concatenación manual (+) ni (||)
    EXECUTE format('
        INSERT INTO %I
        SELECT 
            p.codProducto 
            %s
        FROM productos p
        LEFT JOIN itemsFactura fi ON p.codProducto = fi.codProducto
        LEFT JOIN facturas f ON fi.nroFactura = f.nroFactura AND f.fecha BETWEEN %L AND %L
        GROUP BY p.codProducto
        ORDER BY p.codProducto;',
        v_nombre_tabla,
        v_cols_select,
        p_fecha_desde,
        p_fecha_hasta
    );

    RAISE NOTICE 'Tabla "%" creada e insertada exitosamente mediante EXECUTE format(...). Se leyeron % registros de ítems facturados.', v_nombre_tabla, p_cant_registros;
END;
$$;

DO $$
DECLARE
    v_cant_leidos INT;
BEGIN
    -- Generar tabla de referencias cruzadas para el rango de 01/01/2026 a 30/04/2026 (4 meses)
    CALL sp_referencias_cruzadas_productos('2026-01-01', '2026-04-30', v_cant_leidos);
    RAISE NOTICE 'Total de ítems facturados leídos: %', v_cant_leidos;
END $$;

-- Consultar la tabla generada dinámicamente:
SELECT * FROM rc_0126_0426;