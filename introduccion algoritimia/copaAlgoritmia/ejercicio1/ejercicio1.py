import csv

with open("preguntas.csv", encoding="utf-8") as csvfile:
    spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
    for row in spamreader:
        print(', '.join(row))

respuesta = input("""ingrese una pregunta (ingrese "salir" para salir): """)


while respuesta != "salir":
    pass