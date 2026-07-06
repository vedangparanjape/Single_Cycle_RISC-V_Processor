module ALU(
    input [31:0] A,B,
    input [2:0] ALUControl,
    output reg [31:0] Result,
    output Z,N,C,V);
    wire [31:0] muxout, sumtemp;
    wire coutfinal;
    assign muxout = ALUControl[0] ? ~B : B;
    fa32 inst1 (.A(A),.B(muxout),.Cin(ALUControl[0]),.S(sumtemp),.Cout(coutfinal));
    always @(*) begin
        case(ALUControl)
            3'b000 : Result = sumtemp;
            3'b001 : Result = sumtemp;
            3'b010 : Result = A&B;
            3'b011 : Result = A|B;
            3'b101 : Result = {{31{1'b0}},sumtemp[31]^V};
            default : Result = sumtemp;
        endcase
    end
    assign Z =(Result == 32'd0);
    assign N = Result[31];
    assign C = coutfinal & ~ALUControl[1];
    assign V = ~(A[31]^B[31]^ALUControl[0])&(A[31]^sumtemp[31])&~ALUControl[1];
endmodule