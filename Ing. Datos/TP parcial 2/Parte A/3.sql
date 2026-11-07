-- Crear una función que devuelva el título de la noticia más votada en un rango de
-- fechas determinado pasado como parámetro.

CREATE OR REPLACE FUNCTION fn_noticia_mas_votada(
p_fecha_desde TIMESTAMP,
p_fecha_hasta TIMESTAMP
)
RETURNS VARCHAR
LANGUAGE plpgsql
AS $$ DECLARE 
v_titulo_noticia VARCHAR(250);

BEGIN 
SELECT n.titulo INTO v_titulo_noticia 
FROM noticias n JOIN votaciones v ON n.idNoticia = v.idNoticia 
WHERE n.fecha BETWEEN p_fecha_desde AND p_fecha_hasta 
GROUP BY n.idNoticia, n.titulo 
ORDER BY SUM(v.votosOp1 + v.votosOp2 + v.votosOp3) DESC LIMIT 1;      

RETURN v_titulo_noticia; 

END; $$;

-- SELECT fn_noticia_mas_votada('2024-03-01 00:00:00', '2024-03-31 23:59:59');

-- SELECT fn_noticia_mas_votada('2024-01-01 00:00:00', '2024-01-31 23:59:59');