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

--  1. Verificar si la noticia existe 
SELECT idNoticia INTO v_id_noticia FROM noticias WHERE LOWER(titulo) = LOWER(p_titulo_noticia);
IF v_id_noticia IS NULL THEN
	RAISE EXCEPTION 'Error: La noticia con título "%" no existe.', p_titulo_noticia;
	END IF;      

-- 2. Verificar si existe la pregunta para esa noticia 
SELECT idVotacion, fechaInicio, fechaFin, respuesta1, respuesta2, respuesta3 INTO v_id_votacion, v_fecha_inicio, v_fecha_fin, v_resp1, v_resp2, v_resp3 
FROM votaciones WHERE idNoticia = v_id_noticia AND LOWER(TRIM(pregunta)) = LOWER(TRIM(p_pregunta));
IF v_id_votacion IS NULL THEN
	RAISE EXCEPTION 'Error: No existe una votación con la pregunta "%" para la noticia "%".', p_pregunta, p_titulo_noticia;
END IF;

-- 3. Verificar si la respuesta ingresada existe entre las opciones 
IF LOWER(TRIM(p_respuesta)) = LOWER(TRIM(v_resp1)) THEN 
	v_opcion_elegida := 1; 
ELSIF LOWER(TRIM(p_respuesta)) = LOWER(TRIM(v_resp2)) THEN 
	v_opcion_elegida := 2; 
ELSIF LOWER(TRIM(p_respuesta)) = LOWER(TRIM(v_resp3)) THEN
	v_opcion_elegida := 3;
ELSE 
	RAISE EXCEPTION 'Error: La opción "%" no es una respuesta válida para esta pregunta', p_respuesta; 
END IF;

-- 4. Verificar que la fecha actual esté dentro del rango permitido 
IF CURRENT_TIMESTAMP NOT BETWEEN v_fecha_inicio AND v_fecha_fin THEN 
	RAISE EXCEPTION 'Error: La fecha de carga no se encuentra dentro del rango válido de la votación'; 
END IF;

-- 5. Incrementar en +1 la respuesta seleccionada 
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

-- 6. Calcular el porcentaje acumulado sobre el total de votos
IF v_total_votos > 0 THEN 
	p_porcentaje_respuesta := ROUND((p_votos_respuesta::NUMERIC * 100.00 / v_total_votos::NUMERIC), 2); 
ELSE p_porcentaje_respuesta := 0.00;
END IF;      

RAISE NOTICE 'Voto registrado. Respuesta "%": % voto(s) acumulado(s) (% %% del total)', p_respuesta, p_votos_respuesta, p_porcentaje_respuesta; 
END; $$;


-- =============================================================================
-- EJEMPLOS DE PRUEBA DE EJECUCIÓN (Llamadas en PostgreSQL)
-- =============================================================================

-- Caso 1: Voto exitoso en la opción 1 ('Excelente')
-- La votación tenía 9 votos en op1, 5 en op2 y 1 en op3 (total original = 15).
-- Tras sumar 1 a op1: votosOp1 = 10, total = 16, porcentaje = 62.50%.
-- CALL sp_registrar_voto('Lanzamiento de PostgreSQL 17', '¿Qué opinas de la nueva versión?', 'Excelente', NULL, NULL);

-- Caso 2: Error por respuesta inexistente
-- CALL sp_registrar_voto('Lanzamiento de PostgreSQL 17', '¿Qué opinas de la nueva versión?', 'Inaceptable', NULL, NULL);

-- Caso 3: Error por pregunta o noticia inexistente
-- CALL sp_registrar_voto('Lanzamiento de PostgreSQL 17', '¿Pregunta inexistente?', 'Excelente', NULL, NULL);

-- Caso 4: Error por votación expirada (rango de fechas vencido)
-- CALL sp_registrar_voto('Final de la Copa Mundial', '¿Quién gana?', 'Equipo A', NULL, NULL);