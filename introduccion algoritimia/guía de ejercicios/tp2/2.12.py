# Solicitar al usuario la cantidad de dinero
dinero = int(input("Ingrese la cantidad de dinero: "))

# Calcular cuántos billetes de cada denominación se necesitan
billetes_1000 = dinero // 1000
dinero = dinero % 1000

billetes_500 = dinero // 500
dinero = dinero % 500

billetes_100 = dinero // 100
dinero = dinero % 100

billetes_50 = dinero // 50
dinero = dinero % 50

billetes_10 = dinero // 10
dinero = dinero % 10

billetes_5 = dinero // 5
dinero = dinero % 5

billetes_1 = dinero // 1
dinero = dinero % 1

print(billetes_1000, "billetes de $1000")
print(billetes_500, "billetes de $500")
print(billetes_100, "billetes de $100")
print(billetes_50, "billetes de $50")
print(billetes_10, "billetes de $10")
print(billetes_5, "billetes de $5")
print(billetes_1, "billetes de $1")
