-- 5) Crear un procedimiento que permita crear un usuario y asignarle privilegios. Recibirá el Nombre, un Alias, una dirección de correo electrónico, el tipo de privilegio y una lista de hasta 3 nombres de categoría a asignarle el privilegio y realice las siguientes acciones:
--  Verifique que el alias no existe, caso contrario emitir un mensaje de error y finalizar.
--  Verificar que el privilegio asignado sea correcto, caso contrario emitir un mensaje de error y finalizar.
--  Verificar que al menos uno de los géneros tenga un valor y que los ingresados sean correctos, caso contrario emitir un mensaje de error y finalizar.
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

-- Validaciones iniciales de parámetros
IF p_alias IS NULL OR TRIM(p_alias) = '' THEN 
	RAISE NOTICE 'Error: El alias no puede ser nulo o vacío.'; 
	RETURN;
END IF;
IF p_nombre IS NULL OR TRIM(p_nombre) = '' THEN
	RAISE NOTICE 'Error: El nombre del usuario no puede ser nulo o vacío.';
	RETURN;
END IF;

-- Verificar si el alias ya existe 
IF EXISTS (SELECT 1 FROM usuarios WHERE LOWER(TRIM(alias)) = LOWER(TRIM(p_alias))) THEN 
	RAISE NOTICE 'Error: El alias "%" ya existe en el sistema.', p_alias;
	RETURN;
END IF;

-- Verificar que el privilegio asignado sea correcto 
IF p_privilegio IS NULL OR TRIM(p_privilegio) NOT IN ('Crear Noticia', 'Responsable') THEN
	RAISE NOTICE 'Error: El privilegio "%" no es válido. Los valores válidos son "Crear Noticia" y "Responsable".', p_privilegio;
	RETURN;
END IF;

-- Verificar que al menos una categoría tenga valor y que existan 
IF (p_cat1 IS NULL OR TRIM(p_cat1) = '') AND (p_cat2 IS NULL OR TRIM(p_cat2) = '') AND (p_cat3 IS NULL OR TRIM(p_cat3) = '') THEN
	RAISE NOTICE 'Error: Debe ingresar al menos una categoría para asignar privilegios.';
	RETURN;
END IF;

-- Validar existencia de Categoría 1 
IF p_cat1 IS NOT NULL AND TRIM(p_cat1) <> '' THEN
	SELECT idCategoria INTO v_cat1_id FROM categorias WHERE LOWER(TRIM(nombre)) = LOWER(TRIM(p_cat1));
	IF v_cat1_id IS NULL THEN
		RAISE NOTICE 'Error: La categoría "%" no existe.', p_cat1;
		RETURN;
	END IF;
END IF;

-- Validar existencia de Categoría 2 
IF p_cat2 IS NOT NULL AND TRIM(p_cat2) <> '' THEN 
	SELECT idCategoria INTO v_cat2_id FROM categorias WHERE LOWER(TRIM(nombre)) = LOWER(TRIM(p_cat2)); 
	IF v_cat2_id IS NULL THEN 
		RAISE NOTICE 'Error: La categoría "%" no existe.', p_cat2;
		RETURN;
	END IF;
END IF;

-- Validar existencia de Categoría 3
IF p_cat3 IS NOT NULL AND TRIM(p_cat3) <> '' THEN
	SELECT idCategoria INTO v_cat3_id FROM categorias WHERE LOWER(TRIM(nombre)) = LOWER(TRIM(p_cat3));
	IF v_cat3_id IS NULL THEN
		RAISE NOTICE 'Error: La categoría "%" no existe.', p_cat3;
		RETURN;
	END IF;
END IF;

-- Generar contraseña: Alias + número del día del ingreso (DD)
v_dia := TO_CHAR(CURRENT_DATE, 'DD');
v_password := TRIM(p_alias) || v_dia;

-- Crear usuario 
INSERT INTO usuarios (nombre, alias, contrasena, activo, email) 
	VALUES (TRIM(p_nombre), TRIM(p_alias), v_password, TRUE, TRIM(p_email)) 
	RETURNING idUsuario INTO v_id_usuario;

-- Insertar privilegios asignados 
IF v_cat1_id IS NOT NULL THEN
	INSERT INTO privilegios (idUsuario, privilegio, idCategoria)
	VALUES (v_id_usuario, TRIM(p_privilegio), v_cat1_id) ON CONFLICT DO NOTHING;
END IF;

IF v_cat2_id IS NOT NULL AND v_cat2_id <> COALESCE(v_cat1_id, -1) THEN
	INSERT INTO privilegios (idUsuario, privilegio, idCategoria) 
	VALUES (v_id_usuario, TRIM(p_privilegio), v_cat2_id) ON CONFLICT DO NOTHING;
END IF;

IF v_cat3_id IS NOT NULL AND v_cat3_id <> COALESCE(v_cat1_id, -1) AND v_cat3_id <> COALESCE(v_cat2_id, -1) THEN
	INSERT INTO privilegios (idUsuario, privilegio, idCategoria) 
	VALUES (v_id_usuario, TRIM(p_privilegio), v_cat3_id) ON CONFLICT DO NOTHING;
END IF;

RAISE NOTICE 'Usuario "%" creado exitosamente (ID %). Contraseña generada: "%". Privilegio "%" asignado correctamente.', p_alias, v_id_usuario, v_password, p_privilegio; 
END; $$;


-- =============================================================================
-- EJEMPLOS DE PRUEBA DE EJECUCIÓN (Usando CALL en PostgreSQL)
-- =============================================================================

-- Caso 1: Creación exitosa con 2 categorías
-- CALL sp_crear_usuario_con_privilegios('Roberto Gómez', 'rgomez', 'rgomez@example.com', 'Crear Noticia', 'Tecnología', 'Deportes');

-- Caso 2: Error - Alias duplicado ('jperez' ya existe)
-- CALL sp_crear_usuario_con_privilegios('Juan Pérez Dos', 'jperez', 'jperez2@example.com', 'Responsable', 'Tecnología');

-- Caso 3: Error - Privilegio inválido ('Administrador')
-- CALL sp_crear_usuario_con_privilegios('Esteban Quito', 'equito', 'equito@example.com', 'Administrador', 'Tecnología');

-- Caso 4: Error - Sin categorías ingresadas
-- CALL sp_crear_usuario_con_privilegios('Esteban Quito', 'equito', 'equito@example.com', 'Crear Noticia');

-- Caso 5: Error - Categoría inexistente ('Música')
-- CALL sp_crear_usuario_con_privilegios('Esteban Quito', 'equito', 'equito@example.com', 'Responsable', 'Música');