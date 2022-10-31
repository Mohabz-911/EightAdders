`include "carry_select_adder.v"

module test();
reg[31:0] a,b;

wire[31:0]s;
wire  c;
carry_select_adder add(s,c,a,b);


initial begin

a=32'b111111111100000000001111111111;
b=32'b1;

end endmodule