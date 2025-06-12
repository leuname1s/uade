def burbuja(l):
    for i in range(len(l)-1):
        for j in range(len(l)-1):
            if l[j] > l[j+1]:
                aux = l[j]
                l[j] = l[j+1]
                l[j+1] = aux

                
def seleccion(l):
    for j in range (len(l)-1):
        for i in range (j+1,len(l)):
            if l[j] > l[i]:
                aux = l[i]
                l[i] = l[j]
                l[j] = aux


def insercion(l):
    for i in range(1,len(l)):
        if l[i] < l[i-1]:
            for j in range(i,0,-1):
                if l[j] < l[j-1]:
                    aux = l[j]
                    l[j] = l[j-1]
                    l[j-1] = aux

lista = [4,3,4,6,7,8,9,2,3]

# burbuja(lista)
# seleccion(lista)
insercion(lista)
print(lista)


def busqueda_binaria(l,t):
    p1 = 0
    p2 = len(l) -1
    
    while p1<p2:
        medio = (p2 + p1) // 2
        if l[medio] == t:
            p2 = -1
        elif l[medio] < t:
            p1 = medio + 1
        else: 
            p2 = medio - 1 
            
    return medio


print(busqueda_binaria(lista,7))