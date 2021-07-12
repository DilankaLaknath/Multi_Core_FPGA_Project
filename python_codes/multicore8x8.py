NoC = 2

Memory = [NoC,
          8,
          8,
          8,
          0,
          0,
          0,
          1,

          12, 11,  5, 18, 11, 19, 19,  2,
          20,  3,  3, 14,  2, 10,  2, 18,
          3,  3,  3,  3,  3, 11, 10, 17,
          1, 19, 16, 20, 20,  4, 18,  4,
          15, 10, 19, 20, 11, 13,  5,  1,
          9, 17,  4, 16, 10, 14, 18, 11,
          20,  9, 13, 15, 13,  4, 12, 20,
          8,  9, 13, 11, 19, 17,  2, 12,

          14,  9,  8,  8, 13, 19, 18,  2,
          9, 12, 13, 12, 19,  4, 18,  9,
          3, 14, 16, 17,  7,  2, 20, 12,
          2,  4, 10,  2, 10, 16, 19, 17,
          9,  9,  1, 14,  6,  6,  5,  7,
          20, 15, 17,  1,  5, 13, 11, 14,
          20, 15, 14,  6, 19, 12,  1,  1,
          8, 15,  3, 17,  5, 12, 11, 15,

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

print(Memory[136:144])
print(Memory[144:152])
print(Memory[152:160])
print(Memory[160:168])
print(Memory[168:176])
print(Memory[176:184])
print(Memory[184:192])
print(Memory[192:200])
