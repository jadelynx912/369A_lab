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


module DataMem_To_WriteBack();


input clk;

input [31:0]PCAddResult, instruction;

output reg[31:0] PCAddResultOut, instructionOut;

always @(posedge clk) begin
    PCAddResultOut <= PCAddResult;
    instructionOut <= instruction;
end


endmodule
