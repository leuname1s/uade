factorial = int(input("ingrese un numero entero: "))
if factorial < 0:
    print("no existe el factorial de un numero negativo")
else:
    if factorial == 0:
        print("el factorial de 0 es 1")
    else:
        resultado = 1
        for i in range(1, factorial + 1):
            resultado *= i
        print("el factorial de ", factorial, "es: ", resultado)