import random
# Una empresa de venta de repuestos de heladeras, dispone de 3
# listas de 150 posiciones cada una, COD para el código del
# producto, STK para saber el stock de ese repuesto y
# PRECIO para el valor de cada unidad.
# Las 3 listas son numéricas
# Para cerrar el balance a fin de año, necesita valorizar el stock
# de los repuestos. Esto es, saber cuanto dinero se tiene
# inmovilizado, por lo que se debe multiplicar la cantidad de
# cada repuesto por lo que cuesta cada uno, obteniendo el total
# de dinero inmovilizado
# Para lograr ello, necesita hacer el siguiente proceso:
# - Cargar los 3 listas. La primera de ellas es un código numérico
# entre 1000 y 10000.
# Se aclara que la carga de los número de los códigos no son
# ni correlativos ni repetidos.
# La segunda, es un número entre 0 y 50, y la tercera es un
# importe entre $ 10 y $ 250.
# - Efectuar la valoración de lo que hay en stock, informando el total calculado
# - Luego de este proceso, se deberá cargar la lista REPOS ( de 20
# posiciones), en donde se cargarán los códigos de los artículos
# cuyo stock este en cero (0).
# Las posiciones que no se utilicen deben quedar en cero.
# Mostrar las 3 listas obtenidas
# posiciones que no se utilicen deben quedar en cero
l1 = []
l2 = []
l3 = []
repo = []
for i in range(150):
    l2.append(random.randint(0,50))
    l3.append(random.randint(10,250))
while len(l1) < 150:
    n1 = random.randint(1000,10000)
    if n1 not in l1:
        l1.append(n1)
v = 0
for i in range(150):
    if l2[i] > 0:
        v += (l2[i] * l3[i])
    else:
        repo.append(l1[i])
print(v)

if len(repo) > 20:
    repo = repo[:19]
else:
    while len(repo) < 20:
        repo.append(0)
        

print(repo)
