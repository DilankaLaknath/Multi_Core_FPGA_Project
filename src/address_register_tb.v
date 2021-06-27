`timescale 1ns/1ps

module address_register_tb();

localparam CLK_PERIOD = 2;

reg clk,write_en1,write_en2,rst_en,inc_en;
reg [15:0] data_in1;
reg [15:0] data_in2;
wire [15:0] data_out;

address_register AR(.clk(clk),.write_en1(write_en1),.write_en2(write_en2),.rst_en(rst_en),.inc_en(inc_en),.data_in1(data_in1),.data_in2(data_in2),
		.data_out(data_out));

initial begin
	clk = 1'b0;
	forever begin
		#(CLK_PERIOD/2);
		clk = ~clk;
	end
end

initial begin
	#10
	write_en1 = 1;
	write_en2 = 0;
	rst_en = 0;
	inc_en = 0;
	data_in1 = 16'd100;
	data_in2 = 16'd127;

	#10
	write_en1 = 0;
	write_en2 = 1;
	rst_en = 0;
	inc_en = 0;
	data_in1 = 16'd15;
	data_in2 = 16'd10;

	#10
	write_en1 = 0;
	write_en2 = 0;
	rst_en = 0;
	inc_en = 1;
	data_in1 = 16'd1;
	data_in2 = 16'd1;

	#10
	write_en1 = 0;
	write_en2 = 0;
	rst_en = 1;
	inc_en = 0;
	data_in1 = 16'd10;
	data_in2 = 16'd10;

end

endmodule