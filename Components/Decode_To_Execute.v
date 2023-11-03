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


module Decode_To_Execute(Clk, Reset, RegWrite, ALUSrc, MemWrite, MemRead, MemToReg, Jr, Jal, ALUControl, PCAddResult, ReadData1, ReadData2, SignExt, RegRd,
RegWriteOut, ALUSrcOut, MemWriteOut, MemReadOut, MemToRegOut, JrOut, JalOut, ALUControlOut, PCAddResultOut, ReadData1Out, ReadData2Out, SignExtOut, RegRdOut);
//Decode_To_Execute dte (Clk, Reset, RegWrite, ALUSrc, MemWrite, MemRead, MemToReg, Jr, Jal, ALUControl, PCAddResultDecode, ShiftSwitchWire, ReadData2, signExtend,
//RegWriteExecute, ALUSrcExecute, MemWriteExecute, MemReadExecute, MemToRegExecute, JrExecute, JalExecute, ALUControlExecute, PCAddResultExecute, ReadData1Execute, ReadData2Execute, SignExtExecute);

input Clk, Reset;

input RegWrite, ALUSrc, MemToReg, Jr, Jal;
input [1:0] MemWrite, MemRead;
input [4:0] ALUControl, RegRd;
input [31:0] PCAddResult, ReadData1, ReadData2, SignExt;

output reg [31:0] PCAddResultOut, ReadData1Out, ReadData2Out, SignExtOut;
output reg [4:0] ALUControlOut, RegRdOut;
output reg RegWriteOut, ALUSrcOut, MemToRegOut, JrOut, JalOut;
output reg [1:0] MemWriteOut, MemReadOut;

always @(posedge Clk) begin
    RegWriteOut <= RegWrite;
    ALUSrcOut <= ALUSrc;
    MemWriteOut <= MemWrite;
    MemReadOut <= MemRead;
    MemToRegOut <= MemToReg;
    JrOut <= Jr;
    JalOut <= Jal;
    ALUControlOut <= ALUControl;
    PCAddResultOut <= PCAddResult;
    ReadData1Out <= ReadData1;
    ReadData2Out <= ReadData2;
    SignExtOut <= SignExt;
    RegRdOut <= RegRd;
end


endmodule
