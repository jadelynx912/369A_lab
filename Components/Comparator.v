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
    output reg Output, Branch;
    
    always@(*) begin
        Output <= 0;
        Branch <= 0;
        case(Instruction[31:26])
        6'b000101: begin            //bne
            Branch <= 1;
            if (A != B) Output <= 1;
        end
//        6'b000100: begin            //beq
//            Branch <= 1;
//            if (A == B) Output <= 1;
//        end
        // 6'b000001: begin            //bgez, bltz
        //     case(Instruction[20:16])            //Uses rt as an extension of the opcode
        //         5'b00001: begin                 //bgez
        //             Branch <= 1;
        //             if (A >= 0) Output <= 1;
        //         end
        //         5'b00000: begin                 //bltz
        //             Branch <= 1;
        //             if (A < 0) Output <= 1;
        //         end
        //     endcase
        // end
        // 6'b000111: begin            //bgtz
        //     Branch <= 1;
        //     if (A > 0) Output <= 1;
        // end
        // 6'b000110: begin            //blez
        //     Branch <= 1;
        //     if (A <= 0) Output <= 1;
        // end
        6'b000000: begin
            case(Instruction[5:0])          //jr
                6'b001000: begin
                    Branch <= 1;
                    Output <= 1;
                end
            endcase
        end
        6'b000010: begin                    //j
            Branch <= 1;
            Output <= 1;
        end
        6'b000011: begin                    //jal
            Branch <= 1;
            Output <= 1;
        end
        endcase
    end
endmodule