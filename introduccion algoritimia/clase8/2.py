import random

lista = []
for i in range(20):
    lista.append(random.randint(10,1000))
print(lista)
m = 0
for i in range(len(lista)):
    if i == 0: 
        m = 0
    elif lista[i] > lista[m]:
        m = i
print(m)