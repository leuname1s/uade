import random

def repetido(n,l):
    for i in l:
        if i == n:
            return True
    return False

def sumaDivisores(n):
    s = 0
    for i in range(1,n//2+1):
        if n % i == 0:
            s += i
    return s

l = []
n = int(input("ingrese el tamaño de la lsita"))
while n > 30 or n < 15:
    n = int(input("ingrese el tamaño de la lsita"))
    
while len(l) < n:
    rn = random.randint(200,800)
    if sumaDivisores(rn) < rn and not repetido(rn,l):
        l.append(rn)
        
        
for i in range(1,len(l)):
    if l[i] < l[i-1]:
        for j in range(i,0,-1):
            if l[j] < l[j-1]:
                l[j],l[j-1] = l[j-1],l[j]
                # print(l)
print(l)

busqueda = int(input("ingrese un numero para buscar"))
while busqueda > 800 or busqueda < 200:
    busqueda = int(input("ingrese un numero para buscar"))


p1 = 0
p2 = len(l) -1

while p1<p2:
    medio = (p2 + p1) // 2
    if l[medio] == busqueda:
        p2 = -1
    elif l[medio] < busqueda:
        p1 = medio + 1
    else: 
        p2 = medio - 1 

if p2 == -1:
    print(medio)
else:
    # print(l[medio])
    print(medio)
    print(len(l))
    
    if busqueda > l[-1]:
        l.append(busqueda)
    else:
        aux = 0
        for i in range(len(l)):
            if aux == 0:
                if l[i] > busqueda:
                    aux = l[i]
                    l[i] = busqueda
            else:
                l[i],aux = aux,l[i]
        l.append(aux)

print(l)
                