import random

for i in range(1000):
    v = random.randint(100,10000)
    c = i-1
    while c > 1:
        if i % c == 0:
            c = -1
        c -= 1
    if c == 1:
        c = v
        s = 0
        while c > 0:
            if v % c == 0:
                s += c
            c -= 1
        if s < v*2:
            print(v," - ",i, end=" / ")
               