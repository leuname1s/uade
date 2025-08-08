def galati(numero):
    numeroGalati = 2
    secuencia = 3
    resultado = 0
    while numeroGalati < numero:
        proximo = secuencia + 1
        numeroGalati = numeroGalati + secuencia
        secuencia = secuencia + 1
        print(numeroGalati)
        if numero == numeroGalati:
            resultado = 1
    return resultado


print(galati(109))
