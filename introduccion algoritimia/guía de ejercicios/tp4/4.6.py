tabla = int(input("Ingrese el número de la tabla de multiplicar: "))
for i in range(1, 14):
    resultado = tabla * i
    print(f"{tabla} x {i} = {resultado}")