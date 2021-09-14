#!/usr/bin/env python3
import random

N = 1000
n = random.randint(1, N)
m = random.randint(1, N)

print(n, m)
for i in range(n):
    for j in range(m):
        if random.random() < 0.6:
            print(0, end=" ")
        else:
            print(random.randint(1, 10), end=" ")
    print()
