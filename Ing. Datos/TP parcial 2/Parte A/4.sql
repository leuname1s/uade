-- Crear una función que retorne la cantidad de votos en una fecha determinada
-- pasada como parámetro. Indicar la fecha, el título, el nombre de la categoría, la
-- pregunta y la cantidad de votos totales recibidos, las respuestas y sus cantidades
-- de votos.

CREATE OR REPLACE FUNCTION fn_votos_por_fecha(p_fecha DATE)
RETURNS TABLE (
fecha_consultada DATE,
titulo_noticia VARCHAR,
nombre_categoria VARCHAR,
pregunta TEXT,
votos_totales INT,
respuesta_1 VARCHAR,
votos_resp_1 INT,
respuesta_2 VARCHAR,
votos_resp_2 INT,
respuesta_3 VARCHAR,
votos_resp_3 INT
)
LANGUAGE plpgsql
AS $$ BEGIN 
RETURN QUERY 
SELECT p_fecha AS fecha_consultada, 
	n.titulo AS titulo_noticia, 
	c.nombre AS nombre_categoria,
	v.pregunta,
	(v.votosOp1 + v.votosOp2 + v.votosOp3) AS votos_totales,
	v.respuesta1 AS respuesta_1,
	v.votosOp1 AS votos_resp_1,
	v.respuesta2 AS respuesta_2,
	v.votosOp2 AS votos_resp_2,
	v.respuesta3 AS respuesta_3,
	v.votosOp3 AS votos_resp_3
FROM votaciones v JOIN noticias n ON v.idNoticia = n.idNoticia LEFT JOIN categorias c ON n.idCategoria = c.idCategoria 
WHERE p_fecha BETWEEN v.fechaInicio::DATE AND v.fechaFin::DATE; END; $$;

-- Ejemplo de uso:
-- SELECT * FROM fn_votos_por_fecha('2026-03-05');