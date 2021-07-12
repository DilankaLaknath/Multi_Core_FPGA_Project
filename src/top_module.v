module top_module
(
	input [1:0] status,
	input clk,
	input clockm,
	input ena,
	output z,
	output [15:0]write_en,
	output [3:0] read_en,
	output end_process1,
	output end_process2,
	output end_process3,
	output end_process4
);

	wire clock;
	wire [15:0] iram_out;
	wire [15:0] dram_out; wire [15:0] dram_out1; wire [15:0] dram_out2; wire [15:0] dram_out3; wire [15:0] dram_out4;
	wire dram_wren;
	wire iram_wren;
	wire [15:0] pc_out1; wire [15:0] pc_out2; wire [15:0] pc_out3; wire [15:0] pc_out4;
	wire [1:0] end_core1; wire [1:0] end_core2; wire [1:0]end_core3; wire [1:0]end_core4;
	wire [3:0] memory_mode;
	wire [15:0] ar_out; wire [15:0] ar_out1; wire [15:0] ar_out2; wire [15:0] ar_out3; wire [15:0] ar_out4;
	wire [15:0] bus_out; wire [15:0] bus_out1; wire [15:0] bus_out2; wire [15:0] bus_out3; wire [15:0] bus_out4;
	wire [15:0] ac_out1; wire [15:0] ac_out2; wire [15:0] ac_out3; wire [15:0] ac_out4;
	wire [15:0] dr_out;
	wire [15:0] ir_out;
	wire [15:0] i_out1;wire [15:0] i_out2;wire [15:0] i_out3;wire [15:0] i_out4;
//clockdivider clkdvdr(.clk_in(clk), .clk_out(clock));	
clock_divider clkdvdr(.inclk(clk),.ena(ena),.clk(clock));

core core1(.clock(clock),.clk(clock), .iram_out(iram_out),.dram_out(dram_out1),.status(status),
.dram_wren(dram_wren),.iram_wren(iram_wren),.pc_out(pc_out1),.ar_out(ar_out1),.bus_out(bus_out1),.end_process(end_process1),.ac_out(ac_out1),
.write_en(write_en),.read_en(read_en),.dr_out(dr_out),.ir_out(ir_out),.z(z),.core_id(16'd0),.memory_mode(memory_mode),.end_core(end_core1),.i_out(i_out1));

core core2(.clock(clock),.clk(clock), .iram_out(iram_out),.dram_out(dram_out2),.status(status),
.dram_wren(),.iram_wren(),.pc_out(pc_out2),.ar_out(ar_out2),.bus_out(bus_out2),.end_process(end_process2),.ac_out(ac_out2),
.write_en(),.read_en(),.dr_out(),.ir_out(),.z(),.core_id(16'd1),.end_core(end_core2),.i_out(i_out2));

core core3(.clock(clock),.clk(clock), .iram_out(iram_out),.dram_out(dram_out3),.status(status),
.dram_wren(),.iram_wren(),.pc_out(pc_out3),.ar_out(ar_out3),.bus_out(bus_out3),.end_process(end_process3),.ac_out(ac_out3),
.write_en(),.read_en(),.dr_out(),.ir_out(),.z(),.core_id(16'd2),.end_core(end_core3),.i_out(i_out3));

core core4(.clock(clock),.clk(clock), .iram_out(iram_out),.dram_out(dram_out4),.status(status),
.dram_wren(),.iram_wren(),.pc_out(pc_out4),.ar_out(ar_out4),.bus_out(bus_out4),.end_process(end_process4),.ac_out(ac_out4),
.write_en(),.read_en(),.dr_out(),.ir_out(),.z(),.core_id(16'd3),.end_core(end_core4),.i_out(i_out4));

end_core end_core(.clock(clock),.pc_out1(pc_out1),.pc_out2(pc_out2),.pc_out3(pc_out3),.pc_out4(pc_out4),
.end_core1(end_core1),.end_core2(end_core2),.end_core3(end_core3),.end_core4(end_core4));

memory_controller memory_controller(.clock(clk),.ar_out1(ar_out1),.ar_out2(ar_out2),.ar_out3(ar_out3),.ar_out4(ar_out4),
.bus_out1(bus_out1),.bus_out2(bus_out2),.bus_out3(bus_out3),.bus_out4(bus_out4),.dram_out(dram_out),.mode(memory_mode),
.ar_out(ar_out),.bus_out(bus_out),.dram_out1(dram_out1),.dram_out2(dram_out2),.dram_out3(dram_out3),.dram_out4(dram_out4),
.end_process2(end_process2),.end_process3(end_process3),.end_process4(end_process4));

IRAM  IRAM(.address(pc_out1),.clock(clk),.data(),.wren(),.q(iram_out));

DRAM  DRAM(.address(ar_out),.clock(clk),.data(bus_out),.wren(dram_wren),.q(dram_out));


endmodule