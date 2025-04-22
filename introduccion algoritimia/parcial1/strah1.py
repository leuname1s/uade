import random

for i in range(600):
    numero = random.randint(1,1000)
    copiaNumero = numero - 1
    suma = 0
    while copiaNumero > 0:
        if numero % copiaNumero == 0:
            suma = suma + copiaNumero
        copiaNumero = copiaNumero - 1
    if suma < numero:
        print(numero, end=" ")
    