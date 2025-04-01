numero = int(input("Ingrese un número entero: "))
if numero < 0: numero *= -1
c = 10
cantidadCifras = 0
while numero != 0:
    cantidadCifras += 1
    numero = numero // 10
print("La cantidad de cifras es: ", cantidadCifras)