`include "fullAdder.v"
module RCA_with_HA (S, C, A, B, Cin);
    parameter WIDTH=4;

    output [WIDTH - 1:0] S;   // The 4-bit sum.
    output 	C;   // The 1-bit carry.
    input [WIDTH - 1:0] 	A,B;   // The 4-bit augend.
    input 	Cin; // The carry input.
 	
    wire TEMP_Cin,TEMP_Cout;
    wire [WIDTH-1:0]TEMP_RSUM;
    assign TEMP_Cin=0;
    ripple_carry_adder #(.WIDTH(WIDTH)) Rcad(TEMP_RSUM,TEMP_Cout,A,B,TEMP_Cin);


    wire [WIDTH-1:0] HA_Cout;
    halfAdder ha0(S[0],HA_Cout[0],TEMP_RSUM[0],Cin);
    halfAdder ha1(S[1],HA_Cout[1],TEMP_RSUM[1],HA_Cout[0]);
    halfAdder ha2(S[2],HA_Cout[2],TEMP_RSUM[2],HA_Cout[1]);
    halfAdder ha3(S[3],HA_Cout[3],TEMP_RSUM[3],HA_Cout[2]);
    assign C= TEMP_Cout | HA_Cout[3];
endmodule // ripple_carry_adder