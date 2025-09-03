import random

# ---- punto 1 ----
def punto1():
    def lista_comprension():
        return [random.randint(1000,9999) for _ in range(random.randint(10,99))]

    def lista_habitual():
        lista = []
        for _ in range(random.randint(10,99)):
            lista.append(random.randint(1000,9999))
        return lista

    def sumatoria(lista):
        return sum(lista)

    def eliminar_valor(lista, valor):
        print(lista)
        return [x for x in lista if x != valor]

    def es_capicua(lista):
        print(lista)
        return lista == lista[::-1]

    l1 = lista_comprension()
    l2 = lista_habitual()
    print(sumatoria(l1))
    print(eliminar_valor(l1, int(input("Valor a eliminar: "))))
    print(es_capicua([50,17,91,17,50]))
    print(es_capicua([1,2,3,4,5,6,7]))

# ---- punto 2 ----

def punto2():

    def lista_aleatoria():
        return [random.randint(1,100) for _ in range(50)]

    def tiene_repetidos(lista):
        temp = []
        for i in lista:
            if i not in temp:
                temp.append(i)
            else:
                return True
        return False

    def elementos_unicos(lista):
        nueva = []
        for x in lista:
            if x not in nueva:
                nueva.append(x)
        return nueva


    l = lista_aleatoria()
    print(l)
    print(tiene_repetidos(l))
    print(elementos_unicos(l))

# ---- punto 3 ----

def punto3():
    N = int(input("Ingrese N: "))
    lista = [x**2 for x in range(1, N+1)]
    print(lista[-10:])


# ---- punto 4 ----

def punto4():
    lista1 = ["perro","gato","casa","auto","flor","gato"]
    lista2 = ["gato","flor"]
    print(lista1)
    print(lista2)
    lista1 = [x for x in lista1 if x not in lista2]
    print(lista1)

# ---- punto 5 ----

def punto5():
    def ordenada(lista):
        lista_ordenada = lista.copy()
        lista_ordenada.sort()
        # print(lista_ordenada)
        # print(lista)
        if lista == lista_ordenada:
            return True
        elif lista == lista_ordenada[::-1]:
            return False
            
    l1 = [1,2,3]
    print(ordenada(l1))
    print(ordenada(['b','a']))
    print(ordenada(['b','a',"z"]))
    
# ---- punto 6 ----
    
def punto6():
    lista1 = [8,1,3]
    lista2 = [5,9,7]
    c = 1
    for i in lista2:
        lista1[c:c] = [i]
        c += 2

    print(lista1)
    
# ---- punto 7 ----
    
def punto7():
    lista = [x for x in range(101,200,2)]
    print(lista)

# ---- punto 8 ----
    
def punto8():
    A = int(input("Ingrese A: "))
    B = int(input("Ingrese B: "))
    lista = [x for x in range(A,B+1) if x%7==0 and x%5!=0]
    print(lista)
    
# ---- punto 9 ----
    
def punto9(): 
    lista = [random.randint(1,100) for _ in range(50)]
    impares = [x for x in lista if x%2!=0]
    print(lista)
    print(impares)   

# ---- punto 10 ----
    
def punto10(): 
    urgencia = []
    turno = []

    while True:
        socio = int(input("Número de afiliado (-1 para terminar): "))
        if socio == -1:
            break
        tipo = int(input("0: urgencia, 1: turno: "))
        if tipo == 0:
            urgencia.append(socio)
        else:
            turno.append(socio)

    print("Pacientes por urgencia:", urgencia)
    print("Pacientes por turno:", turno)

    buscar = int(input("Número de afiliado a buscar: "))
    print("Atendido por urgencia:", urgencia.count(buscar))
    print("Atendido por turno:", turno.count(buscar))
    


# punto1()
# punto2()
# punto3()
# punto4()
# punto5()
# punto6()
# punto7()
# punto8()
# punto9()
punto10()