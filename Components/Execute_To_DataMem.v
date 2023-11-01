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


module Execute_To_DataMem(Clk, Reset, RegWrite, MemWrite, MemRead, Branch, MemToReg, Jal, Zero, RData2, ALUResult, PCAddResult, BranchPC, RdReg, 
RegWriteOut, MemWriteOut, MemReadOut, BranchOut, MemToRegOut, JalOut, ZeroOut, RData2Out, ALUResultOut, PCAddResultOut, BranchPCOut, RdRegOut);
//Clk, Reset, RegWriteExecute, MemWriteExecute, MemReadExecute, BranchExecute, MemToRegExecute, JalExecute, Zero, ReadData2Execute, ALUResult, PCAddResultExecute, PCAdder_SignExtension, regDstOutput, 
//RegWriteMemory, MemWriteMemory, MemReadMemory, BranchMemory, MemToRegMemory, JalMemory, ZeroMemory, ReadData2Memory, ALUResultMemory, PCAddResultMemory, PCAdder_SignExtensionMemory, RdMemory);


input Clk, Reset;

input RegWrite, Branch, MemToReg, Jal, Zero;
input [1:0] MemWrite, MemRead;
input [31:0] RData2, ALUResult, PCAddResult, BranchPC;
input [4:0] RdReg;

output reg RegWriteOut, BranchOut, MemToRegOut, JalOut, ZeroOut;
output reg [1:0] MemWriteOut, MemReadOut;
output reg [31:0] RData2Out, ALUResultOut, PCAddResultOut, BranchPCOut;
output reg [4:0] RdRegOut;


always @(posedge Clk) begin
    RegWriteOut <= RegWrite;
    MemWriteOut <= MemWrite;
    MemReadOut <= MemRead;
    BranchOut <= Branch;
    MemToRegOut <= MemToReg;
    JalOut <= Jal;
    ZeroOut <= Zero;
    RData2Out <= RData2;
    ALUResultOut <= ALUResult;
    PCAddResultOut <= PCAddResult;
    BranchPCOut <= BranchPC;
    RdRegOut <= RdReg;

end


endmodule
