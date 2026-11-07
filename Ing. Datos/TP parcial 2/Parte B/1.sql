-- Crear un procedimiento que permita cambiar la categoría de una noticia. Recibe
-- el título de una noticia y el nombre de una categoría y realice las siguientes
-- acciones.
--  Verificar que la noticia y la categoría existen. Si no es así enviar un mensaje
-- y finalizar el procedimiento.
--  Verificar que la noticia pertenezca a una categoría distinta de la ingresada.
-- Caso contrario enviar un mensaje y finalizar el procedimiento.
--  Verificar que se modificara solo una noticia (es decir que no hay más de una
-- noticia con ese título), caso contrario emitir un mensaje de error y finalizar el
-- procedimiento.

CREATE OR REPLACE PROCEDURE sp_cambiar_categoria_noticia(
p_titulo_noticia VARCHAR,
p_nombre_categoria VARCHAR
)
LANGUAGE plpgsql
AS $$ DECLARE 
v_id_categoria_nueva INT; 
v_cant_noticias INT; 
v_id_noticia INT; 
v_id_categoria_actual INT; 
BEGIN 

--  verificar si la categoría destino existe 
SELECT idCategoria INTO v_id_categoria_nueva FROM categorias WHERE LOWER(nombre) = LOWER(p_nombre_categoria);

IF v_id_categoria_nueva IS NULL THEN
	RAISE NOTICE 'La categoría "%" no existe en el sistema.', p_nombre_categoria; 
	RETURN; 
END IF;

-- Verificar que exista una sola noticia con ese nombre
SELECT COUNT(*), MAX(idNoticia), MAX(idCategoria) INTO v_cant_noticias, v_id_noticia, v_id_categoria_actual 
FROM noticias 
WHERE LOWER(titulo) = LOWER(p_titulo_noticia);      
IF v_cant_noticias = 0 THEN 
	RAISE NOTICE 'No existe noticia con el titulo %', p_titulo_noticia;
	RETURN;
ELSIF v_cant_noticias > 1 THEN 
	RAISE NOTICE 'Existen más de una noticia con el título "%"', p_titulo_noticia; 
	RETURN; 
END IF;

-- Verificar que la noticia pertenezca a una categoría distinta a la ingresada
IF v_id_categoria_actual = v_id_categoria_nueva THEN
	RAISE NOTICE 'La noticia "%" ya pertenece a la categoría "%".', p_titulo_noticia, p_nombre_categoria;
	RETURN;
END IF;

UPDATE noticias SET idCategoria = v_id_categoria_nueva WHERE idNoticia = v_id_noticia;
RAISE NOTICE 'Categoría de la noticia "%" modificada con éxito a "%".', p_titulo_noticia, p_nombre_categoria; 
END; $$;


-- CALL sp_cambiar_categoria_noticia('Lanzamiento de PostgreSQL 17', 'Deportes');

-- MUltiples noticias con el mismo tItulo
-- CALL sp_cambiar_categoria_noticia('Noticia Con Titulo Duplicado', 'Tecnología');