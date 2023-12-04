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


module Execute_To_DataMem(Clk, Reset, RegWrite, MemWrite, MemRead, MemToReg, RData2, ALUResult, PCAddResult, RdReg, 
RegWriteOut, MemWriteOut, MemReadOut, MemToRegOut, RData2Out, ALUResultOut, PCAddResultOut, RdRegOut);
//Clk, Reset, RegWriteExecute, MemWriteExecute, MemReadExecute, BranchExecute, MemToRegExecute, JalExecute, ReadData2Execute, ALUResult, PCAddResultExecute, PCAdder_SignExtension, regDstOutput, 
//RegWriteMemory, MemWriteMemory, MemReadMemory, BranchMemory, MemToRegMemory, JalMemory, ReadData2Memory, ALUResultMemory, PCAddResultMemory, PCAdder_SignExtensionMemory, RdMemory);


input Clk, Reset;

input RegWrite, MemToReg;
input [1:0] MemWrite, MemRead;
input [31:0] RData2, ALUResult, PCAddResult;
input [4:0] RdReg;

output reg RegWriteOut, MemToRegOut;
output reg [1:0] MemWriteOut, MemReadOut;
output reg [31:0] RData2Out, ALUResultOut, PCAddResultOut;
output reg [4:0] RdRegOut;


always @(posedge Clk) begin
    RegWriteOut <= RegWrite;
    MemWriteOut <= MemWrite;
    MemReadOut <= MemRead;
    MemToRegOut <= MemToReg;
    RData2Out <= RData2;
    ALUResultOut <= ALUResult;
    PCAddResultOut <= PCAddResult;
    RdRegOut <= RdReg;

end


endmodule
