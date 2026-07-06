module Extend(
    input [1:0] ImmSrc,
    input [31:7] Instr,
    output reg [31:0] ImmExtend);
    always @(*)begin
        case(ImmSrc)
            2'b00 : ImmExtend = {{20{Instr[31]}},Instr[31:20]};
            2'b01 : ImmExtend = {{20{Instr[31]}},Instr[31:25],Instr[11:7]};
            2'b10 : ImmExtend = {{20{Instr[31]}},Instr[7],Instr[30:25],Instr[11:8],1'b0};
            default : ImmExtend = 32'h0;
        endcase
    end
endmodule