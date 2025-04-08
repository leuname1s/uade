suma = 0
a = 0
b = 1
for i in range(1,20):
    suma = a + b
    a = b
    b = suma
    if i > 5 and i % 2 != 0:
        print(suma)