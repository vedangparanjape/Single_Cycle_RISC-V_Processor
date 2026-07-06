module DataMemory(
    input [31:0] A, 
    input [31:0] WD,
    input WE, clk,
    output wire [31:0] RD);
    reg [31:0] dmem [31:0];
    integer i;
    initial begin
        dmem[1] = 10;
        for (i = 0;i <32;i = i+1)begin
            if (i!=1) dmem[i] = 32'h0;
        end
    end
    assign RD = dmem[A[6:2]];
    always @(posedge clk) begin
        if (WE) dmem[A[6:2]] <= WD;
    end
endmodule