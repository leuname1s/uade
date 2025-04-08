
# Generar la sucesión de Fibonacci hasta la posición 30
# Por fin de proceso informar:
# En el rango indicado, y a partir de la posición 3, informar cuántos nros son valores primos
# Infomar además, cuantos de ellos tienen raíz cuadrada exacta

a = 1
b = 1

for i in range(30):
    c = a + b
    a = b
    b = c
    if i > 0:
        cont = 0
        while cont*cont < c:
            cont += 1
            if cont*cont == c:
                print(f"El número {c} tiene raíz cuadrada exacta")
                break
        cont = 2
        while cont < c:
            if c % cont != 0:
                cont += 1
            else:
                cont = c +1
        if cont == c:
            print(f"El número {c} es primo")
