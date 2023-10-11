`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2023 02:49:22 PM
// Design Name: 
// Module Name: ALUController
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
module Controller(Instruction, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, ALUControl);
    input [31:0] Instruction;
    output reg RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump;
    output reg ALUControl[4:0];
    
    always @ (Instruction) begin
        case(Instruction[31:26])
        6'b000000: begin        //R-type instructions
            RegWrite <= 1;
            ALUSrc <= 0;
            RegDst <= 1;
            MemWrite <= 0;
            MemRead <= 0;
            Branch <= 0;
            MemToReg <= 1;
            Jump <= 0;
            //To get ALU control value for each instruction
            case(Instruction[5:0])
                6'b100000: ALUControl <= 5'b00001;      //add
                6'b100010: ALUControl <= 5'b00010;      //sub
                6'b011000: ALUControl <= 5'b00011;      //mult
                6'b000000: ALUControl <= 5'b00100;      //sll
                6'b000010: ALUControl <= 5'b00101;      //srl
                6'b100100: ALUControl <= 5'b00110;      //and
                6'b100101: ALUControl <= 5'b00111;      //or
                6'b100110: ALUControl <= 5'b01000;      //xor
                6'b100111: ALUControl <= 5'b01101;      //nor
                6'b101010: ALUControl <= 5'b01110;      //slt
            endcase
        end
        6'b100011 || 6'b100000 || 6'b100001: begin        //lw, lb, lh
            RegWrite <= 1;
            ALUSrc <= 1;
            RegDst <= 0;
            MemWrite <= 0;
            MemRead <= 1;
            Branch <= 0;
            MemToReg <= 0;
            Jump <= 0;
            ALUControl <= 5'b00001;      //add to get address
        end
        6'b101011 || 6'b101000 || 6'b101001: begin      //sw, sb, sh
            RegWrite <= 0;
            ALUSrc <= 1;
            RegDst <= 1'bx;
            MemWrite <= 1; 
            MemRead <= 0;
            Branch <= 0;
            MemToReg <= 1'bx;
            Jump <= 0;
            ALUControl <= 5'b00001;     //add to get address
        end
        6'b001100: begin            //andi
            ALUSrc <= 1;
            RegDst <= 0;
            MemWrite <= 0; 
            MemRead <= 0;
            Branch <= 0;
            MemToReg <= 1;
            Jump <= 0;
            ALUControl <= 5'b00110;
        end 
        6'b001101: begin            //ori
            ALUSrc <= 1;
            RegDst <= 0;
            MemWrite <= 0; 
            MemRead <= 0;
            Branch <= 0;
            MemToReg <= 1;
            Jump <= 0;
            ALUControl <= 5'b00110;
        end
        6'b001110: begin            //xori
          
            
        
        
                
            
            
        
endmodule
