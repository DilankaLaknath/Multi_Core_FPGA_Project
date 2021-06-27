module Register1(clk,write_en,rst_en,inc_en,data_in,data_out);   //normal register with read,write,inc,rst
input clk;input write_en;input rst_en;input inc_en;
input [15:0] data_in;
output reg [15:0] data_out;
	
always @ (posedge clk)
begin
	if (write_en == 1)
		data_out <= data_in;
	if (rst_en == 1)
		data_out <= 16'd0;
	if (inc_en == 1)
		data_out <= data_out + 16'd1;
end
endmodule