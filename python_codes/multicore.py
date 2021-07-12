NoC = 2

Memory = [NoC,
          4,
          4,
          4,
          0,
          0,
          0,
          1,

          1, 2, 3, 4,
          5, 6, 7, 8,
          9, 10, 11, 12,
          13, 14, 15, 16,

          17, 18, 19, 20,
          21, 22, 23, 24,
          25, 26, 27, 28,
          29, 30, 31, 32,

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
            R += 1
            #AC = AC-R
            if AC < R:
                z = 1
            else:
                z = 0
            if z == 1:
                break
            SUM = 0

            while True:  # loop2
                R = J
                AC = M[2]
                R += 1
                if AC < R:
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
                    #AC = M[7]
                    #AC = AC*R
                    #R = AC
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
# singlecore(2)
# singlecore(3)

print(Memory[40:44])
print(Memory[44:48])
print(Memory[48:52])
print(Memory[52:56])
