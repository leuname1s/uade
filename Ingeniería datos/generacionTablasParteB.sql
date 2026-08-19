-- 1. Tabla: Clientes (Entidad maestra)
CREATE TABLE Clientes (
    codCliente INT GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(150) NOT NULL,
    saldo NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    CONSTRAINT pk_clientes PRIMARY KEY (codCliente)
);

-- 2. Tabla: Productos (Entidad maestra)
CREATE TABLE Productos (
    codProducto INT GENERATED ALWAYS AS IDENTITY,
    descripcion VARCHAR(255) NOT NULL,
    stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
    puntoReposicion INT NOT NULL DEFAULT 0 CHECK (puntoReposicion >= 0),
    precio NUMERIC(12, 2) NOT NULL CHECK (precio >= 0),
    CONSTRAINT pk_productos PRIMARY KEY (codProducto)
);

-- 3. Tabla: Pedidos (Depende de Clientes)
CREATE TABLE Pedidos (
    nroPedido INT GENERATED ALWAYS AS IDENTITY,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    codCliente INT NOT NULL,
    fechaEntrega DATE,
    lugarEntrega VARCHAR(255),
    CONSTRAINT pk_pedidos PRIMARY KEY (nroPedido),
    CONSTRAINT fk_pedidos_clientes FOREIGN KEY (codCliente) 
        REFERENCES Clientes (codCliente) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
);

-- 4. Tabla: Facturas (Depende de Clientes y opcionalmente de Pedidos)
CREATE TABLE Facturas (
    nroFactura INT GENERATED ALWAYS AS IDENTITY,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    codCliente INT NOT NULL,
    codPedido INT,
    bruto NUMERIC(12, 2) NOT NULL DEFAULT 0.00 CHECK (bruto >= 0),
    iva NUMERIC(12, 2) NOT NULL DEFAULT 0.00 CHECK (iva >= 0),
    IIBB NUMERIC(12, 2) NOT NULL DEFAULT 0.00 CHECK (IIBB >= 0),
    final NUMERIC(12, 2) NOT NULL DEFAULT 0.00 CHECK (final >= 0),
    CONSTRAINT pk_facturas PRIMARY KEY (nroFactura),
    CONSTRAINT fk_facturas_clientes FOREIGN KEY (codCliente) 
        REFERENCES Clientes (codCliente) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT,
    CONSTRAINT fk_facturas_pedidos FOREIGN KEY (codPedido) 
        REFERENCES Pedidos (nroPedido) 
        ON UPDATE CASCADE 
        ON DELETE SET NULL
);

-- 5. Tabla: ItemsPedido (Detalle de Pedido - Clave compuesta)
CREATE TABLE ItemsPedido (
    codPedido INT NOT NULL,
    codProducto INT NOT NULL,
    cantidad NUMERIC(10, 2) NOT NULL CHECK (cantidad > 0),
    CONSTRAINT pk_itemspedido PRIMARY KEY (codPedido, codProducto),
    CONSTRAINT fk_itemspedido_pedidos FOREIGN KEY (codPedido) 
        REFERENCES Pedidos (nroPedido) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
    CONSTRAINT fk_itemspedido_productos FOREIGN KEY (codProducto) 
        REFERENCES Productos (codProducto) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
);

-- 6. Tabla: ItemsFactura (Detalle de Factura - Clave compuesta)
CREATE TABLE ItemsFactura (
    nroFactura INT NOT NULL,
    codProducto INT NOT NULL,
    cantidad NUMERIC(10, 2) NOT NULL CHECK (cantidad > 0),
    precio NUMERIC(12, 2) NOT NULL CHECK (precio >= 0),
    descuento NUMERIC(5, 2) NOT NULL DEFAULT 0.00 CHECK (descuento BETWEEN 0 AND 100),
    CONSTRAINT pk_itemsfactura PRIMARY KEY (nroFactura, codProducto),
    CONSTRAINT fk_itemsfactura_facturas FOREIGN KEY (nroFactura) 
        REFERENCES Facturas (nroFactura) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
    CONSTRAINT fk_itemsfactura_productos FOREIGN KEY (codProducto) 
        REFERENCES Productos (codProducto) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
);

-- 7. Tabla: Composiciones (Estructura de producto / Lista de materiales)
CREATE TABLE Composiciones (
    codProducto INT NOT NULL,
    codProductoComponente INT NOT NULL,
    cantidad NUMERIC(10, 2) NOT NULL CHECK (cantidad > 0),
    CONSTRAINT pk_composiciones PRIMARY KEY (codProducto, codProductoComponente),
    CONSTRAINT fk_composiciones_producto_padre FOREIGN KEY (codProducto) 
        REFERENCES Productos (codProducto) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
    CONSTRAINT fk_composiciones_producto_componente FOREIGN KEY (codProductoComponente) 
        REFERENCES Productos (codProducto) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT,
    CONSTRAINT chk_composiciones_no_autoreferencia CHECK (codProducto <> codProductoComponente)
);