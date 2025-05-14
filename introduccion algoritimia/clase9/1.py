import random

def pares(lista):
    c = 0
    for i in lista:
        if i % 2 == 0:
            c += 1
    return c

l = []
for i in range(20):
     l.append(random.randint(10,200))
     
print(pares(l))