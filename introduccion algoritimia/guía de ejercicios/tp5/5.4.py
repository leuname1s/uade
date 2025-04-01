numeroCliente = int(input("Ingrese el número de cliente: "))
TotalFactura = int(input("Ingrese el total de la factura: "))

descuento = 2/100 * TotalFactura
if descuento > 200:
    descuento = TotalFactura - descuento
else:
    descuento = TotalFactura - 200
multa = 10/100 * TotalFactura
if multa > 350:
    multa = TotalFactura + multa
else:
    multa = TotalFactura + 350

print("El número de cliente es: ", numeroCliente)
print("El total de la factura es: ", TotalFactura)
print("Si paga en los primeros 10 dias su factura es de: ",descuento)
print("Si paga en los primeros 20 días su factura es de: ", TotalFactura)
print("Si paga luego de los primeros 20 días su factura es de: ", multa)

