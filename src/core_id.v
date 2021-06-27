module core_id
(
    input clk,
    input rst_en,
    input[15:0] data_in,
    output reg [15:0] data_out
);

always @ (posedge clk)
begin
	if (rst_en == 1)
		data_out <= data_in;
end
endmodule