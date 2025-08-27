
def analizador_parrafo():
    p = str(input("ingrese un parrafo: "))
    palabras = dict()
    vocales = {"a":0,
            "e":0,
            "i":0,
            "o":0,
            "u":0}

    p = p.replace(".","").replace(",","")
    p_letras = p.split(" ")
    for i in p_letras:
        if i in palabras.keys():
            palabras[i] += 1
        else:
            palabras[i] = 1

    for i in p:
        if i in ["a","A","á","Á"]:
            vocales["a"] += 1
        elif i in ["e","E","é","É"]:
            vocales["e"] += 1
        elif i in ["o","O","ó","Ó"]:
            vocales["o"] += 1
        elif i in ["i","I","í","Í"]:
            vocales["i"] += 1
        elif i in ["u","U","ú","Ú"]:
            vocales["e"] += 1
            
            
    print("Cantidad de palabras distintas:", len(palabras))

    mas_frecuente = max(palabras, key=palabras.get)
    print("Palabra más frecuente:", mas_frecuente, "->", palabras[mas_frecuente], "veces")

    total_vocales = sum(vocales.values())
    for v, cant in vocales.items():
        if total_vocales > 0:
            porcentaje = (cant / total_vocales) * 100
        else:
            porcentaje = 0
        print(f"Vocal '{v}': {porcentaje:.2f}%")


def encriptador():
    texto = input("Ingrese un texto para encriptar: ").lower()
    resultado = ""
    for c in texto:
        if "a" <= c <= "z":
            if c == "z":
                resultado += "a"
            else:
                resultado += chr(ord(c) + 1)
        else:
            resultado += c
    print("Texto encriptado:", resultado)
    print()
    
    

def validador_contrasena():
    pwd = input("Ingrese una contraseña: ")
    tiene_may = False
    tiene_min = False
    tiene_num = False
    tiene_sim = False

    for c in pwd:
        if "A" <= c <= "Z":
            tiene_may = True
        elif "a" <= c <= "z":
            tiene_min = True
        elif "0" <= c <= "9":
            tiene_num = True
        else:
            tiene_sim = True

    if len(pwd) >= 8 and tiene_may and tiene_min and tiene_num and tiene_sim:
        print("Contraseña válida")
    else:
        print("Contraseña inválida")
    print()
    


def comparador_frases():
    f1 = input("Ingrese la primera frase: ").lower().split()
    f2 = input("Ingrese la segunda frase: ").lower().split()

    comunes = []
    for p in f1:
        if p in f2 and p not in comunes:
            comunes.append(p)
    print("Palabras en común:", len(comunes), comunes)

    if len(f1) > len(f2):
        print("La primera frase es más larga")
    elif len(f2) > len(f1):
        print("La segunda frase es más larga")
    else:
        print("Ambas frases tienen la misma longitud")
    print()


def notas_alumnos():
    alumnos = []
    while True:
        nombre = input("Nombre del alumno (fin para terminar): ")
        if nombre == "fin":
            break
        notas = []
        for i in range(3):
            nota = float(input(f"Nota {i+1}: "))
            notas.append(nota)
        alumnos.append([nombre, notas])

    promedios = []
    for a in alumnos:
        prom = sum(a[1]) / len(a[1])
        promedios.append([a[0], prom])

    # mejor promedio
    mejor = promedios[0]
    for p in promedios:
        if p[1] > mejor[1]:
            mejor = p
    print("Alumno con mejor promedio:", mejor[0], mejor[1])

    # listado ordenado descendente
    for i in range(len(promedios)):
        for j in range(i+1, len(promedios)):
            if promedios[j][1] > promedios[i][1]:
                promedios[i], promedios[j] = promedios[j], promedios[i]

    print("Listado por promedio:")
    for p in promedios:
        print(p[0], "->", p[1])
    print()
    

def inventario():
    inventario = []
    while True:
        opcion = input("1-Agregar 2-Eliminar 3-Buscar 4-Mostrar 5-Salir: ")
        if opcion == "1":
            prod = input("Producto a agregar: ")
            inventario.append(prod)
        elif opcion == "2":
            prod = input("Producto a eliminar: ")
            if prod in inventario:
                inventario.remove(prod)
        elif opcion == "3":
            prod = input("Producto a buscar: ")
            if prod in inventario:
                print("Producto encontrado")
            else:
                print("No está en inventario")
        elif opcion == "4":
            print("Inventario:", inventario)
        elif opcion == "5":
            break
    print()


def numeros_unicos():
    import random
    numeros = []
    for _ in range(30):
        numeros.append(random.randint(1, 20))

    unicos = []
    for n in numeros:
        if numeros.count(n) == 1:
            unicos.append(n)
    print("Números generados:", numeros)
    print("Números únicos:", unicos)
    print()
    
    

def frecuencia_palabras():
    texto = input("Ingrese un texto: ").lower().split()
    palabras = []
    cantidades = []
    for p in texto:
        if p not in palabras:
            palabras.append(p)
            cantidades.append(1)
        else:
            i = palabras.index(p)
            cantidades[i] += 1

    for i in range(len(palabras)):
        print(palabras[i], "->", cantidades[i])
    print()


def coordenadas():
    puntos = []
    while True:
        x = input("Ingrese coordenada x (fin para terminar): ")
        if x == "fin":
            break
        y = input("Ingrese coordenada y: ")
        puntos.append([int(x), int(y)])

    for p in puntos:
        distancia = (p[0]**2 + p[1]**2) ** 0.5
        print(f"Punto {p} distancia al origen: {distancia:.2f}")
    print()