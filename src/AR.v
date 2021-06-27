module AR
(
input clk;
input write_en1;
input write_en2;
input rst_en;
input inc_en;
input [15:0] data_in1;
input [15:0] data_in2;
output reg [15:0] data_out;
);

always @ (posedge clk)
begin
	if (write_en1 == 1)
		data_out <= data_in1;
	if (write_en2 == 1)
		data_out <= data_in2;
	if (rst_en == 1)
		data_out <= 16'd0;
	if (inc_en == 1)
		data_out <= data_out + 16'd1;
end
endmodule