-- 5) Crear un procedimiento que permita crear un usuario y asignarle privilegios. Recibirá el Nombre, un Alias, una dirección de correo electrónico, el tipo de privilegio y una lista de hasta 3 nombres de categoría a asignarle el privilegio y realice las siguientes acciones:
--  Verifique que el alias no existe, caso contrario emitir un mensaje de error y finalizar.
--  Verificar que el privilegio asignado sea correcto, caso contrario emitir un mensaje de error y finalizar.
--  Verificar que al menos uno de las categorías tenga un valor y que los ingresados sean correctos, caso contrario emitir un mensaje de error y finalizar.
--  Crear al usuario y agregarle los privilegios correspondientes. El password de un usuario nuevo debe ser igual al alias concatenado con el número de día del ingreso.


CREATE OR REPLACE PROCEDURE sp_crear_usuario_con_privilegios(
p_nombre VARCHAR,
p_alias VARCHAR,
p_email VARCHAR,
p_privilegio VARCHAR,
p_cat1 VARCHAR DEFAULT NULL,
p_cat2 VARCHAR DEFAULT NULL,
p_cat3 VARCHAR DEFAULT NULL
)
LANGUAGE plpgsql
AS $$ DECLARE 
v_id_usuario INT;
v_password VARCHAR(255);
v_cat1_id INT := NULL;
v_cat2_id INT := NULL;
v_cat3_id INT := NULL;
v_dia VARCHAR(2);
BEGIN 

IF p_alias IS NULL OR TRIM(p_alias) = '' THEN 
	RAISE EXCEPTION 'Por favor, ingrese un valor para el alias'; 
END IF;
IF p_nombre IS NULL OR TRIM(p_nombre) = '' THEN
	RAISE EXCEPTION 'Por favor, ingrese un valor para el nombre';
END IF;

-- Chequear alias duplicado 
IF EXISTS (SELECT 1 FROM usuarios WHERE LOWER(TRIM(alias)) = LOWER(TRIM(p_alias))) THEN 
	RAISE EXCEPTION 'El alias "%" ya existe en el sistema.', p_alias;
END IF;

-- Verificar que el privilegio asignado sea correcto 
IF p_privilegio IS NULL OR TRIM(p_privilegio) NOT IN ('Crear Noticia', 'Responsable') THEN
	RAISE EXCEPTION 'El privilegio "%" no es válido. Las opcioes son "Crear Noticia" y "Responsable".', p_privilegio;
END IF;

-- Verificar que al menos una categoría tenga valor y que existan 
IF (p_cat1 IS NULL OR TRIM(p_cat1) = '') AND (p_cat2 IS NULL OR TRIM(p_cat2) = '') AND (p_cat3 IS NULL OR TRIM(p_cat3) = '') THEN
	RAISE EXCEPTION 'Ingresar al menos una categoría';
END IF;

-- Validar existencia de Categoría 1 
IF p_cat1 IS NOT NULL AND TRIM(p_cat1) <> '' THEN
	SELECT idCategoria INTO v_cat1_id FROM categorias WHERE LOWER(TRIM(nombre)) = LOWER(TRIM(p_cat1));
	IF v_cat1_id IS NULL THEN
		RAISE EXCEPTION 'La categoría "%" no existe.', p_cat1;
	END IF;
END IF;

-- Validar existencia de Categoría 2 
IF p_cat2 IS NOT NULL AND TRIM(p_cat2) <> '' THEN 
	SELECT idCategoria INTO v_cat2_id FROM categorias WHERE LOWER(TRIM(nombre)) = LOWER(TRIM(p_cat2)); 
	IF v_cat2_id IS NULL THEN 
		RAISE EXCEPTION 'La categoría "%" no existe.', p_cat2;
	END IF;
END IF;

-- Validar existencia de Categoría 3
IF p_cat3 IS NOT NULL AND TRIM(p_cat3) <> '' THEN
	SELECT idCategoria INTO v_cat3_id FROM categorias WHERE LOWER(TRIM(nombre)) = LOWER(TRIM(p_cat3));
	IF v_cat3_id IS NULL THEN
		RAISE EXCEPTION 'La categoría "%" no existe.', p_cat3;
	END IF;
END IF;

-- Generar contraseña
v_dia := TO_CHAR(CURRENT_DATE, 'DD');
v_password := TRIM(p_alias) || v_dia;

-- generar usuario 
INSERT INTO usuarios (nombre, alias, contrasena, activo, email) 
	VALUES (TRIM(p_nombre), TRIM(p_alias), v_password, TRUE, TRIM(p_email)) 
	RETURNING idUsuario INTO v_id_usuario;

-- generar privilegios 
IF v_cat1_id IS NOT NULL THEN
	INSERT INTO privilegios (idUsuario, privilegio, idCategoria)
	VALUES (v_id_usuario, TRIM(p_privilegio), v_cat1_id);
END IF;

IF v_cat2_id IS NOT NULL AND v_cat2_id <> COALESCE(v_cat1_id, -1) THEN
	INSERT INTO privilegios (idUsuario, privilegio, idCategoria) 
	VALUES (v_id_usuario, TRIM(p_privilegio), v_cat2_id);
END IF;

IF v_cat3_id IS NOT NULL AND v_cat3_id <> COALESCE(v_cat1_id, -1) AND v_cat3_id <> COALESCE(v_cat2_id, -1) THEN
	INSERT INTO privilegios (idUsuario, privilegio, idCategoria) 
	VALUES (v_id_usuario, TRIM(p_privilegio), v_cat3_id);
END IF;

RAISE NOTICE 'Usuario "%" creado exitosamente (ID %)', p_alias, v_id_usuario; 

END; $$;



-- CALL sp_crear_usuario_con_privilegios('Roberto Gómez', 'rgomez', 'rgomez@example.com', 'Crear Noticia', 'Tecnología', 'Deportes');

-- alias duplicado
-- CALL sp_crear_usuario_con_privilegios('Juan Pérez Dos', 'jperez', 'jperez2@example.com', 'Responsable', 'Tecnología');
