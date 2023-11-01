`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2023 03:47:21 PM
// Design Name: 
// Module Name: InstructionFetchUnit_tb
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


module InstructionFetchUnit_tb();
    reg Reset, Clk;
    wire [31:0] Instruction;
    wire [31:0] PCResult;
    
    InstructionFetchUnit u0(
        .Reset(Reset),
        .Clk(Clk),
        .Instruction(Instruction),
        .PCResult(PCResult)
    );
    
    always begin
        Clk <= 0;
        #10;
        Clk <= 1;
        #10;
    end
    
    initial begin
        Reset <= 1;
        #50 Reset <= 0;
    end

endmodule
