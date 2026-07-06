module PC(
    input clk,rstn,
    input [31:0] PCNext,
    output reg [31:0] PC);
    always @(posedge clk) begin
        if(~rstn)
            PC <= 32'h1000;
        else
            PC <= PCNext;
    end
endmodule