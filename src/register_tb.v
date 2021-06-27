`timescale 1ns/1ps

module register_tb();

localparam CLK_PERIOD = 20;

reg clk;
reg write_en;
reg rst_en;
reg inc_en;
reg [15:0] data_in;
wire [15:0] data_out;

register_type_1 register(.clk(clk),.write_en(write_en),.rst_en(rst_en),.inc_en(inc_en),.data_in(data_in),.data_out(data_out)); 

initial begin
	clk = 1'b0;
	forever begin
		#(CLK_PERIOD/2);
		clk = ~clk;
	end
end

initial begin
	#10
	write_en = 1;
	data_in = 16'd10;

	#10
	write_en = 0;
	data_in = 16'd15;

	#10
	inc_en = 1;

	#10
	inc_en = 0;
	rst_en = 1;

end

endmodule