numero = int(input("ingrese un numero natural"))
for i in range(2, numero - 1):
    if numero % i == 0:
        print("no es primo")
        break
    else:
        print("es primo")
        