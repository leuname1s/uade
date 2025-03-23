# Solicitar al usuario el período en segundos
segundos = int(input("Ingrese el período en segundos: "))

# Calcular los días, horas, minutos y segundos
dias = segundos // (24 * 3600)  # 1 día = 24 horas * 3600 segundos
segundos_restantes = segundos % (24 * 3600)

horas = segundos_restantes // 3600  # 1 hora = 3600 segundos
segundos_restantes %= 3600

minutos = segundos_restantes // 60  # 1 minuto = 60 segundos
segundos_finales = segundos_restantes % 60

# Mostrar el resultado usando coma
print(dias, "días,", horas, "horas,", minutos, "minutos,", segundos_finales, "segundos")
