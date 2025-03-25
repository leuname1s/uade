#se ingrasa la cantidad de materia prima necesaria para hacer chocotortas
# todas las cantidadaes se ingresan en kilos
#sabiendo que cada chocotorta necesita: 400gr de galletitas, 250gr de dulce de leche y 150 gr de queso crema
#informar cuantas chocotortas se pueden hacer con la cantidad ingresada

galletitas=int(input("Ingrese la cantidad de galletitas en kilos: "))
dulce_de_leche=int(input("Ingrese la cantidad de dulce de leche en kilos: "))
queso_crema=int(input("Ingrese la cantidad de queso crema en kilos: "))

galletitas=galletitas*1000
dulce_de_leche =dulce_de_leche*1000
queso_crema=queso_crema*1000

chocotortas_galletitas= galletitas // 400
chocotortas_dulce_de_leche =dulce_de_leche // 250
chocotortas_queso_crema=queso_crema // 150


if chocotortas_galletitas<=chocotortas_dulce_de_leche and chocotortas_galletitas<=chocotortas_queso_crema:
    print("Se pueden hacer",chocotortas_galletitas,"chocotortas")
else:
    if chocotortas_dulce_de_leche<=chocotortas_galletitas and chocotortas_dulce_de_leche<=chocotortas_queso_crema:
        print("Se pueden hacer",chocotortas_dulce_de_leche,"chocotortas")
    else:
        if chocotortas_queso_crema <=chocotortas_galletitas and chocotortas_queso_crema<= chocotortas_dulce_de_leche:
            print("Se pueden hacer",chocotortas_queso_crema,"chocotortas")