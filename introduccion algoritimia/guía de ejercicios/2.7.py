# Solicitar al usuario el monto invertido
capital_invertido = int(input("Ingrese el capital invertido: "))

# Calcular la ganancia en un mes (2% mensual)
ganancia_mensual = capital_invertido * 0.02

# Calcular la ganancia total después de 6 meses
ganancia_seis_meses = ganancia_mensual * 6

# Mostrar los resultados
print("Ganancia en un mes:", ganancia_mensual)
print("Ganancia en seis meses:", ganancia_seis_meses)
