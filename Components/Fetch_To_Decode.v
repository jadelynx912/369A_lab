`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2023 12:53:58 PM
// Design Name: 
// Module Name: Fetch_to_Decode
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


module Fetch_To_Decode(PCAddResult, Instruction, PCAddResultOut, InstructionOut, Clk, Reset);
//Fetch_To_Decode ftd(PCAddResult, instruction,  PCAddResultDecode, instructionDecode, Clk, Reset);


input Clk, Reset;
input [31:0]PCAddResult, Instruction;

output reg[31:0] PCAddResultOut, InstructionOut;

always @(posedge Clk) begin
    PCAddResultOut <= PCAddResult;
    InstructionOut <= Instruction;
end

endmodule
