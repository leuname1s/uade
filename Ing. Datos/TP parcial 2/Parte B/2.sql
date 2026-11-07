-- 2) Crear un procedimiento que permita cargar votos. Recibirá el título de la noticia,
-- la pregunta, y la respuesta votada y realizará las siguientes acciones:
--  Verificar que la noticia, la pregunta y la respuesta existan, caso contrario
-- emitir un error.
--  Verificar que la fecha de carga este comprendida en el rango de fechas valido
-- para esa votación, caso contrario emitir un error.
--  Sumarle uno a la cantidad de votos de la respuesta ingresada.
--  Devolver en dos variables de output la cantidad de votos recibida por esa
-- respuesta hasta el momento y el porcentaje que representa esa cantidad
-- sobre el total de votos.

CREATE OR REPLACE PROCEDURE sp_registrar_voto(
p_titulo_noticia VARCHAR,
p_pregunta TEXT,
p_respuesta VARCHAR,
OUT p_votos_respuesta INT,
OUT p_porcentaje_respuesta NUMERIC(5,2)
)
LANGUAGE plpgsql
AS $$ DECLARE 
	v_id_noticia INT;
	v_id_votacion INT;
	v_fecha_inicio TIMESTAMP;
	v_fecha_fin TIMESTAMP;
	v_resp1 VARCHAR(250);
	v_resp2 VARCHAR(250);
	v_resp3 VARCHAR(250);
	v_opcion_elegida INT := 0;
	v_total_votos INT := 0;
BEGIN 

-- ver si la noticia existe 
SELECT idNoticia INTO v_id_noticia FROM noticias WHERE LOWER(titulo) = LOWER(p_titulo_noticia);
IF v_id_noticia IS NULL THEN
	RAISE EXCEPTION 'La noticia "%" no existe.', p_titulo_noticia;
	END IF;      

-- chequear la pregunta para esa noticia 
SELECT idVotacion, fechaInicio, fechaFin, respuesta1, respuesta2, respuesta3 INTO v_id_votacion, v_fecha_inicio, v_fecha_fin, v_resp1, v_resp2, v_resp3 
FROM votaciones 
WHERE idNoticia = v_id_noticia AND LOWER(TRIM(pregunta)) = LOWER(TRIM(p_pregunta));

IF v_id_votacion IS NULL THEN
	RAISE EXCEPTION 'No existe una votación con la pregunta "%" para esta noticia', p_pregunta;
END IF;

-- verificar la respuesta  
IF LOWER(TRIM(p_respuesta)) = LOWER(TRIM(v_resp1)) THEN 
	v_opcion_elegida := 1; 
ELSIF LOWER(TRIM(p_respuesta)) = LOWER(TRIM(v_resp2)) THEN 
	v_opcion_elegida := 2; 
ELSIF LOWER(TRIM(p_respuesta)) = LOWER(TRIM(v_resp3)) THEN
	v_opcion_elegida := 3;
ELSE 
	RAISE EXCEPTION '"%" no es una respuesta válida para esta pregunta', p_respuesta; 
END IF;

IF CURRENT_TIMESTAMP NOT BETWEEN v_fecha_inicio AND v_fecha_fin THEN 
	RAISE EXCEPTION 'No se encuentra en el rango de fechas para votar'; 
END IF;

-- agregar voto 
IF v_opcion_elegida = 1 THEN
	UPDATE votaciones SET votosOp1 = votosOp1 + 1 WHERE idVotacion = v_id_votacion 
	RETURNING votosOp1, (votosOp1 + votosOp2 + votosOp3) INTO p_votos_respuesta, v_total_votos;
ELSIF v_opcion_elegida = 2 THEN 
	UPDATE votaciones SET votosOp2 = votosOp2 + 1 WHERE idVotacion = v_id_votacion 
	RETURNING votosOp2, (votosOp1 + votosOp2 + votosOp3) INTO p_votos_respuesta, v_total_votos; 
ELSIF v_opcion_elegida = 3 THEN 
	UPDATE votaciones SET votosOp3 = votosOp3 + 1 WHERE idVotacion = v_id_votacion 
	RETURNING votosOp3, (votosOp1 + votosOp2 + votosOp3) INTO p_votos_respuesta, v_total_votos;
END IF;

-- calcular porcentaje
IF v_total_votos > 0 THEN 
	p_porcentaje_respuesta := ROUND((p_votos_respuesta::NUMERIC * 100.00 / v_total_votos::NUMERIC), 2); 
ELSE 
	p_porcentaje_respuesta := 0.00;
END IF;      

RAISE NOTICE 'Voto registrado';
RAISE NOTICE 'Respuesta "%": % voto(s) acumulado(s) (% %% del total)', p_respuesta, p_votos_respuesta, p_porcentaje_respuesta; 

END; $$;


-- CALL sp_registrar_voto('Lanzamiento de PostgreSQL 17', 'Qué opinas de la nueva versión?', 'Excelente', NULL, NULL);

-- votación expirada
-- CALL sp_registrar_voto('Final de la Copa Mundial', '¿Quién gana?', 'Equipo A', NULL, NULL);