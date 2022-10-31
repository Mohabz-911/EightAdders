`include "RCA.v"
`include "MUX.v"

module carry_select_adder(S, C, A, B);
   output [31:0] S;   // The 32-bit sum.
   output 	C;   // The 1-bit carry.
   input [31:0] 	A;   // The 32-bit augend.
   input [31:0] 	B;   // The 32-bit addend.
 
   wire [3:0] 	S0 [6:0];   // High nibble sum output with carry input 0.
   wire [3:0] 	S1 [6:0];   // High nibble sum output with carry input 1.
   wire [6:0]	C0;   // High nibble carry output with carry input 0.
   wire [6:0]	C1;   // High nibble carry output with carry input 1.
   wire [7:0]	Clow; // Low nibble carry output used to select multiplexer output.
    
   ripple_carry_adder #(4)nibble0_0(S[3:0], Clow[0], A[3:0], B[3:0], 1'b0);  // Calculate S low nibble.

  
       genvar i;
       generate for(i=1;i<8;i=i+1)begin
   ripple_carry_adder #(4)nibble1_0(S0[i-1], C0[i-1], A[i*4+3:i*4], B[i*4+3:i*4], 1'b0);       // Calcualte S high nibble with carry input 0.
   ripple_carry_adder #(4)nibble1_1(S1[i-1], C1[i-1], A[i*4+3:i*4], B[i*4+3:i*4], 1'b1);       // Calcualte S high nibble with carry input 1.
              end
       endgenerate




genvar j;
generate for(j=1;j<8;j=j+1)begin
   multiplexer_2_1 #(4) muxs0(S[j*4+3:j*4], S0[j-1], S1[j-1], Clow[j-1]);  // Clow selects the high nibble result for S.
   multiplexer_2_1 #(1) muxc0(Clow[j], C0[j-1], C1[j-1], Clow[j-1]);       // Clow selects the carry output.

end
endgenerate
  
 assign  C=Clow[7];
  
   //multiplexer_2_1 #(1) muxc(C, C0[7], C1[7], Clow[7]);       // Clow selects the carry output.

  
endmodule // carry_select_adder