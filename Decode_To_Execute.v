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


module Decode_To_Execute(clk, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, ALUControl, PCAddResult, ReadData1, ReadData2, SignExt, RegDst1, RegDst2, 
PCAddResultOut, ReadData1Out, ReadData2Out, SignExtOut,RegDst1Out, RegDst2Out,RegWriteOut, ALUSrcOut, RegDstOut, MemWriteOut, MemReadOut, BranchOut, MemToRegOut, JumpOut, ALUControlOut);


input clk;

input RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, ALUControl;


input [31:0] PCAddResult, ReadData1, ReadData2, SignExt;
input [4:0] RegDst1, RegDst2;

output reg [31:0] PCAddResultOut, ReadData1Out, ReadData2Out, SignExtOut;
output reg [4:0] RegDst1Out, RegDst2Out;
output reg RegWriteOut, ALUSrcOut, RegDstOut, MemWriteOut, MemReadOut, BranchOut, MemToRegOut, JumpOut, ALUControlOut;

// MISSING PCSRC

always @(posedge clk) begin
    PCAddResultOut <= PCAddResult;
    instructionOut <= instruction;
end


endmodule
