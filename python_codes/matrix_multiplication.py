A = [[12, 7, 3],
     [4, 5, 6],
     [7, 8, 9]]

B = [[5, 8, 1, 2],
     [6, 7, 3, 0],
     [4, 5, 9, 1]]

C = [[0, 0, 0, 0],
     [0, 0, 0, 0],
     [0, 0, 0, 0]]

m = len(A)
n = len(A[0])
p = len(B[0])
A1 = [0 for i in range(len(A)*len(A[0]))]
B1 = [0 for i in range(len(B)*len(B[0]))]
C1 = [0 for i in range(len(A)*len(B[0]))]
C2 = [0 for i in range(len(A)*len(B[0]))]


for i in range(m):
    for j in range(n):
        A1[i*n+j] = A[i][j]

for i in range(n):
    for j in range(p):
        B1[i*p+j] = B[i][j]

for i in range(m):
    for j in range(p):
        for k in range(n):
            C[i][j] += A[i][k] * B[k][j]

for i in range(m):
    for j in range(p):
        C1[i*p+j] = C[i][j]


for i in range(m):
    for j in range(p):
        for k in range(n):
            C2[i*p + j] += A1[i*n + k]*B1[k*p+j]
