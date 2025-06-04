import random

def sumaDivisores(n):
    s = 0
    for i in range(1,n//2+1):
        if n % i == 0:
            s += i
    return s

def amigos(n1,n2):
    sn1 = sumaDivisores(n1)
    sn2 = sumaDivisores(n2)
    if sn1 == n2 and sn2 == n1:
        return True
    else:
        return False

# n1 = random.randint(100,1000)
# n2 = random.randint(100,1000)

n1 = 1184
n2 = 1210

if amigos(n1,n2):
    print(f"los numeros {n1} y {n2} son amigos")
else:
    print(f"los numeros {n1} y {n2} NO son amigos")
    