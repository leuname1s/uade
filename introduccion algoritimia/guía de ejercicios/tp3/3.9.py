numeroDia = int(input("Ingrese el número del día de la semana (1-31): "))
numeroMes = int(input("Ingrese el número del mes (1-12): "))
numeroAño = int(input("Ingrese el número del año: "))

if numeroDia > 31 or numeroDia < 1:
    print("Número de día inválido") 
elif numeroMes > 12 or numeroMes < 1:
    print("Número de mes inválido")
elif numeroAño < 0:
    print("Número de año inválido")