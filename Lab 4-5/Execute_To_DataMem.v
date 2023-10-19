`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2023 12:53:58 PM
// Design Name: 
// Module Name: Execute_To_DataMem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Execute_To_DataMem(Clk, Reset, RegWrite, MemWrite, MemRead, Branch, MemToReg, Jump, Jr, Jal, Zero, RData1, RData2, ALUResult, PCAddResult, BranchPC, RdReg, 
RegWriteOut, MemWriteOut, MemReadOut, BranchOut, MemToRegOut, JumpOut, JrOut, JalOut, ZeroOut, RData1Out, RData2Out, ALUResultOut, PCAddResultOut, BranchPCOut, RdRegOut);
//Clk, Reset, RegWriteExecute, MemWriteExecute, MemReadExecute, BranchExecute, MemToRegExecute, JumpExecute, JrExecute, JalExecute, Zero, ReadData1Execute, ReadData2Execute, ALUResult, PCAddResultExecute, PCAdder_SignExtension, regDstOutput, 
//RegWriteMemory, MemWriteMemory, MemReadMemory, BranchMemory, MemToRegMemory, JumpMemory, JrMemory, JalMemory, ZeroMemory, ReadData1Memory, ReadData2Memory, ALUResultMemory, PCAddResultMemory, PCAdder_SignExtensionMemory, RdMemory);


input Clk, Reset;

input RegWrite, MemWrite, MemRead, Branch, MemToReg, Jump, Jr, Jal, Zero;
input [31:0] RData1, RData2, ALUResult, PCAddResult, BranchPC;
input [4:0] RdReg;

output reg RegWriteOut, MemWriteOut, MemReadOut, BranchOut, MemToRegOut, JumpOut, JrOut, JalOut, ZeroOut;
output reg [31:0] RData1Out, RData2Out, ALUResultOut, PCAddResultOut, BranchPCOut;
output reg [4:0] RdRegOut;


always @(posedge Clk) begin
    RegWriteOut <= RegWrite;
    MemWriteOut <= MemWrite;
    MemReadOut <= MemRead;
    BranchOut <= Branch;
    MemToRegOut <= MemToReg;
    JumpOut <= Jump;
    JrOut <= Jr;
    JalOut <= Jal;
    ZeroOut <= Zero;
    RData1Out <= RData1;
    RData2Out <= RData2;
    ALUResultOut <= ALUResult;
    PCAddResultOut <= PCAddResult;
    BranchPCOut <= BranchPC;
    RdRegOut <= RdReg;

end


endmodule
