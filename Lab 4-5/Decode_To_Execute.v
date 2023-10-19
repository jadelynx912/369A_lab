`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2023 12:53:58 PM
// Design Name: 
// Module Name: Decode_To_Execute
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


module Decode_To_Execute(Clk, Reset, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, Jr, Jal, ALUControl, PCAddResult, ReadData1, ReadData2, SignExt, RegDst1, RegDst2, 
PCAddResultOut, ReadData1Out, ReadData2Out, SignExtOut, RegDst1Out, RegDst2Out, RegWriteOut, ALUSrcOut, RegDstOut, MemWriteOut, MemReadOut, BranchOut, MemToRegOut, JumpOut, JrOut, JalOut, ALUControlOut);
//Clk, Reset, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, Jr, Jal, ALUControl, PCAddResultDecode, ReadData1, ReadData2, signExtend, instructionDecode[20:16], instructionDecode[15:11],
//PCAddResultExecute, ReadData1Execute, ReadData2Execute, SignExtExecute, RegDst1Execute, RegDst2Execute,RegWriteExecute, ALUSrcExecute, RegDstExecute, MemWriteExecute, MemReadExecute, BranchExecute, MemToRegExecute, JumpExecute, JrExecute, JalExecute, ALUControlExecute);

input Clk, Reset;

input RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, Jr, Jal;
input [4:0] ALUControl, RegDst1, RegDst2;
input [31:0] PCAddResult, ReadData1, ReadData2, SignExt;

output reg [31:0] PCAddResultOut, ReadData1Out, ReadData2Out, SignExtOut;
output reg [4:0] ALUControlOut, RegDst1Out, RegDst2Out;
output reg RegWriteOut, ALUSrcOut, RegDstOut, MemWriteOut, MemReadOut, BranchOut, MemToRegOut, JumpOut, JrOut, JalOut;

always @(posedge Clk) begin
    RegWriteOut <= RegWrite;
    ALUSrcOut <= ALUSrc;
    RegDstOut <= RegDst;
    MemWriteOut <= MemWrite;
    MemReadOut <= MemRead;
    BranchOut <= Branch;
    MemToRegOut <= MemToReg;
    JumpOut <= Jump;
    JrOut <= Jr;
    JalOut <= Jal;
    ALUControlOut <= ALUControl;
    RegDst1Out <= RegDst1;
    RegDst2Out <= RegDst2;
    PCAddResultOut <= PCAddResult;
    ReadData1Out <= ReadData1;
    ReadData2Out <= ReadData2;
    SignExtOut <= SignExt;
end


endmodule
