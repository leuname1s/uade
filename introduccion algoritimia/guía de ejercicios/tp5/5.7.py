numero = int(input("Ingrese un número entero: "))

if numero < 0:  
    negativo = True 
    numero = numero * -1  
else:
    negativo = False
invertido = 0

while numero > 0:
    digito = numero % 10  
    invertido = invertido * 10 + digito  
    numero //= 10  
    
if negativo: 
    print(invertido * -1)
else:
    print(invertido)

