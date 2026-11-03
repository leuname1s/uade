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
AS $$ DECLARE v_id_categoria_nueva INT; v_cant_noticias INT; v_id_noticia INT; v_id_categoria_actual INT; 
BEGIN 
-- Validar parámetros de entrada  
IF p_titulo_noticia IS NULL OR TRIM(p_titulo_noticia) = '' THEN 
	RAISE NOTICE 'El título de la noticia no puede ser nulo o vacío.'; 
	RETURN; 
END IF;
IF p_nombre_categoria IS NULL OR TRIM(p_nombre_categoria) = '' THEN
	RAISE NOTICE 'El nombre de la categoría no puede ser nulo o vacío.'; 
	RETURN;
END IF;

-- 1. Verificar si la categoría destino existe 
SELECT idCategoria INTO v_id_categoria_nueva FROM categorias WHERE LOWER(nombre) = LOWER(p_nombre_categoria);

IF v_id_categoria_nueva IS NULL THEN
	RAISE NOTICE 'La categoría "%" no existe en el sistema.', p_nombre_categoria; 
	RETURN; 
END IF;

-- 1 y 3. Verificar existencia de la noticia y validar que sea ÚNICA 
SELECT COUNT(*), MAX(idNoticia), MAX(idCategoria) INTO v_cant_noticias, v_id_noticia, v_id_categoria_actual FROM noticias 
WHERE LOWER(titulo) = LOWER(p_titulo_noticia);      
IF v_cant_noticias = 0 THEN 
	RAISE NOTICE 'La noticia con título "%" no existe.', p_titulo_noticia;
	RETURN;
ELSIF v_cant_noticias > 1 THEN 
	RAISE NOTICE 'Error: Existen % noticias con el título "%". El procedimiento solo puede modificar una única noticia.', v_cant_noticias, p_titulo_noticia; 
	RETURN; 
END IF;

--  2. Verificar que la noticia pertenezca a una categoría distinta 
IF v_id_categoria_actual = v_id_categoria_nueva THEN 
	RAISE NOTICE 'La noticia "%" ya pertenece a la categoría "%". Sin cambios realizados.', p_titulo_noticia, p_nombre_categoria; 
	RETURN;
END IF;

-- Modificación de la categoría 
UPDATE noticias SET idCategoria = v_id_categoria_nueva WHERE idNoticia = v_id_noticia;
RAISE NOTICE 'Categoría de la noticia "%" modificada con éxito a "%".', p_titulo_noticia, p_nombre_categoria; 
END; $$;

-- =============================================================================
-- EJEMPLOS DE PRUEBA DE EJECUCIÓN (Usando CALL en PostgreSQL)
-- =============================================================================

-- Caso 1: Cambio exitoso (Noticia 'Lanzamiento de PostgreSQL 17' pasa de Tecnología a Deportes)
 CALL sp_cambiar_categoria_noticia('Lanzamiento de PostgreSQL 17', 'Deportes');

-- Caso 2: Error - Categoría inexistente
-- CALL sp_cambiar_categoria_noticia('Lanzamiento de PostgreSQL 17', 'Musica');

-- Caso 3: Error - Noticia inexistente
-- CALL sp_cambiar_categoria_noticia('Noticia Inexistente 123', 'Deportes');

-- Caso 4: Error - Misma categoría
-- CALL sp_cambiar_categoria_noticia('Lanzamiento de PostgreSQL 17', 'Tecnología');

-- Caso 5: Error - Múltiples noticias con el mismo título
-- CALL sp_cambiar_categoria_noticia('Noticia Con Titulo Duplicado', 'Deportes');