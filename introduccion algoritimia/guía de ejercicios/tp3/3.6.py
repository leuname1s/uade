total_paginas = int(input("Ingrese el número de páginas del libro: "))

costo_base = 5000
costo_por_pagina = 32
if total_paginas > 300:
    costo_encuadernacion_tela = 1200
else:
    costo_encuadernacion_tela = 0

if total_paginas > 600:
    costo_encuadernacion_especial = 3360
else:
    costo_encuadernacion_especial = 0

costo_total = costo_base + (total_paginas * costo_por_pagina) + costo_encuadernacion_tela + costo_encuadernacion_especial

print("El costo total de la encuadernación es:", costo_total)