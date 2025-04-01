import random
c = 0
cPar = 0
cMultiplosSiete = 0
while c < 100:
    n = random.randint(1, 100)
    if n % 2 == 0:
        cPar += 1
    if n % 7 == 0:
        cMultiplosSiete += 1
    c += 1
    print(n)
print("La cantidad de números pares es: ", cPar)
print("La cantidad de números múltiplos de 7 es: ", cMultiplosSiete)