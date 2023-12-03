`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2023 
// Design Name: 
// Module Name: Forwarding.v
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
////////////////////////////////////////////////////////////////////////////////

module Forwarding(A, B, MemRegWrite, MemWriteReg, WBRegWrite, WBWriteReg, EX_rs, EX_rt);
    output reg [1:0] A, B;
    input MemRegWrite, WBRegWrite;
    input [4:0] MemWriteReg, WBWriteReg, EX_rs, EX_rt;

    always @ (*) begin
        A <= 0;
        B <= 0;
        if (MemRegWrite && MemWriteReg != 0 && MemWriteReg == EX_rs) begin
            A <= 2'd1;
        end 
        else if (WBRegWrite && WBWriteReg != 0 && WBWriteReg == EX_rs) begin
            A <= 2'd2;
        end
        else begin
            A <= 2'd0;
        end

        if (MemRegWrite && MemWriteReg != 0 && MemWriteReg == EX_rt) begin
            B <= 2'd1;
        end 
        else if (WBRegWrite && WBWriteReg != 0 && WBWriteReg == EX_rt) begin
            B <= 2'd2;
        end
        else begin
            B <= 2'd0;
        end
    end
    
endmodule