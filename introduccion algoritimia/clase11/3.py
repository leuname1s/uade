import random
l = []
notas = []
while len(l) < 5:
    n = random.randint(1000,5000)
    if n not in l:
        l.append(n)
        notas.append(random.randint(1,10))

print(l)
print(notas)

for i in range(len(l)-1):
    for j in range(i,len(l)):
        if l[j] < l[i]:
            aux = l[j]
            l[j] = l[i]
            l[i] = aux
            aux = notas[j]
            notas[j] = notas[i]
            notas[i] = aux

print(l)
print(notas)