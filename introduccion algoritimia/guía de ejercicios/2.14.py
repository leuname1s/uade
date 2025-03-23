# Solicitar al usuario el número de documento o libreta
documento = int(input("Ingrese su número de documento o libreta: "))

# Obtener y mostrar cada dígito desde el último hasta el primero
digito1 = documento // 10000000
documento = documento % 10000000

digito2 = documento // 1000000
documento = documento % 1000000

digito3 = documento // 100000
documento = documento % 100000

digito4 = documento // 10000
documento = documento % 10000

digito5 = documento // 1000
documento = documento % 1000

digito6 = documento // 100
documento = documento % 100

digito7 = documento // 10
documento = documento % 10

digito8 = documento

# Mostrar los dígitos
print(digito8, digito7, digito6, digito5, digito4, digito3, digito2, digito1)
