import random

lista = []
t = 0
for i in range(20):
    n = random.randint(10,1000)
    lista.append(n)
    t = t + n
print(lista)
p = t // 20
m = 0
for i in range(len(lista)):
    if lista[i] > p: 
        m = m + 1
print(m)