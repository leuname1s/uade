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

    IF p_fecha_desde IS NULL OR p_fecha_hasta IS NULL OR p_fecha_desde > p_fecha_hasta THEN
        RAISE EXCEPTION 'El rango de fechas ingresado no es válido';
    END IF;
	
    -- Hay que verificar que el rango de fechas contenga al menos un cuatrimestre por completo
	-- Esto lo pregunté la última clase antes del feriado
	-- para comprobarlo se chequean todos los cautrimestres del año inicial (fecha_desde) y se comprueba el primer cuatrimestre del año final(fecha_hasta)
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

    IF NOT v_cubre_trimestre THEN
        RAISE EXCEPTION 'El rango de fechas no cubre completamente al menos un trimestre';
    END IF;

    -- Ver si existen factuas en ese rango
    SELECT COUNT(*) INTO p_cant_registros
    FROM facturas f
    JOIN itemsFactura fi ON f.nroFactura = fi.nroFactura
    WHERE f.fecha BETWEEN p_fecha_desde AND p_fecha_hasta;

    IF p_cant_registros = 0 THEN
        RAISE EXCEPTION 'No existe información de facturación registrada en el rango de fechas especificado';
    END IF;

    -- nombre de la tabla
    v_nombre_tabla := 'rc_' || TO_CHAR(p_fecha_desde, 'mmyy') || '_' || TO_CHAR(p_fecha_hasta, 'mmyy');

    -- construir la consulta de creacion e insercion
    FOR v_mes_rec IN
        SELECT DISTINCT TO_CHAR(m, 'mmyy') AS mmyy, DATE_TRUNC('month', m) AS mes_inicio
        FROM generate_series(
            DATE_TRUNC('month', p_fecha_desde),
            DATE_TRUNC('month', p_fecha_hasta),
            INTERVAL '1 month'
        ) AS m
        ORDER BY mes_inicio
    LOOP
        v_cols_def := v_cols_def ||', "'|| v_mes_rec.mmyy || '" INT DEFAULT 0' ; -- por cada mes se genera una columna
        v_cols_select := v_cols_select || format(
            ', COALESCE(SUM(CASE WHEN TO_CHAR(f.fecha, ''mmyy'') = %L THEN fi.cantidad END), 0)::INT AS %I', --por cada columna se cacula la sumatoria de los items de las facturas
            v_mes_rec.mmyy, v_mes_rec.mmyy
        );	END LOOP;

    -- limpiar la tabla
    EXECUTE format('DROP TABLE IF EXISTS %I CASCADE;', v_nombre_tabla);

    -- crear la tabla
    EXECUTE format('
        CREATE TABLE %I (
            codProducto INT
            %s
        );',
        v_nombre_tabla,
        v_cols_def
    );
	RAISE NOTICE 'TABLA CREADA';
    -- insertar datos en la tabla
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

    RAISE NOTICE 'Tabla "%" creada e insertada exitosamente. Se leyeron % registros de ítems facturados.', v_nombre_tabla, p_cant_registros;
END;
$$;

DO $$
DECLARE
    v_cant_leidos INT;
BEGIN
    CALL sp_referencias_cruzadas_productos('2026-01-01', '2026-04-30', v_cant_leidos);
    RAISE NOTICE 'Total de ítems facturados leídos: %', v_cant_leidos;
END $$;

-- Consultar la tabla generada
SELECT * FROM rc_0126_0426;