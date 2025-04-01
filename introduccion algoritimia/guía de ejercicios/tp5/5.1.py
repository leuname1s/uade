mayores = 0
menores = 0
sumaMayores = 0
sumaMenores = 0
resp = int(input("Ingrese la edad(-1 para salir): "))
while resp != -1:
    if resp < 0 or resp > 100:
        print("Error, edad no válida")
    else:
        if resp >= 18:
            mayores += 1
            sumaMayores += resp
        else:
            menores += 1
            sumaMenores += resp
        resp = int(input("Ingrese la edad(-1 para salir): "))
        
        
print("La cantidad de mayores es: ", mayores)
print("La cantidad de menores es: ", menores)
print("El promedio de mayores es: ", sumaMayores / mayores)
print("El promedio de menores es: ", sumaMenores / menores)