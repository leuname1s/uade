nota1 = int(input("Ingrese la primera nota: "))
nota2 = int(input("Ingrese la segunda nota: "))

if nota1 < 0 or nota2 < 0:
    print("Error: Las notas no pueden ser negativas.")
elif nota1 > 10 or nota2 > 10:
    print("Error: Las notas no pueden ser mayores a 10.")
else:
    if nota1 >= 7 and nota2 >= 7:
        print("Promocionado")
    elif nota1 >= 4 and nota2 >= 4:
        print("aprobado")
    else:
        print("Se debe recuperar")
