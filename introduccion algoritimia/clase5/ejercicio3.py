import random

mayor = 0
pMayor = 0
menor = 0
pMenor = 0

for i in range(50):
    numero = random.randint(1000,10000)
    if i == 0 or numero > mayor:
        mayor = numero
        pMayor = i
    if i == 0 or numero < menor:
        menor = numero
        pMenor = i
        
print("el numero menor: ", menor, " aparecio en la posicion ", pMenor+1)
        
print("el numero mayor: ", mayor, " aparecio en la posicion ", pMayor+1)