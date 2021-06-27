`timescale 1ns/1ps

module alu_tb();

localparam CLK_PERIOD = 2;

reg clock;
reg [15:0] in1;
reg [15:0] in2;
reg [1:0] alu_op;
wire [15:0] out;
wire z;

alu alu(.clock(clock),.in1(in1),.in2(in2),.alu_op(alu_op),.out(out),.z(z)); 

initial begin
	clock = 1'b0;
	forever begin
		#(CLK_PERIOD/2);
		clock = ~clock;
	end
end

initial begin
	#10
	in1 = 16'd3;
	in2 = 16'd2;
	alu_op = 2'd1;

	#10
	in1 = 16'd3;
	in2 = 16'd3;
	alu_op = 2'd1;

	#10
	in1 = 16'd4;
	in2 = 16'd2;
	alu_op = 2'd1;

	#10
	in1 = 16'd3;
	in2 = 16'd2;
	alu_op = 2'd2;

	#10
	in1 = 16'd3;
	in2 = 16'd3;
	alu_op = 2'd2;

	#10
	in1 = 16'd4;
	in2 = 16'd6;
	alu_op = 2'd2;

	#10
	in1 = 16'd3;
	in2 = 16'd2;
	alu_op = 2'd3;

	#10
	in1 = 16'd3;
	in2 = 16'd3;
	alu_op = 2'd3;

	#10
	in1 = 16'd4;
	in2 = 16'd2;
	alu_op = 2'd3;

end

endmodule