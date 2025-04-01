paridad = True
resp = int(input("Ingrese un número entero  (-1 para salir): "))
while resp != -1:
    paridad = not paridad
    resp = int(input("Ingrese un número entero  (-1 para salir): "))
    
if paridad:
    print("la cantidad de numeros ingresados es: par")
else:
    print("la cantidad de numeros ingresados es: impar")
    