NoC = 2

Memory = [NoC,
          6,
          6,
          6,
          0,
          0,
          0,
          1,

          2, 18, 11, 11, 20,  9,
          17,  6, 19,  6, 10, 12,
          16, 17,  2, 16, 18,  8,
          14, 17,  6, 11,  1, 17,
          15,  2,  5, 14, 13, 15,
          1,  9,  3,  2,  5, 16,

          3,  8,  8,  2, 3,  1,
          8, 10, 10, 19, 4, 14,
          16,  8, 2, 17, 5, 15,
          6,  9,  7, 11, 9, 12,
          19,  3,  6,  8, 4,  1,
          3, 15, 16,  7, 7, 4,

          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0

          ]

n = Memory[1]
m = Memory[2]
p = Memory[3]
s = Memory[7]
Memory[4], Memory[5], Memory[6] = 8, (8+n*m), (8+n*m+m*p)


def singlecore(CoreID, M=Memory):
    ID = CoreID
    AC = M[0]
    R = ID
    R += 1
    if AC < R:
        z = 1
    else:
        z = 0
    if z == 1:
        return None
    I = ID
    J = 0

    while True:  # loop
        R = I
        AC = M[1]
        R += 1
        if AC < R:
            z = 1
        else:
            z = 0
        if z == 1:
            return None
        K = 0

        while True:  # loop1
            R = K
            AC = M[3]
            AC = AC-R
            if AC == 0:
                z = 1
            else:
                z = 0
            if z == 1:
                break
            SUM = 0

            while True:  # loop2
                R = J
                AC = M[2]
                AC = AC - R
                if AC == 0:
                    z = 1
                else:
                    z = 0
                if z == 1:
                    R = I
                    AC = M[3]
                    AC = AC*R
                    R = K
                    AC = AC+R
                    R = AC
                    AC = M[7]
                    AC = AC*R
                    R = AC
                    AC = M[6]
                    AC = AC+R
                    R = AC

                    AC = SUM
                    M[R] = AC

                    K = K+1
                    J = 0
                    break

                R = I
                AC = M[2]
                AC = AC*R
                R = J
                AC += R
                R = AC
                AC = M[4]
                AC += R
                R = AC
                AC = M[R]
                A = AC

                R = J
                AC = M[3]
                AC = AC*R
                R = K
                AC += R
                R = AC
                AC = M[5]
                AC += R
                R = AC
                AC = M[R]

                AC = AC*A
                AC = AC+SUM
                SUM = AC

                J += 1
                continue
        R = I
        AC = M[0]
        AC += R
        I = AC


singlecore(0)
singlecore(1)
singlecore(2)
singlecore(3)

print(Memory[80:86])
print(Memory[86:92])
print(Memory[92:98])
print(Memory[98:104])
print(Memory[104:110])
print(Memory[110:116])
# print(Memory[184:192])
# print(Memory[192:200])
