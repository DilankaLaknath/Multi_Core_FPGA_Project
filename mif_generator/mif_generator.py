import numpy as np

dram = open("DRAMstart.mif", "w")

dram.write(
    "WIDTH=16;\nDEPTH=512;\n\nADDRESS_RADIX=HEX;\nDATA_RADIX=BIN;\n\nCONTENT BEGIN")

noc = int(input("Number of cores to be used?(max = 4)"))
dram.write("\n\t000  :   "+str(format(noc, '016b'))+";")
n = int(input("Number of rows in matrix A?"))
dram.write("\n\t001  :   "+str(format(n, '016b'))+";")
m = int(input("Number of columns in matrix A?"))
dram.write("\n\t002  :   "+str(format(m, '016b'))+";")
p = int(input("Number of columns in matrix B?"))
dram.write("\n\t003  :   "+str(format(p, '016b'))+";")

ap = 7
dram.write("\n\t004  :   "+str(format(ap, '016b'))+";")
bp = 7+n*m
dram.write("\n\t005  :   "+str(format(bp, '016b'))+";")
cp = 7+n*m+m*p
dram.write("\n\t006  :   "+str(format(cp, '016b'))+";\n\t")

A = []
B = []
C = []
print("Type each row of matrix A in a new line")

matrix = open(
    r"D:\Projects\University_Projects\FPGA\Multi_Core_FPGA_Project\mif_generator\matrix.txt", "r")


addr = ap
lines = matrix.readlines()

for i in range(len(lines)):
    row = list(map(int, lines[i].split()))
    if row == []:
        continue
    elif i < n:
        A.append(row)
    else:
        B.append(row)

# print(A)
# print(B)

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

result = np.dot(A, B)
print("Expected matrix after multiplication")
print(result)

# print("Export memory file and include start address as ",format(cp, '08x'))
# print("Tick addresses and data to be in decimal format\nAdd words per line as 1")

# a = input("Press ENTER after Quartus program runs")
# if a=="":
#     dram1 = open("C:\FPGA_project\Verilog16_1\Verilog16\simulation\modelsim\results.mem","r")
#     data = dram1.readlines()
#     for i in range((3),len(data)):
#         c = "".join(data[i].split())[3:-1]
#         print(c)
#         break
