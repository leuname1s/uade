import random

valorMaximo = 0
pValorMaximo = 0
cantidadCero = 0
cantidadSegunda = 0
totalTiradas = 150

for i in range(totalTiradas):
    numero = random.randint(0, 36)
    print(numero, end=" ")
    if i == 0 or numero > valorMaximo:
        valorMaximo = numero
        pValorMaximo = i + 1
    if numero == 0:
        cantidadCero += 1
    elif numero >= 13:
        cantidadSegunda += 1


print()
print("el valor máximo fue", valorMaximo, "en la tirada", pValorMaximo)
print("el porcentaje de ceros fue", cantidadCero/totalTiradas * 100, "%")
print("la cantidad de tiradas en la segunda docena fue", cantidadSegunda)
