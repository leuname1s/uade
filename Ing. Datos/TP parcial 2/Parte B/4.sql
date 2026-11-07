-- 4) Crear un procedimiento que revuelva un listado con las noticias y sus votaciones asociadas según el nombre la categoría pasada como parámetro y realice las siguientes acciones:
--  Verifique que la categoría exista, caso contrario emitir un mensaje de error y finalizar.
--  Generar un listado con el siguiente formato:

-- Categoría : XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- Noticia : XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX (el título de la noticia)
-- Usuario Comentario
-- XXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- Pregunta : XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- Respuestas Votos
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 999
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 999
-- Noticia : XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX (el título de la noticia)
-- Usuario Comentario
-- XXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- Pregunta : XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- Respuestas Votos
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 999
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 999
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 999

CREATE OR REPLACE FUNCTION fn_listado_noticias_categoria(
p_nombre_categoria VARCHAR
)
RETURNS TABLE (linea TEXT)
LANGUAGE plpgsql
AS $$ DECLARE 
	v_id_categoria INT;
	v_nombre_categoria_real VARCHAR(100);
	rec_noticia RECORD;
	rec_comentario RECORD;
	rec_votacion RECORD;
	v_cant_comentarios INT;
	v_cant_noticias INT;
BEGIN 

-- Validar que la categoría exista 
SELECT idCategoria, nombre INTO v_id_categoria, v_nombre_categoria_real 
	FROM categorias 
	WHERE LOWER(TRIM(nombre)) = LOWER(TRIM(p_nombre_categoria));
IF v_id_categoria IS NULL THEN 
	RAISE EXCEPTION 'La categoría "%" no existe', p_nombre_categoria; 
END IF;

-- Verificar si la categoría tiene noticias asociadas 
SELECT COUNT(*) INTO v_cant_noticias FROM noticias WHERE idCategoria = v_id_categoria;      

-- Encabezado de la Categoría 
linea := 'Categoría : ' || v_nombre_categoria_real; RETURN NEXT;      
IF v_cant_noticias = 0 THEN 
	linea := ' (Sin noticias registradas para esta categoría)'; 
	RETURN NEXT; 
	RETURN; 
END IF;

-- Iterar sobre cada noticia perteneciente a la categoría 
FOR rec_noticia IN SELECT idNoticia, titulo 
	FROM noticias 
	WHERE idCategoria = v_id_categoria 
	ORDER BY idNoticia ASC 
	LOOP
		linea := 'Noticia   : ' || rec_noticia.titulo;
		RETURN NEXT;
		linea := '';
		RETURN NEXT;
-- Sección Comentarios 
		SELECT COUNT(*) INTO v_cant_comentarios 
			FROM comentarios 
			WHERE idNoticia = rec_noticia.idNoticia;
		IF v_cant_comentarios > 0 THEN
			linea := 'Usuario        Comentario';
			RETURN NEXT;
			FOR rec_comentario IN SELECT COALESCE(u.alias, u.nombre, 'Sin nombre') AS usuario, c.texto 
				FROM comentarios c LEFT JOIN usuarios u ON c.idUsuario = u.idUsuario 
				WHERE c.idNoticia = rec_noticia.idNoticia 
				ORDER BY c.idComentario ASC 
				LOOP 
					linea := RPAD(rec_comentario.usuario, 15, ' ') || rec_comentario.texto; 
					RETURN NEXT;
				END LOOP;
				linea := '';
				RETURN NEXT;
		END IF;          
-- Sección Votaciones
		FOR rec_votacion IN SELECT pregunta, respuesta1, votosOp1, respuesta2, votosOp2, respuesta3, votosOp3 
			FROM votaciones 
			WHERE idNoticia = rec_noticia.idNoticia 
			ORDER BY idVotacion ASC 
			LOOP 
				linea := 'Pregunta  : ' || rec_votacion.pregunta;
				RETURN NEXT;
				linea := 'Respuestas                                                           Votos';
				RETURN NEXT; 
				linea := RPAD(rec_votacion.respuesta1, 70, ' ') || rec_votacion.votosOp1::TEXT;
				RETURN NEXT;
				linea := RPAD(rec_votacion.respuesta2, 70, ' ') || rec_votacion.votosOp2::TEXT;
				RETURN NEXT;
				linea := RPAD(rec_votacion.respuesta3, 70, ' ') || rec_votacion.votosOp3::TEXT;
				RETURN NEXT;
				linea := '';
				RETURN NEXT;
			END LOOP;
		END LOOP;
	END; $$;


-- Procedimiento para mostrarlo
CREATE OR REPLACE PROCEDURE sp_listado_noticias_categoria(p_nombre_categoria VARCHAR)
LANGUAGE plpgsql
AS $$ DECLARE rec RECORD; 
BEGIN 
FOR rec IN SELECT linea FROM fn_listado_noticias_categoria(p_nombre_categoria) 
LOOP
	RAISE NOTICE '%', rec.linea; 
END LOOP;
END; $$;

-- CALL sp_listado_noticias_categoria('Tecnología');
