module end_core
(
	input clock,
	input[15:0] pc_out1,
	input[15:0] pc_out2,
	input[15:0] pc_out3,
	input[15:0] pc_out4,
	output reg[1:0] end_core1,
	output reg[1:0] end_core2,
	output reg[1:0] end_core3,
	output reg[1:0] end_core4
);

always @(posedge clock)
	begin
        if (pc_out1 != pc_out2)
            begin
                end_core2 <= 2'b10;
                end_core3 <= 2'b10;
                end_core4 <= 2'b10;
            end
        else if (pc_out1 != pc_out3)
            begin
                end_core3 <= 2'b10;
                end_core4 <= 2'b10;
            end
        else if (pc_out1 != pc_out4) end_core4 <= 2'b10;
        else
            begin
                end_core1 <= 2'b00;
                end_core2 <= 2'b00;
                end_core3 <= 2'b00;
                end_core4 <= 2'b00;
            end
	end

endmodule