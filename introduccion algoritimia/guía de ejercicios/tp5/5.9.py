
n = int(input("Ingrese un número entero: "))
suma = 0
while n < 0:
    print("El número ingresado es negativo, vuelva a intentarlo")
    n = int(input("Ingrese un número entero: "))


for i in range(1, n+1, 2):
    print(i)
    suma += i
print("La suma es: ",suma)

