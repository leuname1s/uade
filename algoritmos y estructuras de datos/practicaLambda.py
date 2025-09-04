import random
from functools import reduce

# ---- punto 1 ----

def punto1():
    superficie = lambda largo, ancho: largo * ancho
    aprobado = lambda nota: nota >= 4
    cambiar_signo = lambda x: x * -1
    nombre_largo = lambda nombre: len(nombre) > 10
    positivo_o_cero = lambda x: x >= 0
    multiplicar = lambda a,b: a*b
    mayor_que = lambda a,b: a > b

    # Ejemplos de uso
    print(superficie(5,3))
    print(aprobado(5))
    print(cambiar_signo(-7))
    print(nombre_largo("Manuel Alejandro"))
    print(positivo_o_cero(-1))
    print(multiplicar(4,5))
    print(mayor_que(10,7))
  

# ---- punto 2 ----

def punto2():
    lista = [1,2,3,4,5,6,7,8,9,10]
    separar = lambda lst: (list(filter(lambda x: x%2==0, lst)), list(filter(lambda x: x%2!=0, lst)))
    pares, impares = separar(lista)
    print("Pares:", pares)
    print("Impares:", impares)

    
# ---- punto 3 ----

def punto3():
    lista = [1,2,3,4,5,6,7,8,9,10]
    contar_pares = lambda lst: len(list(filter(lambda x: x%2==0, lst)))
    contar_impares = lambda lst: len(list(filter(lambda x: x%2!=0, lst)))

    print("Pares:", contar_pares(lista))
    print("Impares:", contar_impares(lista))

# ---- punto 4 ----

def punto4():
    lista = [1,2,3,4,5,6,7,8,9,10,12,15,20,21]
    div3 = list(filter(lambda x: x%3==0, lista))
    print(div3)
    
# ---- punto 5 ----

def punto5():
    notas = [int(input("Nota: ")) for _ in range(10)]
    estados = list(map(lambda nota: nota >= 4, notas))
    print(notas)
    print(estados)
    
# ---- punto 6 ----

def punto6():
    aprobado = lambda nota: nota >= 4
    notas = [int(input("Nota: ")) for _ in range(10)]
    aprobadas = list(filter(aprobado, notas))
    desaprobadas = list(filter(lambda x: not aprobado(x), notas))
    print("Aprobadas:", aprobadas)
    print("Desaprobadas:", desaprobadas)

# ---- punto 7 ----

def punto7():
    lista = [1,2,4,5,10,20]
    inversos = list(map(lambda x: 1/x, lista))
    print(inversos)

# ---- punto 8 ----

def punto8():
    lista = [1,2,3,4,5]
    doble = list(map(lambda x: x*2, lista))
    print(doble)
    
# ---- punto 9 ----

def punto9():
    def filtraMayores(lista):
        return list(filter(lambda x: x > 5, lista))
    print(filtraMayores([1,3,6,8,2,10]))

# ---- punto 10 ----

def punto10():
    def dobleSiEsPar(lista):
        return list(map(lambda x: x*2, filter(lambda x: x%2==0, lista)))
    print(dobleSiEsPar([1,2,3,4,5,6,7,8]))

# ---- punto 11 ----

def punto11():
    def ordenaPalabras(lista):
        return list(map(lambda x: x, sorted(lista, reverse=True)))
    print(ordenaPalabras(["perro","gato","casa","auto","flor"]))

# ---- punto 12 ----

def punto12():
    def masCorto(lista):
        return reduce(lambda a,b: a if len(a)<len(b) else b, lista)
    print(masCorto(["perro","gato","auto","flor","a"]))

# ---- punto 13 ----

def punto13():
    def productoPares(lista):
        pares = list(filter(lambda x: x%2==0, lista))
        return reduce(lambda a,b: a*b, pares) if pares else 0
    print(productoPares([1,2,3,4,5,6]))

# punto1()
# punto2()
# punto3()
# punto4()
# punto5()
# punto6()
# punto7()
# punto8()
# punto9()
# punto10()
# punto11()
# punto12()
punto13()

