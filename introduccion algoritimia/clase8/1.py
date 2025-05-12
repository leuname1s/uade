import random

lista = []
for i in range(20):
    lista.append(random.randint(10,1000))
print(lista)
for i in lista:
    if i % 2 == 0:
        print(i)