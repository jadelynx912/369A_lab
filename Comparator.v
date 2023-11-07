`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2023 12:53:58 PM
// Design Name: 
// Module Name: Comparator
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

module Comparator(Instruction, A, B, Branch, Output);
    input signed [31:0] A, B;
    input [31:0] Instruction;
    output reg Branch, Output;
    
    always@(*) begin
        Branch <= 0;
        Output <= 0;
        case(Instruction[31:26])
        6'b000101: begin            //bne
            Branch <= 1;
            if (A != B) Output <= 1;
        end
        6'b000100: begin            //beq
            Branch <= 1;
            if (A == B) Output <= 1;
        end
        6'b000001: begin            //bgez, bltz
            Branch <= 1;
            case(Instruction[20:16])            //Uses rt as an extension of the opcode
                5'b00001: begin                 //bgez
                    if (A >= 0) Output <= 1;
                end
                5'b00000: begin                 //bltz
                    if (A < 0) Output <= 1;
                end
            endcase
        end
        6'b000111: begin            //bgtz
            Branch <= 1;
            if (A > 0) Output <= 1;
        end
        6'b000110: begin            //blez
            Branch <= 1;
            if (A <= 0) Output <= 1;
        end
        endcase
    end
endmodule