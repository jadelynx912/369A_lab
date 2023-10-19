`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2023 11:55:09 AM
// Design Name: 
// Module Name: top_level_tb
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


module top_level_tb();
    reg Clk, Rst;
    
    wire [31:0] WData, PCResult;
    
    top_level tl(Clk, Rst, PCResult, WData);
    
    always 
    begin
        Clk <= 0;
        #10;
        Clk <= 1;
        #10;
    end
    
    initial
    begin
        Rst <= 1'b1;
        @ (posedge Clk);
        #50 Rst <= 1'b0; 
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        
    end
endmodule
