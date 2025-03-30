votosFavor = int(input("Ingrese la cantidad de votos a favor: "))
votosContra = int(input("Ingrese la cantidad de votos en contra: "))

totalVotos = votosFavor + votosContra
porcentajeFavor = (votosFavor / totalVotos) * 100
porcentajeContra = (votosContra / totalVotos) * 100
print("Porcentaje de votos a favor:", porcentajeFavor, "%")
print("Porcentaje de votos en contra:", porcentajeContra, "%")
if porcentajeFavor > 50:
    print("El proyecto fue aprobado")
else:
    print("El proyecto fue rechazado")
    