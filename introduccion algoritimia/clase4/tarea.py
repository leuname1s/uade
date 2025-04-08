import random
cNiven = 0
c = 0
while c < 100:
    numero = random.randint(100,1000)
    sumaDigitos = 0
    numeroAux = numero
    while  numeroAux > 0:
        digito = numeroAux % 10
        sumaDigitos += digito
        numeroAux = numeroAux // 10
    if numero % sumaDigitos == 0:
        print(numero)
        cNiven += 1
    c += 1
    
print("aparecieron ", cNiven," numero de niven")