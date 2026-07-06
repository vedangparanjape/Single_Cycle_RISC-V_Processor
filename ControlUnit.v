module ControlUnit(
    input [6:0] op,
    input [2:0] funct3,
    input funct75,
    input zero,
    output reg ResultSrc, MemWrite, ALUSrc, RegWrite,
    output PCSrc,
    output reg [1:0] ImmSrc,
    output reg [2:0] ALUControl);
    
    reg [1:0] ALUOp;
    reg Branch;
    // Main Decoder
    always @(*) begin
        case(op)
            7'b0000011 : begin
                RegWrite = 1;
                ImmSrc = 2'b00;
                ALUSrc = 1;
                MemWrite = 0;
                ResultSrc = 1;
                Branch = 0;
                ALUOp = 2'b00;
            end
            7'b0100011 : begin
                RegWrite = 0;
                ImmSrc = 2'b01;
                ALUSrc = 1;
                MemWrite = 1;
                ResultSrc = 0;
                Branch = 0;
                ALUOp = 2'b00;
            end
            7'b0110011 : begin
                RegWrite = 1;
                ImmSrc = 2'b00;
                ALUSrc = 0;
                MemWrite = 0;
                ResultSrc = 0;
                Branch = 0;
                ALUOp = 2'b10;
            end
            7'b1100011 : begin
                RegWrite = 0;
                ImmSrc = 2'b10;
                ALUSrc = 0;
                MemWrite = 0;
                ResultSrc = 0;
                Branch = 1;
                ALUOp = 2'b01;
            end
            default : begin
                RegWrite = 0;
                ImmSrc = 2'b00;
                ALUSrc = 0;
                MemWrite = 0;
                ResultSrc = 0;
                Branch = 0;
                ALUOp = 2'b00;
            end
        endcase
    end
    
    //ALU Decoder
    always @(*)begin
        casez ({ALUOp,funct3,op[5],funct75})
            7'b00????? : ALUControl = 3'b000;
            7'b01????? : ALUControl = 3'b001;
            7'b1000000 : ALUControl = 3'b000;
            7'b1000001 : ALUControl = 3'b000;
            7'b1000010 : ALUControl = 3'b000;
            7'b1000011 : ALUControl = 3'b001;
            7'b10010?? : ALUControl = 3'b101;
            7'b10110?? : ALUControl = 3'b011;
            7'b10111?? : ALUControl = 3'b010;
            default : ALUControl = 3'b000;
        endcase
    end
    assign PCSrc = Branch&zero;
endmodule