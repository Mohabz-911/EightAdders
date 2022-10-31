
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
    
   ripple_carry_adder nibble0_0(S[3:0], Clow[0], A[3:0], B[3:0], 1'b0);  // Calculate S low nibble.

  
       genvar i;
       generate for(i=1;i<8;i=i+1)begin
   ripple_carry_adder nibble1_0(S0[i-1], C0[i-1], A[i*4+3:i*4], B[i*4+3:i*4], 1'b0);       // Calcualte S high nibble with carry input 0.
   ripple_carry_adder nibble1_1(S1[i-1], C1[i-1], A[i*4+3:i*4], B[i*4+3:i*4], 1'b1);       // Calcualte S high nibble with carry input 1.
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

module ripple_carry_adder(S, C, A, B, Cin);
   output [3:0] S;   // The 4-bit sum.
   output 	C;   // The 1-bit carry.
   input [3:0] 	A;   // The 4-bit augend.
   input [3:0] 	B;   // The 4-bit addend.
   input 	Cin; // The carry input.
 	
   wire 	C0; // The carry out bit of fa0, the carry in bit of fa1.
   wire 	C1; // The carry out bit of fa1, the carry in bit of fa2.
   wire 	C2; // The carry out bit of fa2, the carry in bit of fa3.
	
   full_adder fa0(S[0], C0, A[0], B[0], Cin);    // Least significant bit.
   full_adder fa1(S[1], C1, A[1], B[1], C0);
   full_adder fa2(S[2], C2, A[2], B[2], C1);
   full_adder fa3(S[3], C, A[3], B[3], C2);    // Most significant bit.
endmodule // ripple_carry_adder

module full_adder(S, Cout, A, B, Cin);
   output S;
   output Cout;
   input  A;
   input  B;
   input  Cin;
   
   wire   w1;
   wire   w2;
   wire   w3;
   wire   w4;
   
   xor(w1, A, B);
   xor(S, Cin, w1);
   and(w2, A, B);   
   and(w3, A, Cin);
   and(w4, B, Cin);   
   or(Cout, w2, w3, w4);
endmodule // full_adder

module multiplexer_2_1(X, A0, A1, S);
   parameter WIDTH=16;     // How many bits wide are the lines

   output [WIDTH-1:0] X;   // The output line

   input [WIDTH-1:0]  A1;  // Input line with id 1'b1
   input [WIDTH-1:0]  A0;  // Input line with id 1'b0
   input 	      S;  // Selection bit
   
   assign X = (S == 1'b0) ? A0 : A1;
endmodule // multiplexer_2_1