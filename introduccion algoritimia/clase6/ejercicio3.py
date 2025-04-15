resp = 0
notaParcial1 = 0
notaParcial2 = 0

cantPromocionados = 0
cantRecuperatorio = 0
cantFinal = 0
cantAlumnos = 0
resp = int(input("ingrese su numero de libreta(1000000 y 2000000) (-1 para salir): "))
while resp != -1:
    if resp >= 1000000 and resp <= 2000000:
        cantAlumnos += 1
        notaParcial1 = int(input("ingrese la nota del primer parcial: "))
        notaParcial2 = int(input("ingrese la nota del segundo parcial: "))
        if notaParcial1 < 0 or notaParcial1 > 10 or notaParcial2 < 0 or notaParcial2 > 10:
            print("Error, las notas deben estar entre 0 y 10")
        else:
            if notaParcial1 > 7 and notaParcial2 > 7:
                cantPromocionados += 1
            elif notaParcial1 >= 4 and notaParcial2 >= 4:
                cantFinal += 1
            elif notaParcial1 < 4 or notaParcial2 < 4:
                cantRecuperatorio += 1
    else:
        print("Error, el numero de libreta no es valido")
    resp = int(input("ingrese su numero de libreta(1000000 y 2000000): "))

        
print("Cantidad de alumnos promocionados(más de ocho en ambos parciales): ", cantPromocionados)
print("Cantidad de alumnos que deben rendir al menos un recuperatorio: ", cantRecuperatorio)
print("porcentaje de alumnos que rinden final: ", (cantFinal/cantAlumnos)*100, "%")
                