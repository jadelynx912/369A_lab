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


module Decode_To_Execute(Clk, Reset, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, MemToReg, Jr, Jal, ALUControl, PCAddResult, ReadData1, ReadData2, SignExt, RegDst1, RegDst2, 
RegWriteOut, ALUSrcOut, RegDstOut, MemWriteOut, MemReadOut, MemToRegOut, JrOut, JalOut, ALUControlOut, PCAddResultOut, ReadData1Out, ReadData2Out, SignExtOut, RegDst1Out, RegDst2Out);
//Clk, Reset, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, MemToReg, Jr, Jal, ALUControl, PCAddResultDecode, ReadData1, ReadData2, signExtend, instructionDecode[20:16], instructionDecode[15:11],
//RegWriteExecute, ALUSrcExecute, RegDstExecute, MemWriteExecute, MemReadExecute, MemToRegExecute, JrExecute, JalExecute, ALUControlExecute, PCAddResultExecute, ReadData1Execute, ReadData2Execute, SignExtExecute, RegDst1Execute, RegDst2Execute);

input Clk, Reset;

input RegWrite, ALUSrc, RegDst, MemToReg, Jr, Jal;
input [1:0] MemWrite, MemRead;
input [4:0] ALUControl, RegDst1, RegDst2;
input [31:0] PCAddResult, ReadData1, ReadData2, SignExt;

output reg [31:0] PCAddResultOut, ReadData1Out, ReadData2Out, SignExtOut;
output reg [4:0] ALUControlOut, RegDst1Out, RegDst2Out;
output reg RegWriteOut, ALUSrcOut, RegDstOut, MemToRegOut, JrOut, JalOut;
output reg [1:0] MemWriteOut, MemReadOut;

always @(posedge Clk) begin
    RegWriteOut <= RegWrite;
    ALUSrcOut <= ALUSrc;
    RegDstOut <= RegDst;
    MemWriteOut <= MemWrite;
    MemReadOut <= MemRead;
    MemToRegOut <= MemToReg;
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
