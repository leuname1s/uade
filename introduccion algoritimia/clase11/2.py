import random
a = []
for i in range(20):
    n = random.randint(1000,5000)
    if n not in a:
        a.append(n)

flag = True
print(a)
while flag == True:
    flag = False
    for y in range(len(a)-1):
        if a[y] > a[y+1]:
            aux = a[y+1]
            a[y+1] = a[y]
            a[y] = aux
            flag = True
            
print(a)
            