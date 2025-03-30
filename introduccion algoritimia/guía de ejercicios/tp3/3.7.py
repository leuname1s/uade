cantidadKilometros = int(input("Ingrese la cantidad de kilómetros recorridos: "))

if cantidadKilometros < 10:
    precio = cantidadKilometros * 400
elif cantidadKilometros >= 10:
    precio = cantidadKilometros * 200
    
if precio < 2700:
    precio = 2700
    
print("El precio del viaje es:", precio)