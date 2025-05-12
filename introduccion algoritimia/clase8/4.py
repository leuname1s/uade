import random

listaA = []
listaB = []
for i in range(10):
    listaA.append(random.randint(10,50))
    listaB.append(random.randint(10,50))
listaC = []
for i in range(len(listaA)):
    listaC.append(listaA[i] + listaB[i])
print(listaA)
print(listaB)
print(listaC)