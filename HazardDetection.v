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

module HazardDetection(rs, rt, rtExecution, MemReadExecution, DecodeRegWrite, PCWrite, MuxControl);
    input [4:0] rs, rt, rtExecution;
    input MemReadExecution;
    output reg DecodeRegWrite, PCWrite, MuxControl;
    
    if (MemReadExecution == 1 & ((rt == rtExecution) | (rs == rtExecution))) begin
        PCWrite <= 0;
        DecodeRegWrite <= 0;
        MuxControl <= 1;
    end
    else begin
        PCWrite <= 1;
        DecodeRegWrite <= 0;
        MuxControl <= 0;
    end

endmodule