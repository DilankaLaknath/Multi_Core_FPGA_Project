`timescale 1ns/1ps

module bus_tb();

localparam CLK_PERIOD = 2;

reg clock;
reg [3:0] read_en;
reg [15:0] id;
reg [15:0] i;
reg [15:0] j;
reg [15:0] k;
reg [15:0] a;
reg [15:0] dr;
reg [15:0] ac;
reg [15:0] r;
reg [15:0] sum;
reg [15:0] DRAM;
reg [15:0] IRAM;
wire[15:0] busout;


bus bus(.clock(clock),.read_en(read_en),.id(id),.i(i),.j(j),.k(k),.a(a),.dr(dr),.ac(ac),.r(r),
.sum(sum),.DRAM(DRAM),.IRAM(IRAM),.busout(busout));

initial begin
	clock = 1'b0;
	forever begin
		#(CLK_PERIOD/2);
		clock = ~clock;
	end
end

initial begin
	#10
	read_en= 4'd1;
	id= 16'd1;
	i= 16'd02;
	j= 16'd03;
	k= 16'd04;
	a= 16'd05;

	dr= 16'd07;
	ac= 16'd08;
	r= 16'd09;
	sum= 16'd10;
	DRAM= 16'd011;
	IRAM= 16'd012;

	#10
	read_en= 4'd2;
	id= 16'd1;
	i= 16'd02;
	j= 16'd03;
	k= 16'd04;
	a= 16'd05;

	dr= 16'd07;
	ac= 16'd08;
	r= 16'd09;
	sum= 16'd10;
	DRAM= 16'd011;
	IRAM= 16'd012;

	#10
	read_en= 4'd3;
	id= 16'd1;
	i= 16'd02;
	j= 16'd03;
	k= 16'd04;
	a= 16'd05;

	dr= 16'd07;
	ac= 16'd08;
	r= 16'd09;
	sum= 16'd10;
	DRAM= 16'd011;
	IRAM= 16'd012;

	#10
	read_en= 4'd4;
	id= 16'd1;
	i= 16'd02;
	j= 16'd03;
	k= 16'd04;
	a= 16'd05;

	dr= 16'd07;
	ac= 16'd08;
	r= 16'd09;
	sum= 16'd10;
	DRAM= 16'd011;
	IRAM= 16'd012;

	#10
	read_en= 4'd5;
	id= 16'd1;
	i= 16'd02;
	j= 16'd03;
	k= 16'd04;
	a= 16'd05;

	dr= 16'd07;
	ac= 16'd08;
	r= 16'd09;
	sum= 16'd10;
	DRAM= 16'd011;
	IRAM= 16'd012;

	#10
	read_en= 4'd6;
	id= 16'd1;
	i= 16'd02;
	j= 16'd03;
	k= 16'd04;
	a= 16'd05;

	dr= 16'd07;
	ac= 16'd08;
	r= 16'd09;
	sum= 16'd10;
	DRAM= 16'd011;
	IRAM= 16'd012;

	#10
	read_en= 4'd7;
	id= 16'd1;
	i= 16'd02;
	j= 16'd03;
	k= 16'd04;
	a= 16'd05;

	dr= 16'd07;
	ac= 16'd08;
	r= 16'd09;
	sum= 16'd10;
	DRAM= 16'd011;
	IRAM= 16'd012;

	#10
	read_en= 4'd8;
	id= 16'd1;
	i= 16'd02;
	j= 16'd03;
	k= 16'd04;
	a= 16'd05;

	dr= 16'd07;
	ac= 16'd08;
	r= 16'd09;
	sum= 16'd10;
	DRAM= 16'd011;
	IRAM= 16'd012;

	#10
	read_en= 4'd9;
	id= 16'd1;
	i= 16'd02;
	j= 16'd03;
	k= 16'd04;
	a= 16'd05;

	dr= 16'd07;
	ac= 16'd08;
	r= 16'd09;
	sum= 16'd10;
	DRAM= 16'd011;
	IRAM= 16'd012;

	#10
	read_en= 4'd10;
	id= 16'd1;
	i= 16'd02;
	j= 16'd03;
	k= 16'd04;
	a= 16'd05;

	dr= 16'd07;
	ac= 16'd08;
	r= 16'd09;
	sum= 16'd10;
	DRAM= 16'd011;
	IRAM= 16'd012;

	#10
	read_en= 4'd11;
	id= 16'd1;
	i= 16'd02;
	j= 16'd03;
	k= 16'd04;
	a= 16'd05;

	dr= 16'd07;
	ac= 16'd08;
	r= 16'd09;
	sum= 16'd10;
	DRAM= 16'd011;
	IRAM= 16'd012;
end

endmodule