import numpy as np
import re

dram = open("DRAMstart.mif", "w")

dram.write(
    "WIDTH=16;\nDEPTH=512;\n\nADDRESS_RADIX=HEX;\nDATA_RADIX=BIN;\n\nCONTENT BEGIN")

noc = int(input("Number of cores to be used?(max = 4)"))
dram.write("\n\t000  :   "+str(format(noc, '016b'))+";")

A = []
B = []
C = []

matrix = open(
    r"D:\Projects\University_Projects\FPGA\Multi_Core_FPGA_Project\mif_generator\matrix.txt", "r")

lines = matrix.readlines()

a = True
b = False
blank = 1
for i in range(len(lines)):
    row = list(map(int, lines[i].split()))
    if row == []:
        if blank == 1:
            a = False
            b = True
            blank += 1
        else:
            break
    elif a:
        # print(row)
        A.append(row)
    elif b:
        # print(row)
        B.append(row)

# print(A)
# print(B)
n = len(A)
m = len(B)
p = len(B[0])

dram.write("\n\t001  :   "+str(format(n, '016b'))+";")
dram.write("\n\t002  :   "+str(format(m, '016b'))+";")
dram.write("\n\t003  :   "+str(format(p, '016b'))+";")

ap = 7
dram.write("\n\t004  :   "+str(format(ap, '016b'))+";")
bp = 7+n*m
dram.write("\n\t005  :   "+str(format(bp, '016b'))+";")
cp = 7+n*m+m*p
dram.write("\n\t006  :   "+str(format(cp, '016b'))+";\n\t")

addr = ap
for i in range(n):
    for j in range(m):
        hexaddr = format(addr, '03x')
        element = format(A[i][j], '016b')
        dram.write(str(hexaddr.upper() + '  :   ' + element + ';\n\t'))
        addr += 1

for j in range(m):
    for k in range(p):
        hexaddr = format(addr, '03x')
        element = format(B[j][k], '016b')
        dram.write(str(hexaddr.upper() + '  :   ' + element + ';\n\t'))
        addr += 1

hexaddr = format(addr, '03x')
dram.write(str('['+hexaddr.upper()+'..1FF]  :   0000000000000000;'))

dram.write("\nEND;")
dram.close()
matrix.close()

result = np.dot(A, B)
print("Expected matrix after multiplication")
print(result)


a = input("Press ENTER after Quartus program runs")
if a == "":
    matrix = open(
        r"D:\Projects\University_Projects\FPGA\Multi_Core_FPGA_Project\mif_generator\matrix.txt", "a")
    dram1 = open(
        r"D:\Projects\University_Projects\FPGA\Multi_Core_FPGA_Project\Projects\simulation\modelsim\result.txt", "r")
    data = dram1.readlines()
    line3 = data[2].split(" ")
    wordsperline = int(line3[5][13:15])
    line = cp//wordsperline
    col = cp % wordsperline
    row = ""
    x = 1
    y = 1
    matrix.write("\n\nResulting matrix after multiplication:\n")
    for i in range(line+3, len(data)):
        c = data[i].split()
        if y > n:
            break
        elif i == line+3:
            for j in range(col, wordsperline):
                # print(x,c[j])
                element = c[j]
                # print(element)
                row += (element + " ")
                x += 1
                if x > p:
                    matrix.write(row)
                    matrix.write("\n")
                    row = ""
                    y += 1
                    x = 1
        else:
            for j in range(wordsperline):
                element = c[j]
                row += (element + " ")
                x += 1
                if x > p:
                    # print("current",y)
                    matrix.write(row)
                    matrix.write("\n")
                    row = ""
                    y += 1
                    x = 1
                    if y > n:
                        break


dram1.close()
matrix.close()
