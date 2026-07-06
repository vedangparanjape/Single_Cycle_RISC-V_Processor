module fa(
    input A,B,Cin,
    output S,Cout);
    assign S = A^B^Cin;
    assign Cout = (A&B)|(A&Cin)|(B&Cin);
endmodule

module fa32(
    input [31:0] A,B,
    input Cin,
    output [31:0] S,
    output Cout);
    wire [31:0] Couttemp;
    fa inst1(.A(A[0]),.B(B[0]),.Cin(Cin),.S(S[0]),.Cout(Couttemp[0]));
    genvar i;
    generate
        for (i=1;i<32;i=i+1)begin : adder_loop
            fa inst_i(.A(A[i]),.B(B[i]),.Cin(Couttemp[i-1]),.S(S[i]),.Cout(Couttemp[i]));
        end
    endgenerate
    assign Cout = Couttemp[31];
endmodule