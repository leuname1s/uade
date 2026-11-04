--Crear un procedimiento que realice un listado utilizando 2 cursores para resolverlo. El formato del listado es el siguiente:
--Artista: XXXXXXXXXXXXXXXXXXXXXXX
--Discogafia
--99/99/99 : XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX (fechaAlbum y nombreDIsco)
--99 – XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 99:99 (nro. – titulo - duración)
--99 – XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 99:99
--99 – XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 99:99

CREATE OR REPLACE PROCEDURE sp_listado_discografia()
LANGUAGE plpgsql
AS $$
DECLARE
    v_artista_actual VARCHAR(200) := '';
    v_duracion_fmt VARCHAR(10);
    v_fecha_fmt VARCHAR(10);
    v_orden_fmt VARCHAR(5);
	v_album RECORD;
	v_tema RECORD;
BEGIN
    FOR v_album IN (
        SELECT 
            a.codAlbum,
            a.titulo AS titulo_album,
            a.fecha AS fecha_album,
            ar.nombre AS nombre_artista
        FROM albumes a
        JOIN artistas ar ON a.codArtista = ar.codArtista
        ORDER BY ar.nombre, a.fecha
    ) LOOP

        -- Si cambia el artista, se imprime el encabezado del Artista y la sección Discografía
        IF v_artista_actual <> v_album.nombre_artista THEN
            v_artista_actual := v_album.nombre_artista;
			RAISE NOTICE '-------------------------------------------------------';
			RAISE NOTICE 'Artista: %', v_artista_actual;
            RAISE NOTICE 'Discografia';
        END IF;

        -- Formato de fecha del álbum (DD/MM/YY)
        v_fecha_fmt := TO_CHAR(v_album.fecha_album, 'DD/MM/YY');
        RAISE NOTICE '    % : %', v_fecha_fmt, v_album.titulo_album;

        -- Bucle FOR implícito para iterar sobre los temas del álbum actual
        FOR v_tema IN (
            SELECT 
                orden,
                titulo AS titulo_tema,
                duracion
            FROM temas
            WHERE codAlbum = v_album.codAlbum
            ORDER BY orden
        ) LOOP

            -- Formato del orden a 2 dígitos (ej: 01, 02)
            v_orden_fmt := LPAD(v_tema.orden::VARCHAR, 2, '0');

            -- Formato de duración MM:SS
            v_duracion_fmt := LPAD((v_tema.duracion / 60)::VARCHAR, 2, '0') || ':' || LPAD((v_tema.duracion % 60)::VARCHAR, 2, '0');

            RAISE NOTICE '        % – % %', v_orden_fmt, v_tema.titulo_tema, v_duracion_fmt;
        END LOOP;
    END LOOP;
END;
$$;

CALL sp_listado_discografia();