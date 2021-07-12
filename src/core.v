module core
(
	input clock,
	input clk, //fast clock
	input [15:0]iram_out,
	input [15:0]dram_out,
	input [1:0]status,
	input [15:0] core_id,
	input [1:0] end_core,
	output dram_wren,
	output iram_wren,
	output [3:0]memory_mode,
	output [15:0]pc_out,
	output [15:0]ar_out,
	output [15:0]bus_out,
	output [15:0]ac_out,
	output [15:0]write_en,
	output [3:0] read_en,
	output [15:0] dr_out,
	output [15:0] ir_out,
	output [15:0] i_out,
	output end_process,
	output z
);

	//wire[15:0] busout;
	//wire z;
    //wire[15:0] ir_out;
	wire[1:0] alu_op;
	//wire[15:0] write_en;
	wire[4:0] inc_en;
	//wire[3:0] read_en;
	wire[15:0] rst_en;
	wire[15:0] id_out;
	//wire[15:0] i_out;
	wire[15:0] j_out;
	wire[15:0] k_out;
	wire[15:0] a_out;
    //wire[15:0] dr_out;
	//wire[15:0] ac_out;
	wire[15:0] r_out;
	wire[15:0] sum_out;
	wire[15:0] alu_out;

//CU//
control_unit CU(.clock(clock), .z(z),.instruction(ir_out) ,.alu_op(alu_op),.write_en(write_en) ,.inc_en(inc_en),.read_en(read_en),
.rst_en(rst_en),.end_process(end_process) ,.status(status),.memory_mode(memory_mode),.end_core(end_core) );

//BUS//
bus BUS( .clock(clock),.read_en(read_en),.id(id_out),.i(i_out),.j(j_out),.k(k_out),.a(a_out),
.dr(dr_out),.ac(ac_out),.r(r_out),.sum(sum_out),.DRAM(dram_out),.IRAM(iram_out),.busout(bus_out)) ;

//ALU//
alu ALU(.clock(clock),.in1(ac_out),.in2(bus_out),.alu_op(alu_op),.out(alu_out),.z(z));

//PC//
register_16 PC(.clk(clk),.write_en(write_en[15]),.rst_en(rst_en[15]),.inc_en(inc_en[4]),.data_in(bus_out),.data_out(pc_out));

//DR//
data_register DR(.clk(clk),.write_en(write_en[14]),.data_in(bus_out),.data_out(dr_out));

//AR//
address_register AR(.clk(clk),.write_en1(write_en[13]),.write_en2(write_en[1]),.rst_en(rst_en[13]),.inc_en(inc_en[3]),
.data_in1(bus_out),.data_in2(r_out),.data_out(ar_out));

//IR//
register_16 IR(.clk(clk),.write_en(write_en[12]),.rst_en(rst_en[12]),.inc_en(),.data_in(bus_out),.data_out(ir_out));

//R//
register_16 R(.clk(clk),.write_en(write_en[11]),.rst_en(rst_en[11]),.inc_en(inc_en[2]),.data_in(bus_out),.data_out(r_out));

//ID//
core_id ID(.clk(clk),.rst_en(rst_en[10]),.data_in(core_id),.data_out(id_out)); 

//I//
register_type_2 I(.clk(clk),.write_en(write_en[9]),.rst_en(rst_en[9]),.inc_en(),.data_in(bus_out),.data_out(i_out));

//J//
register_type_2 J(.clk(clk),.write_en(write_en[8]),.rst_en(rst_en[8]),.inc_en(inc_en[1]),.data_in(),.data_out(j_out));

//K//
register_type_2 K(.clk(clk),.write_en(write_en[7]),.rst_en(rst_en[7]),.inc_en(inc_en[0]),.data_in(),.data_out(k_out));

//A//
register_16 A(.clk(clk),.write_en(write_en[6]),.rst_en(rst_en[6]),.inc_en(),.data_in(bus_out),.data_out(a_out));

//SUM//
register_16 SUM(.clk(clk),.write_en(write_en[5]),.rst_en(rst_en[5]),.inc_en(),.data_in(bus_out),.data_out(sum_out));

//AC //
accumulator AC(.clk(clk),.write_en(write_en[4]),.rst_en(rst_en[4]),.aluout_en(write_en[0]),.data_in(bus_out),.alu_out(alu_out),.data_out(ac_out));

assign dram_wren = write_en[3];
assign iram_wren = write_en[2];

endmodule

