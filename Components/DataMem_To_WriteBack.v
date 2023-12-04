`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2023 12:53:58 PM
// Design Name: 
// Module Name: DataMem_To_WriteBack
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


module DataMem_To_WriteBack(Clk, Reset, MemReadData, ALUResult, RegRd, RegWrite, MemToReg,
			MemReadDataOut, ALUResultOut, RegRdOut, RegWriteOut, MemToRegOut);
//Clk, Reset, PCAddResultMemory, ReadData, ALUResultMemory, RdMemory, RegWriteMemory, MemToRegMemory, JalMemory,
//PCAddResultWrite, MemReadDataWrite, ALUResultWrite, RegRdWrite, RegWriteWrite, MemToRegWrite, JalWrite); 

input Clk, Reset;
input [31:0] MemReadData, ALUResult;
input [4:0] RegRd;
input RegWrite, MemToReg;

output reg [31:0] MemReadDataOut, ALUResultOut;
output reg [4:0] RegRdOut;
output reg RegWriteOut, MemToRegOut;

always @(posedge Clk) begin
    MemReadDataOut <= MemReadData;
    ALUResultOut <= ALUResult;
    RegRdOut <= RegRd;
    RegWriteOut <= RegWrite;
    MemToRegOut <= MemToReg; 
    
end
endmodule
