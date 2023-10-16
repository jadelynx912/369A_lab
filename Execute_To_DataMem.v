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


module Execute_To_DataMem(clk, Zero, RegWrite, MemWrite, MemRead, Branch, MemToReg, Jump, PCAdder_SignExtension, ALUResult, ReadData2, Rd, 
RegWriteOut, MemWriteOut, MemReadOut, BranchOut, MemToRegOut, JumpOut, PCAdder_SignExtensionOut, ALUResultOut, ReadData2Out, RdOut, ZeroOut);


input clk, Zero;

input RegWrite, MemWrite, MemRead, Branch, MemToReg, Jump;
input [31:0] PCAdder_SignExtension, ALUResult, ReadData2, Rd;

output reg RegWriteOut, MemWriteOut, MemReadOut, BranchOut, MemToRegOut, JumpOut;
output reg [31:0] PCAdder_SignExtensionOut, ALUResultOut, ReadData2Out, RdOut;
output reg ZeroOut;


always @(posedge clk) begin
    PCAddResultOut <= PCAddResult;
    instructionOut <= instruction;
end


endmodule
