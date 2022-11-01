module halfAdder (S, Cout, A, B);
    input A,B;
    output Cout,S;

    assign S = A ^ B; // bitwise xor
    assign Cout = A & B; // bitwise and
    
endmodule