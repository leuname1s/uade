mayor = 0
posicionMayor = 0
suma = 0
for i in range(0,10):
    resp = int(input("Ingrese un número entero: "))
    suma += resp
    if resp > mayor:
        mayor = resp
        posicionMayor = i + 1
print("El mayor es: ", mayor)
print("La posicion del mayor es: ", posicionMayor)
print("El promedio es: ", suma / 10)
    