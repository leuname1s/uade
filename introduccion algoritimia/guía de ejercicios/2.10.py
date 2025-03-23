# Solicitar al usuario el largo y el ancho de la parcela en metros
largo = int(input("Ingrese el largo de la parcela en metros: "))
ancho = int(input("Ingrese el ancho de la parcela en metros: "))

# Calcular el área de la parcela en metros cuadrados
area = largo * ancho

# Calcular el rinde, sabiendo que en 10 m² se obtienen 2 quintales
rinde = (area / 10) * 2

# Mostrar el resultado
print("El rinde estimado de la parcela es:", rinde, "quintales")
