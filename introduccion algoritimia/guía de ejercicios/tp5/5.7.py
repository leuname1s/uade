numero = int(input("Ingrese un número entero: "))

if numero < 0:  
    negativo = True 
    numero = numero * -1  
else:
    negativo = False
invertido = 0

while numero > 0:
    digito = numero % 10  # Obtener el último dígito
    invertido = invertido * 10 + digito  # Construir el número invertido
    numero //= 10  # Eliminar el último dígito

if negativo: 
    print(invertido * -1)
else:
    print(invertido)

