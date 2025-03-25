#ingresar 3 valores sinedo ellos la longitud de los lados de un triangulo
#informar si los lados forman un triangulo y en caso afirmativo informar que tipo de triangulo es
#equilatero, isosceles o escaleno

lado1 = int(input("Ingrese el lado 1: "))
lado2 = int(input("Ingrese el lado 2: "))
lado3 = int(input("Ingrese el lado 3: "))

if lado1 + lado2 > lado3 and lado1 + lado3 > lado2 and lado2 + lado3 > lado1:
    print("Los lados forman un triangulo")
    if lado1 == lado2 and lado2 == lado3:
        print("El triangulo es equilatero")
    else:
        if lado1 == lado2 or lado2 == lado3 or lado1 == lado3:
            print("El triangulo es isosceles")
        else:
            if lado1 != lado2 and lado2 != lado3 and lado1 != lado3:
                print("El triangulo es escaleno")   
else:
    print("Los lados no forman un triangulo")
    