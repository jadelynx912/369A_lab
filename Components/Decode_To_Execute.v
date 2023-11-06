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


module Decode_To_Execute(Clk, Reset, DecodeRegWrite, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, MemToReg, Jr, Jal, ALUControl, PCAddResult, ReadData1, ReadData2, SignExt, 
RegWriteOut, ALUSrcOut, RegDstOut, MemWriteOut, MemReadOut, MemToRegOut, JrOut, JalOut, ALUControlOut, PCAddResultOut, ReadData1Out, ReadData2Out, SignExtOut);

input Clk, Reset, DecodeRegWrite;

input RegWrite, ALUSrc, RegDst, MemToReg, Jr, Jal;
input [1:0] MemWrite, MemRead;
input [4:0] ALUControl;
input [31:0] PCAddResult, ReadData1, ReadData2, SignExt;

output reg [31:0] PCAddResultOut, ReadData1Out, ReadData2Out, SignExtOut;
output reg [4:0] ALUControlOut;
output reg RegWriteOut, ALUSrcOut, RegDstOut, MemToRegOut, JrOut, JalOut;
output reg [1:0] MemWriteOut, MemReadOut;

always @(posedge Clk) begin
    if (DecodeRegWrite)begin //Stall, might be dne incrorectly
        RegWriteOut <= RegWriteOut;
        ALUSrcOut <= ALUSrcOut;
        RegDstOut <= RegDstOut;
        MemWriteOut <= MemWriteOut;
        MemReadOut <= MemReadOut;
        MemToRegOut <= MemToRegOut;
        JrOut <= JrOut;
        JalOut <= JalOut;
        ALUControlOut <= ALUControlOut;
        PCAddResultOut <= PCAddResultOut;
        ReadData1Out <= ReadData1Out;
        ReadData2Out <= ReadData2Out;
        SignExtOut <= SignExtOut;
        end
    else begin
        RegWriteOut <= RegWrite;
        ALUSrcOut <= ALUSrc;
        RegDstOut <= RegDst;
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
        end
end


endmodule
