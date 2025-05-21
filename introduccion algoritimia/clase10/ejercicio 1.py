
import random
# Generar valores entre 100 y 10000
# Completar una lista con 20 valores, sin repetir, de 3 dígitos
# capicuas (606,111, 323, etc)
# Determinar si un nro es capicúa la hace una función
# Y si está repetido, otra función
# Informar en que posición está el mayor valor
def uno():
    def repetido(lista,numero):
        for i in lista:
            if i == numero:
                return True
        return False
    def capicua(numero):
        numero = str(numero)
        fpointer = 0
        spointer = -1
        while fpointer < len(numero)-1:
            if numero[fpointer] ==  numero[spointer]:
                fpointer += 1
                spointer -= 1
            else:
                return False
        return True
    l = []
    pm = 0
    i = 0
    while len(l) < 20:
        n = random.randint(100,1000)
        if not repetido(l,n) and capicua(n):
            i += 1
            l.append(n)
            if i == 0 or l[pm] < n:
                pm = i
    print(l)
    print(pm + 1)

# Generar una lista con N números enteros al azar entre 1 y 100, donde N se
# ingresa desde el teclado. 
# Luego se solicita al usuario ingresar un número por teclado para buscarlo
# en la lista.
# Indicar mediante mensajes aclaratorios si lo encuentra o no, y cuantas veces
# esta ya que se puede encontrar más de una vez.
# Se termina la búsqueda de números cuando el usuario ingresa -1.
# Al finalizar, mostrar la lista entera por pantalla.
def dos():
    l = []
    n = int(input("ingrese cuantos numeros quiere su lista"))
    for i in range(n):
        l.append(random.randint(1,100))
    r = int(input("ingrese un numero: "))
    while r != -1:
        c = l.count(r)
        if c:
            print(f"el numero aparece {c} veces")
        else:
            print("ese numero no esta en la lista")
        r = int(input("ingrese un numero: "))
    print(l)

# Generar una lista de 20 valores aleatorios comprendidos entre 5 y 850.
# Los valores que se carguen a la lista deberán ser deficientes o perfectos y
# no pueden estar repetidos.
# La detección sobre si el valor es deficiente o perfecto deberá resolverlo
# una función
# Mostrar la lista obtenida con los valores separados por 3 espacios
# Mostar la lista obtenida
# Número Deficiente: Número que es mayor a la suma de sus divisores, sin considerar el propio número
# Número Perfecto: Número que es igual a la suma de sus divisores, sin considerar el propio número

def tres():
    def sumaDivisores(n):
        s = 0
        for i in range(1,n):
            if n % i == 0:
                s += i
        return s
    def deficiente(n):
        if n > sumaDivisores(n):
            return True
        return False
    def perfecto(n):
        if n == sumaDivisores(n):
            return True
        return False
    
    l = []
    while len(l) < 20:
        n = random.randint(5,850)
        if (deficiente(n) or perfecto(n)) and n not in l:
            l.append(n)
            print(n,end="   ")
    print(l)

# uno()
# dos()
tres()