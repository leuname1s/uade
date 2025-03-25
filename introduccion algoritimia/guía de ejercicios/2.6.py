aporte1 = int(input("Ingrese el aporte de la primera persona: "))
aporte2 = int(input("Ingrese el aporte de la segunda persona: "))
aporte3 = int(input("Ingrese el aporte de la tercera persona: "))
total = aporte1 + aporte2 + aporte3
porcentaje1 = (aporte1 / total)*100
porcentaje2 = (aporte2 / total)*100
porcentaje3 =(aporte3 / total)*100
print("Porcentaje de inversión de la primera persona:", porcentaje1, "%")
print("Porcentaje de inversión de la segunda persona:", porcentaje2, "%")
print("Porcentaje de inversión de la tercera persona:", porcentaje3, "%")
