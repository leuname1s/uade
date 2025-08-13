
# EJERCICIO 1
print("\nEjercicio 1:")
A = int(input("Ingrese el número A: "))
B = int(input("Ingrese el número B: "))
if A > B:
    print("El mayor es:",A)
else:
    print("El mayor es:", B)
    

# EJERCICIO 2
print("\nEjercicio 2:")
C = float(input("Ingrese el número C: "))
D = float(input("Ingrese el número D: "))
E = float(input("Ingrese el número E: "))
if A < B:
    if A < C:
        print("El menor es:",A)
    else:
        print("El menor es:",C)
else:
    if B < C:
        print("El menor es:",B)
    else:
        print("El menor es:",C)
        


# EJERCICIO 3

def seleccion(l):
    for j in range (len(l)-1):
        for i in range (j+1,len(l)):
            if l[j] > l[i]:
                aux = l[i]
                l[i] = l[j]
                l[j] = aux

print("\nEjercicio 3:")
X = int(input("Ingrese el número X: "))
Y = int(input("Ingrese el número Y: "))
Z = int(input("Ingrese el número Z: "))
print("Orden ascendente:", seleccion([X, Y, Z]))

# EJERCICIO 4

def natural(n):
    if n > 0:
        return True
    else:
        print("ingrese un numero natural")
        return False
    
    
print("\nEjercicio 4:")
N = int(input("Ingrese el número N: "))
if natural(N):
    print("Números naturales hasta N:")
    for i in range(1, N + 1):
        print(i, end=" ")
    print()

# EJERCICIO 5
print("\nEjercicio 5:")
H = int(input("Ingrese el número H: "))
if natural(H):
    print("Primeros H números pares:")
    count = 0
    num = 0
    while count < H:
        if num % 2 == 0:
            print(num, end=" ")
            count += 1
        num += 1
    print()

# EJERCICIO 6
print("\nEjercicio 6:")
P = int(input("Ingrese el número P: "))
Q = int(input("Ingrese el número Q: "))
if natural(P) and natural(Q):
    print(f"Múltiplos de {P} menores a {Q}:")
    for i in range(P, Q, P):
        print(i, end=" ")
    print()

# EJERCICIO 7
print("\nEjercicio 7:")
G = int(input("Ingrese el número G: "))
if natural(G):
    print("Sumatoria de los números hasta G:", sum(range(1, G + 1)))

# EJERCICIO 8
print("\nEjercicio 8:")
total = 0
for i in range(1, 21):
    valor = float(input(f"Ingrese el valor {i}: "))
    total += valor
print("Promedio de los 20 valores:", total / 20)

# EJERCICIO 9
print("\nEjercicio 9:")
N = int(input("Ingrese la cantidad de números: "))
total = 0
for i in range(N):
    valor = float(input(f"Ingrese el valor {i+1}: "))
    total += valor
print("Promedio de los valores:", total / N)

# EJERCICIO 10
print("\nEjercicio 10:")
H = int(input("Ingrese la cantidad de números: "))
if natural(H):
    positivos = negativos = ceros = 0
    for i in range(H):
        num = int(input(f"Ingrese el número {i+1}: "))
        if num > 0:
            positivos += 1
        elif num < 0:
            negativos += 1
        else:
            ceros += 1
    print("Positivos:", positivos)
    print("Negativos:", negativos)
    print("Ceros:", ceros)

# EJERCICIO 11
def sumatoria(l):
    s = 0
    for i in range(0,len(l)):
        s += l[i]
    return s
        
print("\nEjercicio 11:")
T = int(input("Ingrese el número T: "))
if natural(T):
    pares_sumatoria = sumatoria([i for i in range(2, T + 1, 2)])
    print("Sumatoria de pares hasta T:", pares_sumatoria)

# EJERCICIO 12
print("\nEjercicio 12:")
N = int(input("Ingrese la cantidad de ventas: "))
totalVenta = 0
for i in range(N):
    venta = float(input(f"Ingrese el monto de la venta {i+1}: "))
    if i == 0:
        ventaMayor = venta
        ventaMenor = venta
    else:
        if venta < ventaMenor:
            ventaMenor = venta
        elif venta > ventaMayor:
            ventaMayor = venta
    totalVenta += venta
    
print("la venta mayor fue de ",ventaMayor)
print("la venta menor fue de ",ventaMenor)
print("el promedio de ventas fue de", totalVenta / N)


# EJERCICIO 13
print("\nEjercicio 13:")
lista_cargada = [1, 5, 3, 7, 3, 3, 9, 2]
buscado = int(input("Ingrese el número a buscar: "))
ocurrencias = 0
for i in range(len(lista_cargada)):
    if lista_cargada[i] == buscado:
        ocurrencias += 1

print(f"El número {buscado} aparece {ocurrencias} veces.")

# EJERCICIO 14
print("\nEjercicio 14:")
lista_precargada = [10, 20, 30, 40, 50]
print("Lista original:", lista_precargada)
lista_precargada[0], lista_precargada[-1] = lista_precargada[-1], lista_precargada[0]
print("Lista modificada:", lista_precargada)

# EJERCICIO 15
print("\nEjercicio 15:")
lista1 = ["Hola", "nombre", "Juan"]
lista2 = ["mi", "es", "Perez"]
if len(lista1) == len(lista2):
    combinada = []
    for i in range(len(lista1)):
        combinada.append(lista1[i])
        combinada.append(lista2[i])
    print("Lista combinada:", combinada)
else:
    print("Las listas tienen diferente longitud, no se puede combinar.")

# EJERCICIO 16
print("\nEjercicio 15:")
lista1 = ["Hola", "nombre", "Juan","y me gusta el chocolate"]
lista2 = ["mi", "es", "Perez"]
combinada = []
if len(lista1) > len(lista2):
    for i in range(len(lista2)):
        combinada.append(lista1[i])
        combinada.append(lista2[i])
    for i in range(len(lista2),len(lista1)):
        combinada.append(lista1[i])
else:
    for i in range(len(lista1)):
        combinada.append(lista1[i])
        combinada.append(lista2[i])
    for i in range(len(lista1),len(lista2)):
        combinada.append(lista2[i])

print("Lista combinada:", combinada)