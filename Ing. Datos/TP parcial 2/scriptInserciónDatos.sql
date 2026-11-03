-- =============================================================================
-- SCRIPT ACUMULADO DE LIMPIEZA E INSERCIÓN DE DATOS DE PRUEBA
-- =============================================================================

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
-- =============================================================================
-- 1. MÚSICA (Ejercicios 1 y 2)
-- =============================================================================

INSERT INTO generos (codGenero, descripcion) VALUES
(1, 'Rock'),
(2, 'Pop'),
(3, 'Jazz');

INSERT INTO artistas (codArtista, nombre) VALUES
(1, 'Genesis'),
(2, 'Coldplay'),
(3, 'The Beatles'),
(4, 'Queen');

INSERT INTO albumes (codAlbum, titulo, fecha, codArtista, codGenero) VALUES
(1, 'Parachutes', '2001-07-10', 2, 1),
(2, 'A Rush of Blood to the Head', '2002-08-26', 2, 1),
(3, 'Foxtrot', '1972-10-06', 1, 1),
(4, 'Selling England by the Pound', '1973-10-12', 1, 1),
(5, 'The Lamb Lies Down on Broadway', '1974-11-18', 1, 1),
(6, 'Abbey Road', '1969-09-26', 3, 1),
(7, 'Revolver', '1966-08-05', 3, 1),
(8, 'A Kind of Magic', '1986-06-02', 4, 2);

INSERT INTO temas (titulo, orden, duracion, codAlbum) VALUES
('Watcher of the Skies', 1, 443, 3),
('Time Table', 2, 286, 3),
('Get Em Out by Friday', 3, 515, 3),
('Suppers Ready', 6, 1374, 3),
('The Lamb Lies Down on Broadway', 1, 290, 5),
('Fly on a Windshield', 2, 167, 5),
('The Lamia', 9, 417, 5),
('Dont Panic', 1, 137, 1),
('Shiver', 2, 300, 1),
('Yellow', 5, 269, 1),
('Trouble', 6, 270, 1);

-- =============================================================================
-- 2. NOTICIAS Y VOTACIONES (Ejercicios 3, 4, 7, 8 y 10)
-- =============================================================================

INSERT INTO usuarios (nombre, alias, contrasena, activo, email) VALUES
('Juan Pérez', 'jperez', 'pass123', true, 'juan@example.com'),
('María Gómez', 'mgomez', 'pass456', true, 'maria@example.com'),
('Carlos Gómez', 'cgomez', 'pass123', true, 'cgomez@example.com');

INSERT INTO categorias (nombre, descripcion) VALUES
('Tecnología', 'Noticias sobre avances tecnológicos y software'),
('Deportes', 'Novedades del mundo deportivo');

INSERT INTO noticias (titulo, idCategoria, idAutor, fecha, ubicacion) VALUES
('Lanzamiento de PostgreSQL 17', 1, 1, CURRENT_TIMESTAMP - INTERVAL '2 days', '/noticias/tec/pg17.txt'),
('Avances en Inteligencia Artificial', 1, 2, '2024-03-15 14:30:00', '/noticias/tec/ia.txt'),
('Final de la Copa Mundial', 2, 1, '2024-01-20 18:00:00', '/noticias/dep/copa.txt'),
('Lanzamiento del procesador Quantum X', 1, 3, CURRENT_TIMESTAMP - INTERVAL '1 day', '/noticias/quantum.txt');

-- Votaciones para Noticias de Tecnología
INSERT INTO votaciones (idNoticia, fechaInicio, fechaFin, pregunta, respuesta1, respuesta2, respuesta3, votosOp1, votosOp2, votosOp3) VALUES
(1, CURRENT_TIMESTAMP - INTERVAL '2 days', CURRENT_TIMESTAMP + INTERVAL '10 days', '¿Qué opinas de la nueva versión?', 'Excelente', 'Buena', 'Regular', 50, 70, 30),
(2, '2024-03-15 14:30:00', '2024-03-25 23:59:59', '¿Usas IA a diario?', 'Sí', 'A veces', 'No', 100, 120, 80),
(3, '2024-01-20 00:00:00', '2024-01-30 23:59:59', '¿Quién gana?', 'Equipo A', 'Equipo B', 'Empate', 200, 200, 100);

-- Comentarios de prueba para Noticias de Tecnología
INSERT INTO comentarios (idNoticia, texto, idUsuario, fecha) VALUES
(1, 'Excelente versión, trae muchas mejoras de rendimiento en consultas concurrentes.', 1, CURRENT_TIMESTAMP - INTERVAL '1 day'),
(1, 'Muy esperadas las nuevas funciones de indexación lógica.', 2, CURRENT_TIMESTAMP - INTERVAL '12 hours'),
(2, 'La inteligencia artificial generativa está revolucionando el desarrollo de software.', 3, CURRENT_TIMESTAMP - INTERVAL '5 hours');

-- =============================================================================
-- 3. CATEGORÍA ECONOMÍA Y COMENTARIOS (Ejercicio 5)
-- =============================================================================

INSERT INTO categorias (nombre, descripcion) VALUES
('Economía', 'Noticias sobre economía, mercados e inflación');

INSERT INTO usuarios (nombre, alias, contrasena, activo, email) VALUES
('Laura Fernández', 'lfernandez', 'pass123', true, 'laura@example.com'),
('Martín Silva', 'msilva', 'pass456', true, 'martin@example.com'),
('Ana Morales', 'amorales', 'pass789', true, 'ana@example.com');

INSERT INTO noticias (titulo, idCategoria, idAutor, fecha, ubicacion) VALUES
('Análisis de la inflación acumulada', 3, 4, CURRENT_TIMESTAMP - INTERVAL '10 days', '/noticias/eco/inflacion.txt');

INSERT INTO comentarios (idNoticia, texto, idUsuario, fecha)
SELECT 5, 'Comentario sobre economía ' || s.i, 4, CURRENT_TIMESTAMP - (s.i || ' days')::INTERVAL
FROM generate_series(1, 20) AS s(i);

INSERT INTO comentarios (idNoticia, texto, idUsuario, fecha)
SELECT 5, 'Comentario breve ' || s.i, 5, CURRENT_TIMESTAMP - (s.i || ' days')::INTERVAL
FROM generate_series(1, 15) AS s(i);

INSERT INTO comentarios (idNoticia, texto, idUsuario, fecha)
SELECT 5, 'Comentario antiguo ' || s.i, 6, CURRENT_TIMESTAMP - INTERVAL '40 days' - (s.i || ' hours')::INTERVAL
FROM generate_series(1, 25) AS s(i);

-- =============================================================================
-- 4. PRODUCTOS COMPUESTOS, CLIENTES, PEDIDOS Y FACTURACIÓN (Ejercicios 6 y 9)
-- =============================================================================

INSERT INTO productos (codProducto, descripcion, stock, puntoReposicion, precio) VALUES
(1, 'Procesador Intel i7', 50, 10, 300.00),
(2, 'Placa Madre Z790', 40, 5, 200.00),
(3, 'Memoria RAM 32GB', 100, 20, 150.00),
(4, 'Placa de Video RTX 4070', 30, 5, 600.00),
(5, 'Fuente de Alimentación 850W', 60, 10, 120.00),
(10, 'Combo PC Gamer Ultra', 15, 3, 1000.00),
(20, 'Kit Upgrade CPU + RAM', 25, 5, 500.00);

INSERT INTO composiciones (codProducto, codProductoComponente, cantidad) VALUES
(10, 1, 1), (10, 2, 1), (10, 3, 1), (10, 4, 1),
(20, 1, 1), (20, 3, 1);

INSERT INTO clientes (codCliente, nombre, saldo) VALUES
(1, 'Tech Solutions S.A.', 1500.00),
(2, 'Comercial del Sur', 0.00);

INSERT INTO pedidos (nroPedido, fecha, codCliente, fechaEntrega, lugarEntrega) VALUES
(1, '2026-02-10', 1, '2026-02-15', 'Av. Corrientes 1234'),
(2, '2026-02-12', 2, '2026-02-16', 'Calle Belgrano 567');

INSERT INTO facturas (nroFactura, fecha, codCliente, codPedido, bruto, iva, iibb, final) VALUES
(101, '2026-02-10', 1, 1, 2500.00, 525.00, 75.00, 3100.00),
(102, '2026-02-12', 2, 2, 1000.00, 210.00, 30.00, 1240.00);

INSERT INTO itemsFactura (codProducto, nroFactura, cantidad, precio, descuento) VALUES
(10, 101, 2, 1000.00, 0.00),
(20, 101, 1, 500.00, 0.00),
(10, 102, 1, 1000.00, 10.00);

INSERT INTO pedidos (nroPedido, fecha, codCliente, fechaEntrega, lugarEntrega) VALUES
(3, '2026-03-01', 1, '2026-03-05', 'Av. Corrientes 1234');

INSERT INTO itemsPedido (codProducto, nroPedido, cantidad) VALUES
(1, 3, 2),
(3, 3, 1);

-- =============================================================================
-- 5. NOTICIAS DUPLICADAS PARA PRUEBAS DE VALIDACIÓN (Ejercicio 7)
-- =============================================================================

INSERT INTO noticias (titulo, idCategoria, idAutor, fecha, ubicacion) VALUES
('Noticia Con Titulo Duplicado', 1, 1, '2026-03-01 10:00:00', '/noticias/dup1.txt'),
('Noticia Con Titulo Duplicado', 2, 2, '2026-03-02 11:00:00', '/noticias/dup2.txt');