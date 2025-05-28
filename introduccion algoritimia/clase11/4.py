import random

l = []

def oblongo(n):
    for i in range(n):
        c = i*(i+1)
        if c > n:
            return False
        elif c == n:
            return True
            

while len(l) < 20:
    n = random.randint(5,1000)
    if oblongo(n):
        l.append(n)

print(l)
        
for i in range(len(l)-1):
    for j in range(i,len(l)):
        if l[j] < l[i]:
            aux = l[j]
            l[j] = l[i]
            l[i] = aux
            
print(l)
