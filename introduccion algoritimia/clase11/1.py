a = [2,32,50,3,15,14,235,7,10,13,24,25]
v = 0
for i in range(len(a)-1):
    v += 1
    for y in range(len(a)-1):
        if a[y] > a[y+1]:
            aux = a[y+1]
            a[y+1] = a[y]
            a[y] = aux
            
print(v)
print(a)

a = [2,32,50,3,15,14,235,7,10,13,24,25]            
v = 0
flag = True
while flag == True:
    v += 1
    flag = False
    for y in range(len(a)-1):
        if a[y] > a[y+1]:
            aux = a[y+1]
            a[y+1] = a[y]
            a[y] = aux
            flag = True
print(v)
print(a)