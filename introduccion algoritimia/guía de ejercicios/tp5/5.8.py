cantEmpleados = int(input("Ingrese la cantidad de empleados: "))
totalSalarios = 0 
empleadosDocientos = 0
empleadosCincuenta = 0
legajoMayor = 0
sueldoMayor = 0
sueldoMenor = 0
totalCat1 = 0
totalCat2 = 0
totalCat3 = 0

for i in range(cantEmpleados):
    legajo = int(input("Ingrese el legajo del empleado: "))
    categoria = int(input("Ingrese la categoria del empleado (1, 2 o 3): "))
    sueldo = int(input("Ingrese el sueldo del empleado: "))

    if categoria == 1:
        totalCat1 += sueldo
    elif categoria == 2:
        totalCat2 += sueldo
    elif categoria == 3:
        if sueldo < 50000:
            empleadosCincuenta += 1
        totalCat3 += sueldo

    if i == 0 or sueldo < sueldoMenor:
        sueldoMenor = sueldo
    if i == 0 or sueldo > sueldoMayor:
        legajoMayor = legajo
        sueldoMayor = sueldo

    if sueldo > 200000:
        empleadosDocientos += 1

    totalSalarios += sueldo
    
print("importe total de sueldos: ", totalSalarios)
print("cantidad de empleados con sueldo mayor a 200000: ", empleadosDocientos)
print("cantidad de empleados con sueldo menor a 50000 de categoria 3: ", empleadosCincuenta)
print("legajo del empleado con mayor sueldo: ", legajoMayor)
print("sueldo menor: ", sueldoMenor)
print("total de sueldos categoria 1: ", totalCat1)
print("total de sueldos categoria 2: ", totalCat2)
print("total de sueldos categoria 3: ", totalCat3)
print("salario promedio: ", totalSalarios / cantEmpleados)