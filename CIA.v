`include "fullAdder.v"
module CIA(S, C, A, B, Cin);
    parameter WIDTH = 32;
    output [WIDTH-1:0]S;
    output C;
    input [WIDTH-1:0]A,B;
    input Cin;
    
    wire [6:0] Temp_Cout;
    ripple_carry_adder#(4)RCA1(S[3:0], Temp_Cout[0], A[3:0], B[3:0], Cin);

    RCA_with_HA RCA2(S[7:4], Temp_Cout[1], A[7:4], B[7:4], Temp_Cout[0]);       // Calcualte S high nibble with carry input 0.
    RCA_with_HA RCA3(S[11:8], Temp_Cout[2], A[11:8], B[11:8], Temp_Cout[1]);       // Calcualte S high nibble with carry input 0.
    RCA_with_HA RCA4(S[15:12], Temp_Cout[3], A[15:12], B[15:12], Temp_Cout[2]);       // Calcualte S high nibble with carry input 0.
    RCA_with_HA RCA5(S[19:16], Temp_Cout[4], A[19:16], B[19:16], Temp_Cout[3]);       // Calcualte S high nibble with carry input 0.
    RCA_with_HA RCA6(S[23:20], Temp_Cout[5], A[23:20], B[23:20], Temp_Cout[4]);       // Calcualte S high nibble with carry input 0.
    RCA_with_HA RCA7(S[27:24], Temp_Cout[6], A[27:24], B[27:24], Temp_Cout[5]);       // Calcualte S high nibble with carry input 0.

    RCA_with_HA RCA8(S[31:28], C, A[WIDTH-1:WIDTH-4], B[WIDTH-1:WIDTH-4], Temp_Cout[6]);       // Calcualte S high nibble with carry input 0.

endmodule //carry increment adder