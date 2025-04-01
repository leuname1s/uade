resp = int(input("Ingrese un número entero  (-1 para salir): "))
mayor = resp
menor = resp
while resp != -1:
    if resp > mayor:
        mayor = resp
    if resp < menor:
        menor = resp
    resp = int(input("Ingrese un número entero  (-1 para salir): "))
print("El mayor es: ", mayor)
print("El menor es: ", menor)