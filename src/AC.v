module AC
(   input clk,
	input write_en,
	input rst_en,
	input aluout_en,
	input [15:0]data_in,
	input [15:0]alu_out,
	output reg [15:0] data_out
);

always@ (posedge clk)
begin
	if (write_en == 1)
		data_out <= data_in;
	if (aluout_en == 1)
		data_out <= alu_out;
	if (rst_en == 1)
		data_out <= 16'd0;
end
endmodule
