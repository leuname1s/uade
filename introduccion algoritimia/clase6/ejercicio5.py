import random

par = 0
sieteEspada = 0
cincoOro = 0

for i in range(80):
    valor = random.randint(1,12)
    palo = random.randint(1,4)
    if valor >= 4 and valor <= 8:
        print(valor, end=" ")
    if valor % 2 == 0:
        par += 1
    elif valor == 7 and palo == 3:
         sieteEspada += 1
    elif valor == 5 and palo == 1:
        cincoOro += 1
       
print("") 
print("Cantidad de numeros multiplos de 2: ", par)
print("cantidad de 7 de espadas: ", sieteEspada)
print("porcentaje de 5 de oro: ", cincoOro/80 * 100, "%")