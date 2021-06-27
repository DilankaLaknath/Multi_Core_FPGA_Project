`timescale 1ns/1ps

module top_module_tb();

localparam CLK_PERIOD = 20;

reg [1:0] status;
reg clk;
reg clockm;
reg ena;
wire z;
wire [15:0]write_en;
wire [3:0] read_en;
wire end_process1;
wire end_process2;
wire end_process3;
wire end_process4;

top_module1 top_module (
	.status(status),
	.clk(clk),
	.clockm(clockm),
	.ena(ena),
	.z(z),
	.write_en(write_en),
	.read_en(read_en),
	.end_process1(end_process1),
	.end_process2(end_process2),
	.end_process3(end_process3),
	.end_process4(end_process4) );

initial begin
	clk = 1'b0;
	clockm = 1'b0;
	ena <= 1'b1;
	status <= 2'b01;
	forever begin
		#(CLK_PERIOD/2);
		clk = ~clk;
		clockm = ~clockm;
	end
end


endmodule