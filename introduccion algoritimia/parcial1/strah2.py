numero = int(input("ingrese un numero menor a 100(ingrese -1 para salir): "))
contadorPrimos = 0
while numero != -1:
    if numero < 100:
        copiaNumero = numero - 1
        while copiaNumero > 1:
            if numero % copiaNumero == 0:
                copiaNumero = -1
            else:
                copiaNumero = copiaNumero - 1
        if copiaNumero == 1:
            print("El numero ",numero," es primo")
            contadorPrimos = contadorPrimos + 1
        else:
            print("el numero no es primo")
    else:
        print("El numeor tiene que ser menor a 100")
        
    numero = int(input("ingrese un numero menor a 100(ingrese -1 para salir): "))
print("El numero total de primos que ingreso fueron: ",contadorPrimos)
    
    