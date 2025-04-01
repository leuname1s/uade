import random
c = 0
cAplazos = 0
CAprobados = 0
cPromocionado = 0
while c <= 50:
    nota = random.randint(1, 10)
    if nota >= 8:
        cPromocionado += 1
    elif nota >=4:
        CAprobados += 1
    else:
        cAplazos += 1
    c += 1
        
print("La cantidad de alumnos aprobados es: ", CAprobados)
print("La cantidad de alumnos aplazados es: ", cAplazos)
print("La cantidad de alumnos promocionados es: ", cPromocionado)
print("El porcentaje de alumnos aplazados es: ", (cAplazos / 50) * 100)
print("El porcentaje de alumnos aprobados es: ", (CAprobados / 50) * 100)
print("El porcentaje de alumnos promocionados es: ", (cPromocionado / 50) * 100)
    