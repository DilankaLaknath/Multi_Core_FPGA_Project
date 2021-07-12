module memory_controller
(
	input clock,
	input [15:0] ar_out1,
	input [15:0] ar_out2,
	input [15:0] ar_out3,
	input [15:0] ar_out4,
	input [15:0] bus_out1,
	input [15:0] bus_out2,
	input [15:0] bus_out3,
	input [15:0] bus_out4,
	input [15:0] dram_out,
	input [3:0] mode,
	input end_process2,
	input end_process3,
	input end_process4,
	output reg[15:0] ar_out,
	output reg[15:0] bus_out,
	output reg[15:0] dram_out1,
	output reg[15:0] dram_out2,
	output reg[15:0] dram_out3,
	output reg[15:0] dram_out4
);

always @(posedge clock)
begin
	if (mode == 4'd1)
        begin
            ar_out <= ar_out1;
            dram_out1 <= dram_out;
        end
	else if (mode == 4'd2)
        begin
            ar_out <= ar_out2;
            dram_out2 <= dram_out;
        end
	else if (mode == 4'd3)
        begin
            ar_out <= ar_out3;
            dram_out3 <= dram_out;
        end
	else if (mode == 4'd4)
        begin
            ar_out <= ar_out4;
            dram_out4 <= dram_out;
        end
	else if (mode == 4'd5)
        begin
            ar_out <= ar_out1;
            bus_out <= bus_out1;
        end
	else if ((mode == 4'd6) & (end_process2 != 1))
        begin
            ar_out <= ar_out2;
            bus_out <= bus_out2;
        end
	else if ((mode == 4'd7) & (end_process3 != 1))
        begin
            ar_out <= ar_out3;
            bus_out <= bus_out3;
        end
	else if ((mode == 4'd8) & (end_process4 != 1))
        begin
            ar_out <= ar_out4;
            bus_out <= bus_out4;
        end
	else if (mode == 4'd0)
        begin
            ar_out <= ar_out1;
            dram_out1 <= dram_out;
            dram_out2 <= dram_out;
            dram_out3 <= dram_out;
            dram_out4 <= dram_out;
        end
end

endmodule