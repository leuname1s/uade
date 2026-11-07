-- Crear una función que reciba la descripción de un género y devuelva el nombre
-- del artista que posee más discos, que el autor con más discos durante la década
-- del 2000 (considera la década como el período 2001 – 2010)

CREATE OR REPLACE FUNCTION fn_artista_mas_discos_que_decada2000(p_descripcion_genero VARCHAR)
RETURNS VARCHAR
LANGUAGE plpgsql
AS $$ DECLARE 
v_max_discos_2000 INT := 0;
v_nombre_artista VARCHAR(200);

BEGIN 

SELECT COALESCE(MAX(cant_discos), 0) INTO v_max_discos_2000 
FROM ( 
	SELECT COUNT(*) AS cant_discos FROM albumes 
	WHERE fecha BETWEEN '2001-01-01' AND '2010-12-31' 
	GROUP BY codArtista);      
RAISE NOTICE '%', v_max_discos_2000::VARCHAR;
SELECT a.nombre INTO v_nombre_artista 
FROM artistas a JOIN albumes alb ON a.codArtista = alb.codArtista JOIN generos g ON alb.codGenero = g.codGenero 
WHERE LOWER(g.descripcion) = LOWER(p_descripcion_genero) 
GROUP BY a.codArtista, a.nombre 
HAVING COUNT(alb.codAlbum) > v_max_discos_2000 
ORDER BY COUNT(alb.codAlbum) DESC LIMIT 1;      

RETURN v_nombre_artista;

END; $$;

-- SELECT fn_artista_mas_discos_que_decada2000('Rock');
