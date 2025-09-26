import random

def ejer1():
    frutas = ["manzana", "pera", "manzana", "uva", "pera", "kiwi"]
    frutas_unicas = set(frutas)
    print(frutas_unicas)
    print(len(frutas_unicas))
    
def ejer2():
    animales = {"perro", "gato", "pez"}
    if "tortuga" in animales:
        print("tortuga esta en animales")
    else:
        print("tortuga no esta en animales")
        
def ejer3():
    colores = {"azul", "blanco"}
    colores.add("negro")
    colores.add("azul")
    colores.remove("blanco") # da error si no esta
    colores.discard("magenta") # NO da error si no esta

def ejer4():
    valores = {3, 8, 2, 13, 5}
    print(len(valores))
    print(min(valores))
    print(max(valores))
    print(sum(valores))

def ejer5():
    A = {0,1,2,3,5,8,13}
    B = {2,4,6,8,10}
    print(A.union(B))
    print(A.intersection(B))
    print(A.difference(B))
    print(A.symmetric_difference(B))
    
def ejer6():
    ingresantes = {"Oliver","Gabriela"}
    empleados = {"Irina","Gabriela","Oliver","Giuliana"}
    print(ingresantes.issubset(empleados))
    
def ejer7():
    numeros = [1,2,2,3,4,4,5]
    cuadrados = {x**2 for x in numeros}
    print(cuadrados)    
    
def ejer8():
    productos = ["Camiseta","Pantalones","Zapatos","Camiseta","Bufanda"]
    productos_unicos = list(set(productos))
    print(productos_unicos)
    
def ejer9():
    texto = "hola mundo"
    texto = set(texto)
    # cambia porque los conjunto NO son ordenados
    
def ejer10():
    coordenada = (-34.72904, -58.26374)
    persona = ("Oliver", "Pérez")
    print(len(coordenada))
    print(len(persona))
    if "Pérez" in persona:
        print("Pérez esta en persona")

def ejer11():
    numeros = (1,1,1,3,5)
    print(numeros.count(1))
    print(numeros.index(5))

def ejer12():
    fecha = (2017, 8, 7)
    año, mes, dia = fecha
    print(año)
    print(mes)
    print(dia)
    mes, dia = 8, 7
    # la asignaicon multiple es cuando se asignan una variable a cada valor dentro de una tupla
    
def ejer13():
    t = (1,2,3)
    t = list(t)
    t.append(4)
    t = tuple(t)

def ejer14():
    print((1,2,3) < (1,2,4)) #se hace la suma
    print((3,5) == (33/11, 2+3)) #al hacer las operaciones quedan los mismos valores
    print((1,2) < (1,2,4)) #se hace la suma
    
def ejer15():
    personas = [("manu", "413242314", "argentino"),
                ("bruno", "432424343", "argentino"),
                ("fede", "432424343", "brasilero")
    ]
    for nombre,dni,nacionalidad in personas:
        print(f"{nombre} -- {dni} ({nacionalidad})")
            
def ejer16():
    registros = [("Ana","30111222"), ("Luis","30111222"), ("Ana","30111222"), ("Sofía","29123123"), ("Luis","30111222")]
    registros = set(registros)
    print(len(registros))
    for i in registros:
        print(i)

def ejer17():
    curso_A = {"Agus","Nico","Luz","Vero"}
    curso_B = {"Luz","Vero","Mati","Santi"}
    print(curso_A.union(curso_B))
    print(curso_A.intersection(curso_B))
    print(curso_A)
    print(curso_B)
    

# ejer1()
# ejer2()    
# ejer3()
# ejer4()
# ejer5()
# ejer6()
# ejer7()
# ejer8()
# ejer9()
# ejer10()
# ejer11()
# ejer12()
# ejer13()
# ejer14()
# ejer15()
# ejer16()
# ejer17()




