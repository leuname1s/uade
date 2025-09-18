def ejercicio1():
    estudiantes = {
        "Pedro":{
            "edad": 18,
            "materias": ["matematica","fisica","lengua"]
        },
        "Miguel":{
            "edad": 32,
            "materias": ["matematica","fisica"]
        },
        "Agus":{
            "edad": 23,
            "materias": ["lengua"]
        }
    }

    def agregar_estudiante(estudiantes):
        nombre = input("ingrese el nombre del estudainte: ")
        edad = input("ingrese la edad del estudainte: ")
        materias = input("""ingrese las materias del estudainte (separadas por ","): """).split(",")
        
        estudiantes[nombre] = {"edad": edad, "materias":materias}
        print("estudiante agregado")
        
    def modificar_edad(estudiantes):
        nombre = input("ingrese el nombre del estudainte a modificar: ")
        edad = input("ingrese la nueva edad del estudainte: ")
        estudiantes[nombre]["edad"] = edad
        print("modificado con exito")

    def mostrar_materias(estudiantes):
        nombre = input("ingrese el nombre del estudainte: ")
        print(f"materias del estudiante: {estudiantes[nombre]["materias"]}")
        
        
    print(estudiantes)
    agregar_estudiante(estudiantes)
    modificar_edad(estudiantes)
    mostrar_materias(estudiantes)
    print(estudiantes)

def ejercicio2():
    tupla = ("Madrid","Buenos Aires","Rosario","Roma","New York")
    print(len(tupla))
    if "Buenos Aires" in tupla:
        print("Buenos Aires esta en la tupla")
    ciudad1,ciudad2,ciudad3,ciudad4,ciudad5 = tupla
    print(ciudad1)
    print(ciudad2)
    print(ciudad3)
    print(ciudad4)
    print(ciudad5)

def ejercicio3():
    texto = "Margarita Carmen Cansino (Nueva York, 17 de octubre de 1918-Manhattan, 14 de mayo de 1987), más conocida por su seudónimo Rita Hayworth,fue una actriz, bailarina y pin-up estadounidense. Alcanzó la fama en la década de 1940 como una de las principales estrellas de la Edad de Oro de Hollywood y apareció en 61 películas en total a lo largo de 38 años. La prensa acuñó el término «La diosa del amor» para describir a Hayworth, luego de que se convirtiera en el ícono cinematográfico más glamuroso de la época. Fue la principal chica pin-up de los soldados durante la Segunda Guerra Mundial y ocupa el puesto 19.º en la lista del American Film Institute de las grandes estrellas del séptimo arte."
    texto = texto.lower().replace("("," ").replace(")"," ").replace(","," ").replace("."," ").split(" ")
    # print(texto)
    diccionario = dict()
    for palabra in texto:
        if palabra in diccionario:
            diccionario[palabra] += 1
        else:
            diccionario[palabra] = 1
            
    print(diccionario)
        


# ejercicio1()
# ejercicio2()
ejercicio3()