-- Crear una función de determine quienes son los usuarios que al menos hicieron
-- 20 comentarios a noticias de genero economía en los últimos 30 días. Indique el
-- nombre de los usuarios.

CREATE OR REPLACE FUNCTION fn_usuarios_activos_economia()
RETURNS TABLE (
nombre_usuario VARCHAR
)
LANGUAGE plpgsql
AS $$ BEGIN RETURN QUERY 
SELECT u.nombre AS nombre_usuario 
FROM usuarios u 
JOIN comentarios com ON u.idUsuario = com.idUsuario 
JOIN noticias n ON com.idNoticia = n.idNoticia 
JOIN categorias cat ON n.idCategoria = cat.idCategoria 
WHERE LOWER(cat.nombre) IN ('economía', 'economia') 
AND com.fecha >= CURRENT_TIMESTAMP - INTERVAL '30 days' 
GROUP BY u.idUsuario, u.nombre HAVING COUNT(com.idComentario) >= 20; END; $$;

SELECT * FROM fn_usuarios_activos_economia();