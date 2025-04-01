cantidadVentas = 0
cantidadDesceunto = 0
cantidadSinDescuento = 0

cantidad = int(input("Ingrese la cantidad de productos: "))
while cantidad != -1:
    precio = int(input("Ingrese el precio del producto: "))
    cantidadVentas += 1
    if cantidad > 12 and cantidad < 100:
        cantidadDesceunto += 1
        precioTotal = 12 * precio + (0.9* precio) * (cantidad - 12) 
    elif cantidad < 12:
        cantidadSinDescuento += 1
        precioTotal = cantidad * precio
    else:
        precioTotal = 12 * precio + (0.9* precio) * 88 + (0.75* precio) * (cantidad - 100) 
    print("El precio total es: ", precioTotal)
    print("El promedio del precio por articulo es:" , precioTotal / cantidad)
    cantidad = int(input("Ingrese la cantidad de productos: "))
    
print("La cantidad de ventas es: ", cantidadVentas)
print("La cantidad de ventas con descuento es: ", cantidadDesceunto)
print("La cantidad de ventas sin descuento es: ", cantidadSinDescuento)
    