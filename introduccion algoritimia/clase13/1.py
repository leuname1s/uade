l1 = []
numero = int(input("ingrese un numero"))
while numero != -1:
    l1.append(numero)
    numero = int(input("ingrese un numero"))

l2 = []
for i in range(len(l1)):
    n = l1[i]
    while n != 1:
        if n % 2 == 0:
            n = n//2
        else:
            n = (n*3)+1
    l2.append(n)

print(l2)
print(len(l2))

# ordenar lista por insercoin

print(l1)

for i in range(1,len(l1)):
    if l1[i] < l1[i-1]:
        for j in range(i,0,-1):
            if l1[j] < l1[j-1]:
                l1[j],l1[j-1] = l1[j-1],l1[j]
                # print(l1)
print(l1)

# busqueda binaria

p1 = 0
p2 = len(l1) -1

target = int(input("ingrese un numero"))

while p1<p2:
    medio = (p2 + p1) // 2
    if l1[medio] == target:
        p2 = -1
    elif l1[medio] < target:
        p1 = medio + 1
    else: 
        p2 = medio - 1 

if p2 == -1:
    print(medio)
else:
    print("no esta")