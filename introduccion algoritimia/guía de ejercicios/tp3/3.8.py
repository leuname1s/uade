numeroAño = int(input("Ingrese un año: "))
if numeroAño % 4 == 0 and (numeroAño % 100 != 0 or numeroAño % 400 == 0):
    print("El año es bisiesto")
else:
    print("El año no es bisiesto")