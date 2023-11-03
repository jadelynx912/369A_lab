`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2023 01:16:22 PM
// Design Name: 
// Module Name: HazardDetection_tb
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


module HazardDetection_tb();
    reg Clk;
    
    reg [31:0] instruction;
    //input [4:0] rtExecution, rdExecution, rtMemory, rdMemory;
    reg [4:0] rdExecution, rdMemory;
    reg regWriteExecution, regWriteMemory;
   // input [1:0] MemReadExecution, MemReadMemory;
    wire DecodeRegWrite, PCWrite, MuxControl;
        
    HazardDetection hz(instruction, rdExecution, rdMemory, DecodeRegWrite, PCWrite, MuxControl, regWriteExecution, regWriteMemory);
    
    always 
    begin
        Clk <= 0;
        #10;
        Clk <= 1;
        #10;
    end
    
    initial
    begin
        instruction <= 32'h00000000;
        rdExecution <= 5'b00000; rdMemory <= 5'b00000; //false
        regWriteExecution <= 0; regWriteMemory <= 0;         
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        regWriteExecution <= 1; regWriteMemory <= 1;  //true
        rdExecution <= 5'b01000; rdMemory <= 5'b00000;           
        instruction <= 32'h01095020;
        @ (posedge Clk);
        @ (posedge Clk);
        regWriteExecution <= 1; regWriteMemory <= 1;   //true
        rdExecution <= 5'b00000; rdMemory <= 5'b01000;           
        instruction <= 32'h01095020;
        @ (posedge Clk);
        @ (posedge Clk);
        regWriteExecution <= 1; regWriteMemory <= 0;  //false
        rdExecution <= 5'b00000; rdMemory <= 5'b01000;           
        instruction <= 32'h01095020;
        @ (posedge Clk);
        @ (posedge Clk);
        regWriteExecution <= 1; regWriteMemory <= 0;  //true
        rdExecution <= 5'b01000; rdMemory <= 5'b01000;           
        instruction <= 32'h01095020;
        @ (posedge Clk);
        @ (posedge Clk);
        regWriteExecution <= 0; regWriteMemory <= 0;  //false
        rdExecution <= 5'b01000; rdMemory <= 5'b01000;           
        instruction <= 32'h01095020;
        @ (posedge Clk);
        @ (posedge Clk);
        
        regWriteExecution <= 1; regWriteMemory <= 0;  //false
        rdExecution <= 5'b00000; rdMemory <= 5'b01000;           
        instruction <= 32'h01095020;
        @ (posedge Clk);
        @ (posedge Clk);


    end
    
endmodule
