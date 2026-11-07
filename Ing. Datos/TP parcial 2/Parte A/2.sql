-- Crear una funciona que devuelva la lista de temas de acuerdo el nombre de un
-- artista pasado como parámetro. Informe el nombre del tema, la duración, el
-- orden el nombre del álbum donde se encuentra.

CREATE OR REPLACE FUNCTION fn_obtener_temas_por_artista(p_nombre_artista VARCHAR)
RETURNS TABLE (
nombre_tema VARCHAR,
duracion INT,
orden INT,
nombre_album VARCHAR
)
LANGUAGE plpgsql
AS $$ BEGIN 

RETURN QUERY
SELECT t.titulo AS nombre_tema, t.duracion AS duracion, t.orden AS orden, a.titulo AS nombre_album 
FROM temas t JOIN albumes a ON t.codAlbum = a.codAlbum JOIN artistas art ON a.codArtista = art.codArtista 
WHERE LOWER(art.nombre) = LOWER(p_nombre_artista) 
ORDER BY a.titulo, t.orden;
END; $$;

-- SELECT * FROM fn_obtener_temas_por_artista('El Cuarteto de Nos');
