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


module Decode_To_Execute(Clk, Reset, RSDecode, RTDecode, RegWrite, ALUSrc, MemWrite, MemRead, MemToReg, ALUControl, ReadData1, ReadData2, SignExt, DestReg, 
                     RSExecute, RTExecute, RegWriteOut, ALUSrcOut, MemWriteOut, MemReadOut, MemToRegOut, ALUControlOut, ReadData1Out, ReadData2Out, SignExtOut, DestRegOut);
//Decode_To_Execute dte (Clk, Reset, RegWrite, ALUSrc, MemWrite, MemRead, MemToReg, Jal, ALUControl, PCAddResultDecode, ShiftSwitchWire, ReadData2, signExtend, regDstOutput,
//  RegWriteExecute, ALUSrcExecute, MemWriteExecute, MemReadExecute, MemToRegExecute, JalExecute, ALUControlExecute, PCAddResultExecute, ReadData1Execute, ReadData2Execute, SignExtExecute, regDstExecute);

input Clk, Reset;

input [4:0] RSDecode, RTDecode;

input RegWrite, ALUSrc, MemToReg;
input [1:0] MemWrite, MemRead;
input [4:0] ALUControl, DestReg;
input [31:0]  ReadData1, ReadData2, SignExt;

output reg [4:0] RSExecute, RTExecute;

output reg RegWriteOut, ALUSrcOut, MemToRegOut;
output reg [1:0] MemWriteOut, MemReadOut;
output reg [4:0] ALUControlOut, DestRegOut;
output reg [31:0]  ReadData1Out, ReadData2Out, SignExtOut;


always @(posedge Clk) begin
    RegWriteOut <= RegWrite;
    ALUSrcOut <= ALUSrc;
    MemWriteOut <= MemWrite;
    MemReadOut <= MemRead;
    MemToRegOut <= MemToReg;
    ALUControlOut <= ALUControl;
    ReadData1Out <= ReadData1;
    ReadData2Out <= ReadData2;
    SignExtOut <= SignExt;
    DestRegOut <= DestReg;
    RSExecute <= RSDecode;
    RTExecute <= RTDecode;
end

endmodule
