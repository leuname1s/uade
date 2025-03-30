sueldo_basico = float(input("Ingrese el sueldo básico: "))
antiguedad = int(input("Ingrese la antigüedad en años: "))
estado_civil = int(input("Ingrese el estado civil (1 para soltero, 2 para casado): "))

if estado_civil == 1:
    incremento_porcentaje = 0.05
else:
    incremento_porcentaje = 0.07

sueldo_bruto = sueldo_basico + (sueldo_basico  * (antiguedad * incremento_porcentaje))

descuento_jubilacion = sueldo_bruto * 0.11
descuento_obra_social = sueldo_bruto * 0.03
descuento_sindicato = sueldo_bruto * 0.03

sueldo_neto = sueldo_bruto - (descuento_jubilacion + descuento_obra_social + descuento_sindicato)

print("Sueldo bruto: $",sueldo_bruto)
