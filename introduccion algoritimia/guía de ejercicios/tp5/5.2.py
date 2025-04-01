totalAlumnos = 0
totalAprobados = 0
totalDesaprobados = 0
totalAplazados = 0

legajo = int(input("Ingrese el legajo del alumno (-1 para salir): "))
while legajo != -1:
    nota = int(input("Ingrese la nota del alumno: "))
    if nota < 0 or nota > 10:
        print("Error, nota no válida")
    else:
        totalAlumnos += 1
        if nota >= 4:
            print("Aprobado")
            totalAprobados += 1
        elif nota > 1:
            print("Desaprobado")
            totalDesaprobados += 1
        else:
            print("Aplazado")
            totalAplazados += 1
    legajo = int(input("Ingrese el legajo del alumno (-1 para salir): "))
print("La cantidad de alumnos aprobados es: ", totalAprobados)
print("La cantidad de alumnos desaprobados es: ", totalDesaprobados)
print("El porcentaje de alumnos aplazados es: ", (totalAplazados / totalAlumnos) * 100)