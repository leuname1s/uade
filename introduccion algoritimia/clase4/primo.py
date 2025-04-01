import random
primos = 0
multiplos = 0
c = 0
while c < 1000:
    numero = random.randint(25,5000)
    if numero%3 == 0 and numero%5 == 0:
        multiplos += 1
    
    n = numero - 1
    while n > 1:
        if numero % n == 0:
            n = 0
        else:
            n -= 1
    if n != 0:
        primos += 1
        print(numero, end=", ")
    c += 1
print()    
print("multiplos de 3 y de 5 al mismo tiempo: ",multiplos)
print("total numeros primos: ",primos)