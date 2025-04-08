import random

mayor = 0
pMayor = 0
for i in range(50):
    numero = random.randint(1000,10000)
    if i == 0 or numero > mayor:
        mayor = numero
        pMayor = i
        
print("el numero mayor: ", numero, " aparecio en la posicion ", i+1)