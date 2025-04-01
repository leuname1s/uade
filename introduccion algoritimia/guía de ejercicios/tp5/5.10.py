cantEspectadores = int(input("Ingrese la cantidad de espectadores: "))
recaudado = 0
totalFunciones = 0
espectadoresConDescuento = 0
while cantEspectadores != 0:
    descuento = int(input("Ingrese si la funcion tiene descuento (1 = Sí, 2 = No): "))
    totalFunciones += cantEspectadores
    if descuento == 1:
        recaudado += cantEspectadores * 3500
        espectadoresConDescuento += cantEspectadores
    else:
        recaudado += cantEspectadores * 5000

    cantEspectadores = int(input("Ingrese la cantidad de espectadores: "))

print("El total recaudado es: $", recaudado)
print("La cantidad de espectadores con descuento es: ", espectadoresConDescuento)
print("El porcentaje de espectadores con descuento es: ", (espectadoresConDescuento / totalFunciones) * 100, "%")