-- 6) Crear un procedimiento que permita cambiar la categoría de una noticia. Recibe el título de una noticia y el nombre de una categoría y realice las siguientes acciones.
--  Verificar que la noticia y la categoría existen. Si no es así enviar un mensaje y finalizar el procedimiento.
--  Verificar que la noticia pertenezca a una categoría distinta de la ingresada. Caso contrario enviar un mensaje y finalizar el procedimiento.
--  Modificar la noticia con la categoría ingresada.
--  Si al actualizar se verifica que se modificaron más de un registro volver al estado original la tabla e informar la situación indicando la cantidad de registros afectados.

CREATE OR REPLACE PROCEDURE sp_cambiar_categoria_noticia_v2(
p_titulo_noticia VARCHAR,
p_nombre_categoria VARCHAR
)
LANGUAGE plpgsql
AS $$ DECLARE v_id_categoria_nueva INT; v_cant_noticias INT; v_id_categoria_actual INT; v_filas_afectadas INT; 
BEGIN 

--  Verificar si la categoría destino existe 
SELECT idCategoria INTO v_id_categoria_nueva FROM categorias WHERE LOWER(nombre) = LOWER(p_nombre_categoria);

IF v_id_categoria_nueva IS NULL THEN
	RAISE NOTICE 'La categoría "%" no existe en el sistema.', p_nombre_categoria; 
	RETURN; 
END IF;

-- Verificar que la noticia ingresada exista
SELECT COUNT(*), MAX(idCategoria) 
INTO v_cant_noticias, v_id_categoria_actual 
FROM noticias
WHERE LOWER(titulo) = LOWER(p_titulo_noticia);      


IF v_cant_noticias = 0 THEN
	RAISE NOTICE 'Error: La noticia con título "%" no existe.', p_titulo_noticia;
	RETURN;
END IF;

-- Verificar que la noticia pertenezca a una categoría distinta a la ingresada
IF v_id_categoria_actual = v_id_categoria_nueva THEN
	RAISE NOTICE 'La noticia "%" ya pertenece a la categoría "%".', p_titulo_noticia, p_nombre_categoria;
	RETURN;
END IF;

-- Modificar la categoría y controlar el número de registros afectados
UPDATE noticias SET idCategoria = v_id_categoria_nueva WHERE LOWER(titulo) = LOWER(p_titulo_noticia);

GET DIAGNOSTICS v_filas_afectadas = ROW_COUNT;

-- Si se modificaron más de un registro, forzar excepción para revertir la transacción
IF v_filas_afectadas > 1 THEN
	RAISE EXCEPTION 'Error: Existen % noticias con el título "%". El procedimiento solo puede modificar una única noticia.', v_filas_afectadas, p_titulo_noticia; 
	
	 --RAISE NOTICE 'Error: Existen % noticias con el título "%". El procedimiento solo puede modificar una única noticia.', v_filas_afectadas, p_titulo_noticia; 
	 --ROLLBACK; RETURN;	--  si uso ROLLBACK tengo que ejecutar la llamada (CALL) en otra sesión de transaccion hace que de error
END IF;

RAISE NOTICE 'Categoría de la noticia "%" modificada con éxito a "%".', p_titulo_noticia, p_nombre_categoria; 
END;
$$;

-- =============================================================================
-- EJEMPLOS DE PRUEBA DE EJECUCIÓN (Usando CALL en PostgreSQL)
-- =============================================================================

-- Caso 1: Cambio exitoso (Noticia 'Lanzamiento de PostgreSQL 17' pasa de Tecnología a Deportes)
-- CALL sp_cambiar_categoria_noticia_v2('Lanzamiento de PostgreSQL 17', 'Deportes');

-- Caso 2: Error - Categoría inexistente
-- CALL sp_cambiar_categoria_noticia_v2('Lanzamiento de PostgreSQL 17', 'Musica');

-- Caso 3: Error - Noticia inexistente
-- CALL sp_cambiar_categoria_noticia_v2('Noticia Inexistente 123', 'Deportes');

-- Caso 4: Error - Misma categoría
-- CALL sp_cambiar_categoria_noticia_v2('Lanzamiento de PostgreSQL 17', 'Tecnología');

-- Caso 5: Error - Múltiples noticias con el mismo título
-- CALL sp_cambiar_categoria_noticia_v2('Noticia Con Titulo Duplicado', 'Deportes');