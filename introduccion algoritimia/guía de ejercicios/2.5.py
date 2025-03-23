# Solicitar al usuario el precio del medicamento
precio = float(input("Ingrese el precio del medicamento: "))

# Calcular el descuento (35%)
descuento = precio * 0.35

# Calcular el importe final a pagar
importe_final = precio - descuento

# Mostrar los resultados
print("Precio original:", precio)
print("Monto del descuento:", descuento)
print("Importe final a pagar:", importe_final)
