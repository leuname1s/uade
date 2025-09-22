def calcular_calidad(codigoProducto):
    if " " in codigoProducto:
        return "invalido"
    
    grupoA, grupoB, grupoC, grupoD = False,False,False,False
    if len(codigoProducto) > 6:
        for digito in codigoProducto:
            if not grupoA and digito.isupper():
                grupoA = True
            if not grupoB and digito.islower():
                grupoB = True
            if not grupoC and digito.isnumeric():
                grupoC = True
            if not grupoD and digito in {"-","_","#"}:
                grupoD = True

        cantidadGrupos = (grupoA,grupoB,grupoC,grupoD).count(True) # 1, 2 o 3 segun la cantidad de grupos que utiliza
        return cantidadGrupos 
    
    else:
        return 0 #inaceptable
    
def probar_codigo():
    codigo = input("ingrese el codigo de producto (sin espacios): ")
    calidad = calcular_calidad(codigo)
    if calidad == "invalido":
        print("ingreso un codigo espacios. INVALIDO")
    elif calidad == 0:
        print(f"el codigo {codigo} es de calidad INACEPTABLE")
    elif calidad == 1:
        print(f"el codigo {codigo} es de calidad BAJA")
    elif calidad == 2:
        print(f"el codigo {codigo} es de calidad MEDIA")
    elif calidad == 3:
        print(f"el codigo {codigo} es de calidad ALTA")

probar_codigo()