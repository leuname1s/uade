import random

def repetido(l,n):
    if n in l:
        return True
    return False

l = []
while len(l) < 20:
    n = random.randint(10,30)
    if not repetido(l,n):
        l.append(n)
        
print(l)





















