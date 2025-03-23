# Solicitar al usuario la medida en metros
metros = int(input("Ingrese la medida en metros: "))

# Convertir a otras unidades (usando enteros)
centimetros = metros * 100
pulgadas = (centimetros * 100) / 254  # Multiplicamos por 100 y luego dividimos para mantener enteros
pies = pulgadas / 12
yardas = pies / 3

# Mostrar los resultados
print("Medida en centímetros:", centimetros, "cm")
print("Medida en pulgadas:", pulgadas, "in")
print("Medida en pies:", pies, "ft")
print("Medida en yardas:", yardas, "yd")
