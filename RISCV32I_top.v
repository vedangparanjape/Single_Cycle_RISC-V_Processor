module RISCV32I_top(
    input clk, rstn);
    
    // Intermediate wire declarations
    wire [31:0] PC, PCNext, PCPlus4, ReadData, ImmExt, PCTarget, Instr, Result, SrcA, SrcB, WriteData, ALUResult;
    wire PCaddcout, PCtargetcout, Zero, PCSrc, ResultSrc, MemWrite, ALUSrc, RegWrite,N,C,V;
    wire [2:0] ALUControl;
    wire [1:0] ImmSrc;
    
    // Control Unit
    ControlUnit Inst5 (.op(Instr[6:0]),.funct3(Instr[14:12]), .funct75(Instr[30]),.zero(Zero), .ResultSrc(ResultSrc),
     .MemWrite(MemWrite), .ALUSrc(ALUSrc),
     .RegWrite(RegWrite), .PCSrc(PCSrc), .ImmSrc(ImmSrc), .ALUControl(ALUControl));
    
    // PC
    fa32 inst15 (.A(PC),.B(32'd4),.Cin(1'b0),.S(PCPlus4),.Cout(PCaddcout));
    assign PCNext = PCSrc ? PCTarget: PCPlus4;
    PC Inst6 (.clk(clk), .rstn(rstn), .PCNext(PCNext), .PC(PC));
    
    // Instruction Memory
    InstructionMemory Inst7 (.A(PC), .RD(Instr));
    
    // Register File
    RegisterFile Inst8 (.A1(Instr[19:15]), .A2(Instr[24:20]), .A3(Instr[11:7]), .clk(clk),
     .WE3(RegWrite), .WD3(Result), .RD1(SrcA), .RD2(WriteData));
    
    // Extend Block
    Extend Inst9 (.ImmSrc(ImmSrc), .Instr(Instr[31:7]), .ImmExtend(ImmExt));
    
    // PC Target adder
    fa32 inst3 (.A(PC),.B(ImmExt),.Cin(1'b0),.S(PCTarget),.Cout(PCtargetcout));
    
    
    // ALU
    ALU Inst10 (.A(SrcA), .B(SrcB), .ALUControl(ALUControl), .Result(ALUResult), .Z(Zero), .N(N), .C(C), .V(V));
    
    //ALU SrcB Multiplexar
    assign SrcB = ALUSrc ? ImmExt : WriteData;
    
    // Data Memory
    DataMemory Inst11 (.A(ALUResult), .WD(WriteData), .WE(MemWrite), .clk(clk), .RD(ReadData));
    
    // ReadData Multiplexar
    assign Result = ResultSrc ? ReadData : ALUResult;
endmodule