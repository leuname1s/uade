numero = int(input("Ingrese un numero: "))
cantDigitos = 0
sumaDigitos = 0
while numero != 0:
    cantDigitos += 1
    digito = numero % 10
    sumaDigitos += digito
    numero = numero // 10
    
print("el promedio de los digitos del numero es: ", sumaDigitos/cantDigitos)