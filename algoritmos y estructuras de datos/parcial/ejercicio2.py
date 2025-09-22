import random

def elegir_locker():
    numeros = ["1","2","3","4","5","6","7","10","11","12"]
    sectores = ["norte","sur","este","oeste"]
    lockers = []
    for numero in numeros:
        for sector in sectores:
            lockers.append(f"{numero} {sector}")

    # print(lockers)

    matriz = []
    for filas in range(2):
        fila = []
        for columnas in range(3):
            locker = lockers.pop(random.randint(0,len(lockers)))
            fila.append(locker)
        matriz.append(fila)

    return matriz

def mostrar_lockers(matriz):
    contadorPersona = 0
    for fila in matriz: #no me acuerdo si se puede usar enumerate() por las dudas use un contador
        contadorPersona += 1
        print(f"--- lockers de la persona numero {contadorPersona}: ")
        contadorLocker = 0
        for locker in fila: #lo mismo, no se si se puede usar enumerate
            contadorLocker += 1
            print(f"locker {contadorLocker}: {locker}")

matriz = elegir_locker()
mostrar_lockers(matriz)
