import csv  #libreria para archivos .csv

preguntasRespuestas = dict()    #un diccionario para tener en memoria

with open("preguntas.csv","r", newline="",encoding='utf-8') as csvfile:
    csvReader = csv.reader(csvfile)
    next(csvReader) #saltear la primera fila que es el encabezado
    for row in csvReader:
        preguntasRespuestas[row[0]] = row[1]    #se registran las preguntas y respuestas del archivo "preguntas.csv" en el diccionario
        
        
r = input("""-> Ingrese una pregunta (ingrese "salir" para salir): """)

while r != "salir":     #bucle principal
    if r in preguntasRespuestas: #si la pregunta esta registrada
        print("-> ",preguntasRespuestas[r])
    else:   #si la pregunta NO esta registrada
        r2 = input("-> No conozco esa pregunta ¿queres ingresar una respuesta a esa pregunta?: ")
        if r2 in {"si","Si","sí","Sí","s","y"}: #si se quiere ingresar una respuesta para la pregunta no resgitrada
            
            respuestaPregunta = input("-> ¿Cual sería la respuesta esperada para esa pregunta?: ")
            with open("preguntas.csv","a", newline="",encoding='utf-8') as csvfile: #registra la respuesta a la pregunta
                csvWriter = csv.writer(csvfile)
                csvWriter.writerow([r,respuestaPregunta])
            preguntasRespuestas[r] = respuestaPregunta
            print("-> respuesta registrada, ¡gracias!")
    
    r = input("""-> Ingrese una pregunta (ingrese "salir" para salir): """) #repite el bucle

print("-> ¡Chau!")
    