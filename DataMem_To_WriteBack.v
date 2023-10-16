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


module DataMem_To_WriteBack(Clk, Reset, PCAddResult, MemReadData, ALUResult, RegRd, 
			PCAddResultOut, MemReadDataOut, ALUResultOut, RegRdOut);

input Clk, Reset;
input [31:0] PCAddResult, MemReadData, ALUResult, RegRd;

output reg PCAddResultOut, MemReadDataOut, ALUResultOut, RegRdOut;

always @(posedge Clk) begin
    PCAddResultOut <= PCAddResult;
    MemReadDataOut <= MemReadData;
    ALUResultOut <= ALUResult;
    RegRdOut <= RegRd;

end
endmodule
