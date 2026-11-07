-- Eliminar todos los datos y resetear los campos autogenerados
TRUNCATE TABLE
  votaciones,
  privilegios,
  comentarios,
  noticias,
  categorias,
  usuarios,
  composiciones,
  itemsFactura,
  itemsPedido,
  productos,
  facturas,
  pedidos,
  clientes,
  temas,
  albumes,
  generos,
  artistas
RESTART IDENTITY CASCADE;

-- PARTE A --

INSERT INTO generos (descripcion) VALUES
('Rock'),
('Reggaeton'),
('Jazz');

INSERT INTO artistas (nombre) VALUES
('El Cuarteto de Nos'),
('WOS'),
('Bad Bunny'),
('Hiromi');

INSERT INTO albumes (titulo, fecha, codArtista, codGenero) VALUES
('Raro', '2006-05-20', 1, 1),
('Porfiado', '2012-04-25', 1, 1),
('Caravana', '2019-10-04', 2, 1),
('Oscuro Éxtasis', '2021-11-18', 2, 1),
('Un Verano Sin Ti', '2022-05-06', 3, 2),
('YHLQMDLG', '2020-02-29', 3, 2),
('Brain', '2004-04-27', 4, 3),
('Voice', '2009-06-15', 4, 3),
('Puertas', '2024-03-10', 1, 1);

INSERT INTO temas (titulo, orden, duracion, codAlbum) VALUES
('Yendo a la casa de Damián', 1, 245, 1),
('Ya no sé qué hacer conmigo', 2, 241, 1),
('Miguel Gritar', 4, 218, 1),
('Algo mejor que hacer', 1, 231, 2),
('Buen día Benito', 3, 235, 2),
('Canguro', 1, 201, 3),
('Melón Vino', 3, 185, 3),
('Arrancarmelo', 2, 183, 4),
('Culpa', 5, 208, 4),
('Moscow Mule', 1, 245, 5),
('Me Porto Bonito', 3, 178, 5),
('Tití Me Preguntó', 4, 243, 5),
('Si Veo a Tu Mamá', 1, 170, 6),
('La Difícil', 2, 163, 6),
('Kung-Fu World Champion', 1, 395, 7),
('Brain', 3, 545, 7),
('Voice', 1, 555, 8),
('Desire', 3, 430, 8);

-- Parte B --

INSERT INTO usuarios (nombre, alias, contrasena, activo, email) VALUES
('Juan Pérez', 'jperez', 'pass123', true, 'juan@mail.com'),
('María Gómez', 'mgomez', 'pass456', true, 'maria@mail.com'),
('Carlos Gómez', 'cgomez', 'pass123', true, 'cgomez@mail.com'),
('Laura Fernández', 'lfernandez', 'pass123', true, 'laura@mail.com'),
('Martín Silva', 'msilva', 'pass456', true, 'martin@mail.com'),
('Ana Morales', 'amorales', 'pass789', true, 'ana@mai.com');

INSERT INTO categorias (nombre, descripcion) VALUES
('Tecnología', 'Noticias sobre avances tecnológicos y software'),
('Deportes', 'Novedades del mundo deportivo'),
('Economía', 'Noticias sobre economía, mercados e inflación');

INSERT INTO noticias (titulo, idCategoria, idAutor, fecha, ubicacion) VALUES
('Lanzamiento de PostgreSQL 17', 1, 1, CURRENT_TIMESTAMP - INTERVAL '2 days', '/noticias/tec/pg17.txt'),
('Avances en Inteligencia Artificial', 1, 2, '2024-03-15 14:30:00', '/noticias/tec/ia.txt'),
('Final de la Copa Mundial', 2, 1, '2024-01-20 18:00:00', '/noticias/dep/copa.txt'),
('Lanzamiento del procesador Quantum X', 1, 3, CURRENT_TIMESTAMP - INTERVAL '1 day', '/noticias/quantum.txt'),
('Análisis de la inflación acumulada', 3, 4, CURRENT_TIMESTAMP - INTERVAL '10 days', '/noticias/eco/inflacion.txt'),
('Noticia Con Titulo Duplicado', 1, 1, '2026-03-01 10:00:00', '/noticias/dup1.txt'),
('Noticia Con Titulo Duplicado', 1, 2, '2026-03-02 11:00:00', '/noticias/dup2.txt');

INSERT INTO votaciones (idNoticia, fechaInicio, fechaFin, pregunta, respuesta1, respuesta2, respuesta3, votosOp1, votosOp2, votosOp3) VALUES
(1, CURRENT_TIMESTAMP - INTERVAL '2 days', CURRENT_TIMESTAMP + INTERVAL '10 days', 'Qué opinas de la nueva versión?', 'Excelente', 'Buena', 'Regular', 50, 70, 30),
(2, '2024-03-15 14:30:00', '2024-03-25 23:59:59', 'Usas IA a diario?', 'Sí', 'A veces', 'No', 100, 120, 80),
(3, '2024-01-20 00:00:00', '2024-03-25 23:59:59', 'Quién gana?', 'Equipo A', 'Equipo B', 'Empate', 200, 200, 100);

INSERT INTO comentarios (idNoticia, texto, idUsuario, fecha) VALUES
(1, 'Excelente versión, trae muchas mejoras de rendimiento en consultas concurrentes.', 1, CURRENT_TIMESTAMP - INTERVAL '1 day'),
(1, 'Muy esperadas las nuevas funciones de indexación lógica.', 2, CURRENT_TIMESTAMP - INTERVAL '12 hours'),
(2, 'La inteligencia artificial generativa está revolucionando el desarrollo de software.', 3, CURRENT_TIMESTAMP - INTERVAL '5 hours');

-- necesito usuarios con al menos 20 comentarios para probar el ejercicio 5 de la parte A. 
-- Los puse todos en una sola noticia de economía para poder probar el ejercicio 4 de la parte B sin que sea un monton de texto
-- seguro existe una forma más facil de hacer esto
INSERT INTO comentarios (idNoticia, texto, idUsuario, fecha) VALUES
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '1 day'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '2 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '3 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '4 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '5 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '6 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '7 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '8 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '9 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '10 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '12 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '12 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '13 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '14 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '15 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '16 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '17 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '18 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '19 days'),
(5, 'Comentario sobre economía', 4, CURRENT_TIMESTAMP - INTERVAL '20 days');

INSERT INTO comentarios (idNoticia, texto, idUsuario, fecha) VALUES
(5, 'Comentario breve', 5, CURRENT_TIMESTAMP - INTERVAL '1 day'),
(5, 'Comentario breve', 5, CURRENT_TIMESTAMP - INTERVAL '2 days'),
(5, 'Comentario breve', 5, CURRENT_TIMESTAMP - INTERVAL '3 days'),
(5, 'Comentario breve', 5, CURRENT_TIMESTAMP - INTERVAL '4 days'),
(5, 'Comentario breve', 5, CURRENT_TIMESTAMP - INTERVAL '5 days'),
(5, 'Comentario breve', 5, CURRENT_TIMESTAMP - INTERVAL '6 days'),
(5, 'Comentario breve', 5, CURRENT_TIMESTAMP - INTERVAL '7 days'),
(5, 'Comentario breve', 5, CURRENT_TIMESTAMP - INTERVAL '8 days'),
(5, 'Comentario breve', 5, CURRENT_TIMESTAMP - INTERVAL '9 days'),
(5, 'Comentario breve', 5, CURRENT_TIMESTAMP - INTERVAL '10 days'),
(5, 'Comentario breve', 5, CURRENT_TIMESTAMP - INTERVAL '11 days'),
(5, 'Comentario breve', 5, CURRENT_TIMESTAMP - INTERVAL '12 days'),
(5, 'Comentario breve', 5, CURRENT_TIMESTAMP - INTERVAL '13 days'),
(5, 'Comentario breve', 5, CURRENT_TIMESTAMP - INTERVAL '14 days'),
(5, 'Comentario breve', 5, CURRENT_TIMESTAMP - INTERVAL '15 days');

INSERT INTO comentarios (idNoticia, texto, idUsuario, fecha) VALUES
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '1 hour'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '2 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '3 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '4 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '5 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '6 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '7 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '8 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '9 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '10 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '11 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '12 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '13 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '14 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '15 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '16 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '16 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '17 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '18 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '19 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '20 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '22 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '23 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '24 hours'),
(5, 'Comentario antiguo ', 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - INTERVAL '25 hours');

INSERT INTO privilegios (idUsuario, privilegio, idCategoria) VALUES
(1, 'Crear Noticia', 1),
(1, 'Responsable', 2);

INSERT INTO productos (descripcion, stock, puntoReposicion, precio) VALUES
('Procesador Intel i7', 50, 10, 300.00),
('Placa Madre Z790', 40, 5, 200.00),
('Memoria RAM 32GB', 100, 20, 150.00),
('Placa de Video RTX 4070', 30, 5, 600.00),
('Fuente de Alimentación 850W', 60, 10, 120.00),
('Combo PC Gamer Ultra', 15, 3, 1000.00),
('Kit Upgrade CPU + RAM', 25, 5, 500.00);

INSERT INTO composiciones (codProducto, codProductoComponente, cantidad) VALUES
(6, 1, 1), 
(6, 2, 1),
(6, 3, 1),
(6, 4, 1),
(7, 1, 1),
(7, 3, 1);

INSERT INTO clientes (nombre, saldo) VALUES
('Empresa Tenologica del norte', 1500.00), 
('Comercial del Sur', 0.00);       

-- pedidos
INSERT INTO pedidos (fecha, codCliente, fechaEntrega, lugarEntrega) VALUES
('2026-02-10', 1, '2026-02-15', 'Av. Corrientes 1234'),
('2026-02-12', 2, '2026-02-16', 'Calle Belgrano 567'),
('2026-03-01', 1, '2026-03-05', 'Av. Corrientes 1234'),
('2026-01-10', 1, '2026-01-15', 'Av. Corrientes 1234, CABA'), 
('2026-02-12', 2, '2026-02-18', 'Calle Belgrano 567'),
('2026-02-14', 1, '2026-02-20', 'Av. Corrientes 1234, CABA'),
('2026-03-10', 2, '2026-03-15', 'Calle 50 #432, La Plata'),
('2026-04-05', 1, '2026-04-10', 'Av. Corrientes 1234, CABA'),
('2026-01-15', 1, '2026-01-20', 'Av. Corrientes 1234, CABA');

INSERT INTO itemsPedido (codProducto, nroPedido, cantidad) VALUES
(6, 1, 2), 
(7, 1, 1),
(6, 2, 1),
(3, 3, 2),
(5, 3, 1),
(1, 4, 50),
(2, 5, 20),
(1, 6, 50),
(2, 7, 20),
(7, 8, 3),
(7, 9, 2),
(5, 9, 1);

-- Facturas
INSERT INTO facturas (fecha, codCliente, codPedido, bruto, iva, iibb, final) VALUES
('2026-02-10', 1, 1, 2500.00, 525.00, 75.00, 3100.00),
('2026-02-12', 2, 2, 1000.00, 210.00, 30.00, 1240.00),
('2026-08-11', 1, 3, 8200.00, 1722.00, 246.00, 10168.00),
('2026-08-13', 1, 4, 500.00, 105.00, 15.00, 620.00),
('2026-02-12', 2, 5, 300.00, 63.00, 9.00, 372.00),
('2026-02-14', 1, 6, 500.00, 105.00, 15.00, 620.00),
('2026-03-12', 2, 7, 300.00, 63.00, 9.00, 372.00),
('2026-04-08', 1, 8, 10500.00, 2205.00, 315.00, 13020.00),
('2026-01-15', 1, 9, 8200.00, 1722.00, 246.00, 10168.00);

INSERT INTO itemsFactura (codProducto, nroFactura, cantidad, precio, descuento) VALUES
(6, 1, 2, 1000.00, 0.00),
(7, 1, 1, 500.00, 0.00),
(6, 2, 1, 1000.00, 10.00),
(3, 3, 2, 3500.00, 0.00),
(5, 3, 1, 1200.00, 0.00),
(1, 4, 50, 10.00, 0.00),
(2, 5, 20, 15.00, 0.00),
(1, 6, 50, 10.00, 0.00),
(2, 7, 20, 15.00, 0.00),
(7, 8, 3, 3500.00, 0.00),
(7, 9, 2, 3500.00, 0.00),
(5, 9, 1, 1200.00, 0.00);