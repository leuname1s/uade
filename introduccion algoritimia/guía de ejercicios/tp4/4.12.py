suma = 0
numero = int(input("ingrese un numero natural: "))
a = 0
b = 1
sumacion = 1
print(a)
print(b)
for i in range(0, numero):
    suma = a + b
    a = b
    b = suma
    sumacion += suma
    print(suma)
print("La suma de los numeros es: ", sumacion)