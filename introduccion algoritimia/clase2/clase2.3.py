nota1 = int(input("Ingrese la nota del primer parcial: "))
nota2 = int(input("Ingrese la nota del segundo parcial: "))

#calcular promedio
promedio = (nota1 + nota2)/2
if promedio < 4:
    print("recursar")
else:
    if promedio >= 8:
        print("Promocionado")
    else:
        print("Rinde final")