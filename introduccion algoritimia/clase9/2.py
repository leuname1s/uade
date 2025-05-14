import random

def par(numero):
    if numero % 2 == 0:
        return True
    return False

l = []
while len(l) < 20:
    n = random.randint(10,200)
    if not par(n):
        l.append(n)
        
print(l)