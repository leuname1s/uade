import random

def repetido(lista,numero):
    resultado = 0
    for i in range(len(lista)):
        if lista[i] == numero:
            resultado = 1
    return resultado

def busqueda_binaria(lista,numero):
    p1 = 0
    p2 = len(lista)-1
    while p1 <= p2:
        medio = (p1+p2)//2
        if lista[medio] == numero:
            p2 = -2
        elif numero > lista[medio]:
            p1 = medio + 1
        else:
            p2 = medio - 1
    if p2 == -2:
        return medio
    else:
        return -2

def seleccion(lista):
    for j in range (len(lista)-1):
        for i in range (j+1,len(lista)):
            if lista[j] > lista[i]:
                aux = lista[i]
                lista[i] = lista[j]
                lista[j] = aux


COD,STK,PRECIO = [],[],[]

while len(COD) < 150:
    codigo = random.randint(1000,10000)
    resultado = repetido(COD,codigo)
    if resultado == 0:
        COD.append(codigo)

for i in range(150):
    stock = random.randint(0,50)
    STK.append(stock)
    pre = random.randint(1000,25000)
    PRECIO.append(pre)

print(COD)
print(STK)
# print(PRECIO)

valoracion = 0
for i in range(150):
    suma = STK[i] * PRECIO[i]
    valoracion = valoracion + suma
    
print("La valoración del stock es de ",valoracion," pesos")

REPOS = []

for i in range(150):
    if STK[i] == 0:
        REPOS.append(COD[i])

print(REPOS)

if len(REPOS) > 0:
    seleccion(REPOS)    
    print(REPOS)
    resultado = -2
    while resultado == -2:
        numero = int(input("ingrese un numero para buscarlo en la lista REPOS: "))
        if numero < 1000 or numero > 10000:
            print("ingrese un numero dentro de valores permitidos(1000 a 10000)")
        else:
            resultado = busqueda_binaria(REPOS,numero)
            if resultado == -2:
                print("no se encontro ese numero en la lista REPOS, por favor ingrese otro")

    print("el numero ",numero," se encuentra en la posicion ",resultado," de la lista REPOS")
else:
    print("la lista REPOS esta vacia")

