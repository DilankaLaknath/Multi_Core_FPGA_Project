module control_unit
(
    input clock,
    input z,
    input [1:0]end_core,
    input [15:0] instruction ,
    output reg [1:0] alu_op,
    output reg [15:0] write_en ,
    output reg [4:0] inc_en,
    output reg [3:0] read_en,
    output reg [15:0] rst_en,
    output reg end_process ,
    output reg[3:0] memory_mode,
    input [1:0] status
);

reg [6:0] present = 7'd67;
reg [6:0] next = 7'd67;

parameter
fetch0 = 7'd67,
fetch1 = 7'd0,
fetch2 = 7'd1,
fetch3 = 7'd2,
fetch4 = 7'd3,

nop1 = 7'd4,

ldac1 = 7'd5,
ldac2 = 7'd6,
ldac3 = 7'd7,
ldac4 = 7'd8,

loadac1 = 7'd9,
loadac2 = 7'd10,
loadac3 = 7'd11,

stac1 = 7'd12,
stac2 = 7'd13,

mvacr1 = 7'd14,
mvaca1 = 7'd15,
mvacsum1 = 7'd16,
mvaci1 = 7'd17,
mvsumac1 = 7'd18,
mvir1 = 7'd19,
mvkr1 = 7'd20,
mvjr1 = 7'd21,
mvidr1 = 7'd22,

mulr1 = 7'd23,
mula1 = 7'd24,
addr1 = 7'd25,
addsum1 = 7'd26,
comp1 = 7'd27,

inck1 = 7'd28,
incj1 = 7'd29,
incr1 = 7'd30,

jmpzy1 = 7'd31,
jmpzy2 = 7'd32,

jmpzn1 = 7'd42,
jmpzn2 = 7'd43,

jump1 = 7'd33,
jump2 = 7'd34,

rstall1 = 7'd35,
rsti1 = 7'd36,
rstj1 = 7'd37,
rstk1 = 7'd38,
rstsum1 = 7'd39,

idle = 7'd40,
endop = 7'd41,

fetchx = 7'd44,
ldacx = 7'd45,
ldacy = 7'd46,
ldacz = 7'd68,

jmpzyx = 7'd47,
jumpx = 7'd48,
loadacx1 =7'd49,
loadacx2 =7'd50,
loadacx3 =7'd51,
loadacx4 =7'd52,
loadacx5 =7'd53,
loadacx6 =7'd54,
loadacx7 =7'd55,
loadacx8 = 7'd69,
loadacx9 = 7'd70,

stacx1 = 7'd56,
stacx2 = 7'd57,
stacx3 = 7'd58,
stacx4 = 7'd59,
stacx5 = 7'd60,
stacx6 = 7'd61,
stacx7 = 7'd62,
stacx8 = 7'd63,
stacx9 = 7'd64,
stacx10 = 7'd65,
stacy = 7'd66;

always @(posedge clock)
present <= next;

always @(posedge clock)
begin
    if (present == endop)
        end_process <= 1'd1;
    else
        end_process <= 1'd0;
end

always @(present or z or instruction or status)
case(present)
idle: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ; // PC AR R J K
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
if (status == 2'b01)
    next <= fetch1;
else
    next <= idle;
end

fetch0: begin
rst_en <= 16'b1111111111111111 ;
next <= fetch1;
end

fetch1: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd0;
next <= fetch2;
end

fetch2: begin
read_en <= 4'd11;
inc_en <= 5'b10000 ;
write_en <= 16'b0100000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetchx;
end

fetchx: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch3;
end


fetch3: begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b0001000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch4;
end

fetch4: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
if (end_core==2'b10) next <= endop;
else if (instruction [15:0]==16'd28)	next <= nop1;
else if (instruction [15:0]==16'd1)	    next <= ldac1;
else if (instruction [15:0]==16'd2)	    next <= loadac1;
else if (instruction [15:0]==16'd3)	    next <= stac1;
else if (instruction [15:0]==16'd4)	    next <= mvacr1;
else if (instruction [15:0]==16'd5)	    next <= mvaca1;
else if (instruction [15:0]==16'd6)	    next <= mvacsum1;
else if (instruction [15:0]==16'd7)	    next <= mvaci1;
else if (instruction [15:0]==16'd8)	    next <= mvsumac1;
else if (instruction [15:0]==16'd9)	    next <= mvir1;
else if (instruction [15:0]==16'd10)	next <= mvkr1;
else if (instruction [15:0]==16'd11)	next <= mvjr1;
else if (instruction [15:0]==16'd12)	next <= mvidr1;
else if (instruction [15:0]==16'd13)	next <= mulr1;
else if (instruction [15:0]==16'd14)	next <= mula1;
else if (instruction [15:0]==16'd15)	next <= addr1;
else if (instruction [15:0]==16'd16)	next <= addsum1;
else if (instruction [15:0]==16'd17)	next <= comp1;
else if (instruction [15:0]==16'd18)	next <= inck1;
else if (instruction [15:0]==16'd19)	next <= incj1;
else if (instruction [15:0]==16'd20)	next <= incr1;
else if (instruction [15:0]==16'd22)	next <= jump1;
else if (instruction [15:0]==16'd23)	next <= rstall1;
else if (instruction [15:0]==16'd24)	next <= rsti1;
else if (instruction [15:0]==16'd25)	next <= rstj1;
else if (instruction [15:0]==16'd26)	next <= rstk1;
else if (instruction [15:0]==16'd27)	next <= rstsum1;
else if ((instruction [15:0]==16'd21) & (z==1))	next <= jmpzy1;
else if ((instruction [15:0]==16'd21) & (z==0))	next <= jmpzn1;
else next <= endop;
end

ldac1: begin
read_en <= 4'd11;
inc_en <= 5'b10000 ;
write_en <= 16'b0100000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd0;
next <= ldacx;
end

ldacx: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= ldac2;
end

ldac2: begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b0010000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= ldacz;
end

ldacz: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= ldac3;
end

ldac3: begin
read_en <= 4'd10;
inc_en <= 5'b00000 ;
write_en <= 16'b0100000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= ldacy;
end

ldacy: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= ldac4;
end

ldac4: begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000010000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end

////////////////////////////////////////////////////////
loadac1: begin
read_en <= 4'd2;
inc_en <= 5'b00000 ;
write_en <= 16'b0010000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= loadac2;
end
//step1
loadac2 : begin
read_en <= 4'd10;
inc_en <= 5'b00000 ;
write_en <= 16'b0100000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd1;
next <= loadacx1;
end

loadacx1: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd1;
next <= loadacx2;
end


//step2
loadacx2 : begin
read_en <= 4'd10;
inc_en <= 5'b00000 ;
write_en <= 16'b0100000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd2;
next <= loadacx3;
end

loadacx3: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd2;
next <= loadacx4;
end

//step3
loadacx4 : begin
read_en <= 4'd10;
inc_en <= 5'b00000 ;
write_en <= 16'b0100000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd3;
next <= loadacx5;
end

loadacx5: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd3;
next <= loadacx6;
end

//step4
loadacx6 : begin
read_en <= 4'd10;
inc_en <= 5'b00000 ;
write_en <= 16'b0100000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd4;
next <= loadacx7;
end

loadacx7: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd4;
next <= loadacx8;
end

loadacx8: begin
read_en <= 4'd10;
inc_en <= 5'b00000 ;
write_en <= 16'b0100000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd4;
next <= loadacx9;
end

loadacx9: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd4;
next <= loadac3;
end

loadac3 : begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000010000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end


////////////////////////////////////////////////////////////////////
stac1: begin
read_en <= 4'd9;
inc_en <= 5'b00000 ;
write_en <= 16'b0100000000000010 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= stacy;
end

stacy:begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd5;
next <= stac2;
end

stac2: begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000001000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd5;
next <= stacx1;
end

stacx1: begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd5;
next <= stacx2;
end
///core2
stacx2: begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd6;
next <= stacx3;
end

stacx3: begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000001000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd6;
next <= stacx4;
end

stacx4: begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd6;
next <= stacx5;
end
////core3
stacx5: begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd7;
next <= stacx6;
end

stacx6: begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000001000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd7;
next <= stacx7;
end

stacx7: begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd7;
next <= stacx8;
end
////core4
stacx8: begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd8;
next <= stacx9;
end

stacx9: begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000001000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd8;
next <= stacx10;
end

stacx10: begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
memory_mode <= 4'd8;
next <= fetch1;
end



////////////////////////////////////
mvacr1: begin
read_en <= 4'd9;
inc_en <= 5'b00000 ;
write_en <= 16'b0000100000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end

mvaca1: begin
read_en <= 4'd9;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000001000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end

mvacsum1: begin
read_en <= 4'd9;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000100000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end

mvaci1: begin
read_en <= 4'd9;
inc_en <= 5'b00000 ;
write_en <= 16'b0000001000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end

mvsumac1: begin
read_en <= 4'd8;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000010000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end


mvir1: begin
read_en <= 4'd4;
inc_en <= 5'b00000 ;
write_en <= 16'b0000100000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end

mvkr1 : begin
read_en <= 4'd6;
inc_en <= 5'b00000 ;
write_en <= 16'b0000100000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end

mvjr1: begin
read_en <= 4'd5;
inc_en <= 5'b00000 ;
write_en <= 16'b0000100000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end

mvidr1: begin
read_en <= 4'd3;
inc_en <= 5'b00000 ;
write_en <= 16'b0000100000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end

mulr1: begin
read_en <= 4'd2;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000001 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd3;
next <= fetch1;
end

mula1: begin
read_en <= 4'd7;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000001 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd3;
next <= fetch1;
end

addr1: begin
read_en <= 4'd2;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000001 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd1;
next <= fetch1;
end

addsum1: begin
read_en <= 4'd8;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000001 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd1;
next <= fetch1;
end

comp1: begin 
read_en <= 4'd2;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd2;
next <= fetch1;
end

inck1: begin
read_en <= 4'd0;
inc_en <= 5'b00001 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end

incj1: begin
read_en <= 4'd0;
inc_en <= 5'b00010 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end

incr1: begin
read_en <= 4'd0;
inc_en <= 5'b00100 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end

jmpzy1: begin
read_en <= 4'd11;
inc_en <= 5'b00000 ;
write_en <= 16'b0100000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= jmpzyx;
end

jmpzyx: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= jmpzy2;
end

jmpzy2: begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b1000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end


jmpzn1: begin
read_en <= 4'd0;
inc_en <= 5'b10000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end



jump1: begin
read_en <= 4'd11;
inc_en <= 5'b00000 ;
write_en <= 16'b0100000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= jumpx;
end

jumpx: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= jump2;
end

jump2: begin
read_en <= 4'd1;
inc_en <= 5'b00000 ;
write_en <= 16'b1000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end


rstall1: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0110111111100000 ;
alu_op <= 2'd0;
next <= fetch1;
end

rsti1: begin
read_en <= 4'd3;
inc_en <= 5'b00000 ;
write_en <= 16'b0000001000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end

rstj1: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000100000000 ;
alu_op <= 2'd0;
next <= fetch1;
end

rstk1: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000010000000 ;
alu_op <= 2'd0;
next <= fetch1;
end

rstsum1: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000100000 ;
alu_op <= 2'd0;
next <= fetch1;
end

nop1: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end

endop: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= endop;
end

default: begin
read_en <= 4'd0;
inc_en <= 5'b00000 ;
write_en <= 16'b0000000000000000 ;
rst_en <= 16'b0000000000000000 ;
alu_op <= 2'd0;
next <= fetch1;
end
endcase

endmodule



