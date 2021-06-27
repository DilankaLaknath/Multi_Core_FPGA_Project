module bus
(
	input clock,
	input [3:0] read_en,
	input [15:0] id,
	input [15:0] i,
	input [15:0] j,
	input [15:0] k,
	input [15:0] a,
	input [15:0] dr,
	input [15:0] ac,
	input [15:0] r,
	input [15:0] sum,
	input [15:0] DRAM,
	input [15:0] IRAM,
	output reg[15:0] busout
);

always @(id or i or j or k or a or dr or ac or r or sum or read_en)
begin
    case(read_en)
        4'd1: busout <= dr;
        4'd2: busout <= r;
        4'd3: busout <= id;
        4'd4: busout <= i;
        4'd5: busout <= j;
        4'd6: busout <= k;
        4'd7: busout <= a;
        4'd8: busout <= sum;
        4'd9: busout <= ac;
        4'd10: busout <= DRAM;
        4'd11: busout <= IRAM;
        default: busout <= 16'd0;
    endcase
end
endmodule
