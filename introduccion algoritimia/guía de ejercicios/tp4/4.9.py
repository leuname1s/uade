par = 0
impar = 0
resp = int(input("Ingrese un número entre el 1 y el 9 (-1 para salir): "))
while resp != -1:
    if resp != -1:
        if resp % 2 == 0:
            par += 1
        else:
            impar += 1
    resp = int(input("Ingrese un número entre el 1 y el 9  (-1 para salir): "))
print("La cantidad de números pares es: ", par)
print("La cantidad de números impares es: ", impar)