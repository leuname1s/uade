n = int(input("ingrese un numero N: "))

suma = 0
a = 0
b = 1
print("0")
print("1")
for i in range(2,n):
    suma = a + b
    a = b
    b = suma
    if i > 3 and i < 7:
        y = i
        fact = 1
        while y > 0:
            fact *= y
            y -= 1
        print(i," su factorial es: ", fact)
    else:
        print(suma)
    
    