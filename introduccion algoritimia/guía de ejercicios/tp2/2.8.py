metros = int(input("Ingrese la medida en metros: "))

centimetros = metros*100
pulgadas = (centimetros * 100) / 254  
pies = pulgadas /12
yardas = pies /3

print("Medida en centímetros:", centimetros, "cm")
print("Medida en pulgadas:",pulgadas, "in")
print("Medida en pies:",pies, "ft")
print("Medida en yardas:",yardas, "yd")
