# Solicitar datos al usuario
numero_vendedor = int(input("Ingrese el número del vendedor: "))
cantidad_ventas = int(input("Ingrese la cantidad de ventas realizadas: "))
valor_total_ventas = int(input("Ingrese el valor total de las ventas: "))

# Definir salario base y comisiones
salario_base = 250000
comision_por_venta = 50000 * cantidad_ventas
comision_por_valor = int(valor_total_ventas * 0.05)

# Calcular el salario total
salario_total = salario_base + comision_por_venta + comision_por_valor

# Mostrar el resultado
print("Número del vendedor:", numero_vendedor)
print("Salario correspondiente:", salario_total)
