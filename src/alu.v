module alu
(
    input clock,
    input [15:0] in1,
    input [15:0] in2,
    input [1:0] alu_op,
    output reg [15:0] out,
    output reg z
);

always @(*)
	begin
	case(alu_op)
        2'd1: out <= in1 + in2;
        2'd2: begin
                if(in1<in2)
                    begin
                        z <= 1;
                        //out <= in1;
                    end
                else
                    begin
                        z <= 0;
                        //out <= in1;
                    end
                end
        2'd3: out <= in1*in2;
	endcase
	end
//assign out = out_reg;
//assign z = z_reg;
endmodule