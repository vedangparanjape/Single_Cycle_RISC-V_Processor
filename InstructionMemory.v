module InstructionMemory(
    input [31:0] A,
    output reg [31:0] RD);
    always @(*) begin
        case(A)
            32'h1000 : RD = 32'hFFC4A303;
            32'h1004 : RD = 32'h0064A423;
            32'h1008 : RD = 32'h0062E233;
            32'h100C : RD = 32'hFE420AE3;
            default  : RD = 32'h00000000;
        endcase
    end
endmodule