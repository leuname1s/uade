import random


def repetido(lista,numero):
    resultado = 0
    for i in range(len(lista)):
        if lista[i] == numero:
            resultado = 1
    return resultado


def galati(numero):
    numeroGalati = 2
    secuencia = 3
    resultado = 0
    while numeroGalati < numero:
        proximo = secuencia + 1
        numeroGalati = numeroGalati + secuencia
        secuencia = secuencia + 1
        if numero == numeroGalati:
            resultado = 1
    return resultado


cantidadValores = int(input("ingrese la cantidad de valores a cargar en la lista (20 - 30): "))

while cantidadValores < 20 or cantidadValores > 30:
    cantidadValores = int(input("Por favor ingrese una cantidad valida (20 - 30): "))

lista = []


while len(lista) < cantidadValores:
    numero = random.randint(100,3000)
    if galati(numero) == 1 and repetido(lista,numero) == 0:
        lista.append(numero)

# print(lista)
                
for j in range (len(lista)-1):
    for i in range (j+1,len(lista)):
        if lista[j] > lista[i]:
            aux = lista[i]
            lista[i] = lista[j]
            lista[j] = aux

# print(lista)

for i in range(len(lista)):
    print(lista[i],end="   ")
print("")
busqueda = int(input("Ingrese un valor para buscarlo en la lista (-1 para salir): "))





while busqueda != -1:

    p1 = 0
    p2 = len(lista) -1
    
    while p1<=p2:
        medio = (p2 + p1) // 2
        if lista[medio] == busqueda:
            p2 = -2
        elif lista[medio] < busqueda:
            p1 = medio + 1
        else: 
            p2 = medio - 1 
        
    if p2 == -2:
        print("se encontro el numero en la posicion ",medio)
        busqueda = -1
    else:
        print("no se encontro el numero en la lista")
        busqueda = int(input("Ingrese un valor para buscarlo en la lista (-1 para salir): "))
        
print("fin del programa")
    
