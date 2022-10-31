`include "fullAdder.v"

module ripple_carry_adder #(parameter WIDTH = 4)(S, C, A, B, Cin);
    output [WIDTH - 1:0] S;   // The 4-bit sum.
    output 	C;   // The 1-bit carry.
    input [WIDTH - 1:0] 	A;   // The 4-bit augend.
    input [WIDTH - 1:0] 	B;   // The 4-bit addend.
    input 	Cin; // The carry input.
 	
    wire [WIDTH-2:0]	Cx; // The carry outs of each FA

    full_adder fa0(S[0], Cx[0], A[0], B[0], Cin);    // Least significant bit.
    
    genvar i;
    generate 
    for(i = 1; i < WIDTH-1; i = i+1)
        full_adder fa(S[i], Cx[i], A[i], B[i], Cx[i-1]);
    endgenerate
   
   full_adder fa2(S[WIDTH-1], C, A[WIDTH-1], B[WIDTH-1], Cx[WIDTH-2]);    // Most significant bit.
   
endmodule // ripple_carry_adder