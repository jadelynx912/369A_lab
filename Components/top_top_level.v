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
// Percent Effort: Kari Cordes - 33%, William Rains - 33%, Samantha Perry - 33%
// 
//////////////////////////////////////////////////////////////////////////////////

module top_top_level(Clk, Reset, out7, en_out);
// 
    input Clk, Reset;
    output [6:0] out7;
    output [7:0] en_out;
    
    wire [31:0] xCoord;
    wire [31:0] yCoord;
    
    top_level datapath(Clk, Reset, xCoord, yCoord);
    Two4DigitDisplay tdd1(Clk, yCoord[15:0], xCoord[15:0], out7, en_out);

endmodule