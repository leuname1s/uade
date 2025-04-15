resp = 0
s = 0
resp = int(input("ingrese una opcion: 1 - perro / 2 - gato / 3 - conejo / -1 - salir: "))
cantPerro = 0
cantPerrosHembra = 0
cantPerroMacho = 0
cantGatos = 0
cantConejosHembra = 0

while resp != -1:
    if resp == 1:
        cantPerro += 1
        s = int(input("ingrese el sexo del perro: 1 - macho / 2 - hembra: "))
        if s == 1:
            cantPerroMacho += 1
        elif s == 2:
            cantPerrosHembra += 1
        else:
            print("Error, el sexo no es valido")
    elif resp == 2:
        cantGatos += 1
        input("ingrese el sexo del gato: 1 - macho / 2 - hembra: ")
    elif resp == 3:
        s = int(input("ingrese el sexo del conejo: 1 - macho / 2 - hembra: "))
        if s == 2:
            cantConejosHembra += 1
    else:
        print("Error, la opcion no es valida")
    resp = int(input("ingrese una opcion: 1 - perro / 2 - gato / 3 - conejo / -1 - salir: "))
        
print("la cantidad de perros machos es: ", cantPerroMacho)
if cantPerro > 0:
    print("el porcentaje de perros hembra es: ", (cantPerrosHembra/cantPerro)*100, "%")
print("la cantidad de gatos es: ", cantGatos)
print("la cantidad de conejos hembra es: ", cantConejosHembra)
