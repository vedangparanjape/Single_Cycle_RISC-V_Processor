module RegisterFile(
    input [4:0] A1, A2, A3,
    input clk, WE3,
    input [31:0] WD3,
    output reg [31:0] RD1, RD2);
    reg [31:0] regset [31:0];
    integer i,j;
    initial begin
        for (j = 1; j <32;j = j+1)
            if ((j!=0)&(j!=5)&(j!=9))
                regset[j] <= 32'h0;
        regset[5] = 32'd6;
        regset[9] = 32'd8;
        regset[0] = 32'b0;
    end
    always @(*) begin
        RD1 = (A1 == 5'b0) ? 32'h0 : regset[A1];
        RD2 = (A2 == 5'b0) ? 32'h0 : regset[A2];
    end         
    always @(posedge clk) begin 
            if (A3)begin
                if (WE3) regset[A3] <= WD3;
            end
    end
endmodule