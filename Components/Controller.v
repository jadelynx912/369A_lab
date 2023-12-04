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
module Controller(Instruction, BranchOutput, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, MemToReg, Jump, ALUControl, ShiftControl, PCSrc);
    input [31:0] Instruction;
    input BranchOutput;
    output reg RegWrite, ALUSrc, RegDst, MemToReg, Jump, ShiftControl, PCSrc;
    output reg [4:0] ALUControl;
    output reg [1:0] MemWrite, MemRead;
        
    initial begin
        RegWrite <= 0;
        ALUSrc <= 0;
        RegDst <= 0;
        MemWrite <= 2'b00;
        MemRead <= 2'b00;
        MemToReg <= 0;
        Jump <= 0;
        ALUControl <= 5'b11111;
        ShiftControl <= 0;
        PCSrc <= 0;
    end
    
    always @ (*) begin
        case(Instruction[31:26])
        6'b000000: begin        //R-type instructions
            RegWrite <= 1;
            ALUSrc <= 0;
            RegDst <= 1;
            MemWrite <= 2'b00;
            MemRead <= 2'b00;
            MemToReg <= 1;
            Jump <= 0;
            ShiftControl <= 0;
            PCSrc <= 0;
            //To get ALU control value for each instruction
            case(Instruction[5:0])
//                6'b001000: begin            //jr
//                    RegWrite <= 0;
//                    ALUSrc <= 0;
//                    RegDst <= 1'bx;
//                    MemWrite <= 2'b00;
//                    MemRead <= 2'b00;
//                    MemToReg <= 0;
//                    Jump <= 0;
//                    ALUControl <= 5'b11111;
//                    ShiftControl <= 0;
//                    PCSrc <= 0;
//                end
//                6'b000000: begin                        //sll
//                    ALUControl <= 5'b00100;
//                    ShiftControl <= 1;
//                end
//                6'b000010: begin                         //srl
//                    ALUControl <= 5'b00101;
//                    ShiftControl <= 1;
//                end
                6'b100000: ALUControl <= 5'b00001;      //add
                6'b100010: ALUControl <= 5'b00010;      //sub
//                6'b100100: ALUControl <= 5'b00110;      //and
//                6'b100101: ALUControl <= 5'b00111;      //or
//                6'b100110: ALUControl <= 5'b01000;      //xor
//                6'b100111: ALUControl <= 5'b01101;      //nor
                6'b101010: ALUControl <= 5'b01110;      //slt
            endcase
        end
        6'b011100: begin                                //mul
            RegWrite <= 1;
            ALUSrc <= 0;
            RegDst <= 1;
            MemWrite <= 2'b00;
            MemRead <= 2'b00;
            MemToReg <= 1;
            Jump <= 0;
            ALUControl <= 5'b00011;
            ShiftControl <= 0;
            PCSrc <= 0;
        end
        6'b100011: begin                                //lw
            RegWrite <= 1;
            ALUSrc <= 1;
            RegDst <= 0;
            MemWrite <= 2'b00;
            MemRead <= 2'b01;
            MemToReg <= 0;
            Jump <= 0;
            ALUControl <= 5'b00001;      //add to get address
            ShiftControl <= 0;
            PCSrc <= 0;
        end
//        6'b100000: begin                                //lb
//            RegWrite <= 1;
//            ALUSrc <= 1;
//            RegDst <= 0;
//            MemWrite <= 2'b00;
//            MemRead <= 2'b11;
//            MemToReg <= 0;
//            Jump <= 0;
//            Jr <= 0;
//            Jal <= 0;
//            ALUControl <= 5'b00001;      //add to get address
//            ShiftControl <= 0; 
//            PCSrc <= 0;
//        end
//        6'b100001: begin                                //lh
//            RegWrite <= 1;
//            ALUSrc <= 1;
//            RegDst <= 0;
//            MemWrite <= 2'b00;
//            MemRead <= 2'b10;
//            MemToReg <= 0;
//            Jump <= 0;
//            Jr <= 0;
//            Jal <= 0;
//            ALUControl <= 5'b00001;      //add to get address
//            ShiftControl <= 0;
//            PCSrc <= 0;
//        end      
//        6'b101011: begin                            //sw
//            RegWrite <= 0;
//            ALUSrc <= 1;
//            RegDst <= 1'bx;
//            MemWrite <= 2'b01;
//            MemRead <= 2'b00;
//            MemToReg <= 0;
//            Jump <= 0;
//            Jr <= 0;
//            Jal <= 0;
//            ALUControl <= 5'b00001;     //add to get address
//            ShiftControl <= 0;
//            PCSrc <= 0;
//        end
//        6'b101000: begin                            //sb
//            RegWrite <= 0;
//            ALUSrc <= 1;
//            RegDst <= 1'bx;
//            MemWrite <= 2'b11;
//            MemRead <= 2'b00;
//            MemToReg <= 0;
//            Jump <= 0;
//            Jr <= 0;
//            Jal <= 0;
//            ALUControl <= 5'b00001;     //add to get address
//            ShiftControl <= 0;
//            PCSrc <= 0;
//        end
//        6'b101001: begin                            //sh
//            RegWrite <= 0;
//            ALUSrc <= 1;
//            RegDst <= 1'bx;
//            MemWrite <= 2'b10;
//            MemRead <= 2'b00;
//            MemToReg <= 0;
//            Jump <= 0;
//            Jr <= 0;
//            Jal <= 0;
//            ALUControl <= 5'b00001;     //add to get address
//            ShiftControl <= 0;
//            PCSrc <= 0;
//        end
        6'b001000: begin            //addi
            RegWrite <= 1;
            ALUSrc <= 1;
            RegDst <= 0;
            MemWrite <= 2'b00;
            MemRead <= 2'b00;
            MemToReg <= 1;
            Jump <= 0;
            ALUControl <= 5'b00001;
            ShiftControl <= 0;
            PCSrc <= 0;
        end 
//        6'b001100: begin            //andi
//            RegWrite <= 1;
//            ALUSrc <= 1;
//            RegDst <= 0;
//            MemWrite <= 2'b00;
//            MemRead <= 2'b00;
//            MemToReg <= 1;
//            Jump <= 0;
//            Jr <= 0;
//            Jal <= 0;
//            ALUControl <= 5'b00110;
//            ShiftControl <= 0;
//            PCSrc <= 0;
//        end 
        6'b001101: begin            //ori
            RegWrite <= 1;
            ALUSrc <= 1;
            RegDst <= 0;
            MemWrite <= 2'b00;
            MemRead <= 2'b00;
            MemToReg <= 1;
            Jump <= 0;
            ALUControl <= 5'b00111;
            ShiftControl <= 0;
            PCSrc <= 0;
        end
//        6'b001110: begin            //xori
//            RegWrite <= 1;
//            ALUSrc <= 1;
//            RegDst <= 0;
//            MemWrite <= 2'b00;
//            MemRead <= 2'b00;
//            MemToReg <= 1;
//            Jump <= 0;
//            Jr <= 0;
//            Jal <= 0;
//            ALUControl <= 5'b01000;
//            ShiftControl <= 0;
//            PCSrc <= 0;
//        end
//        6'b001010: begin            //slti
//            RegWrite <= 1;
//            ALUSrc <= 1;
//            RegDst <= 0;
//            MemWrite <= 2'b00;
//            MemRead <= 2'b00;
//            MemToReg <= 1;
//            Jump <= 0;
//            Jr <= 0;
//            Jal <= 0;
//            ALUControl <= 5'b01110;
//            ShiftControl <= 0;
//            PCSrc <= 0;
//        end
        6'b000101: begin            //bne
            RegWrite <= 0;
            ALUSrc <= 0;
            RegDst <= 1'bx;
            MemWrite <= 2'b00;
            MemRead <= 2'b00;
            MemToReg <= 0;
            Jump <= 0;
            ALUControl <= 5'b11111;
            ShiftControl <= 0;
            if (BranchOutput) PCSrc <= 1;
            else PCSrc <= 0;
        end
//        6'b000100: begin            //beq
//            RegWrite <= 0;
//            ALUSrc <= 0;
//            RegDst <= 1'bx;
//            MemWrite <= 2'b00;
//            MemRead <= 2'b00;
//            MemToReg <= 0;
//            Jump <= 0;
//            Jr <= 0;
//            Jal <= 0;
//            ALUControl <= 5'b11111;
//            ShiftControl <= 0;
//            if (BranchOutput) PCSrc <= 1;
//            else PCSrc <= 0;
//        end
        // 6'b000001: begin            //bgez, bltz
        //     RegWrite <= 0;
        //     ALUSrc <= 0;
        //     RegDst <= 1'bx;
        //     MemWrite <= 2'b00;
        //     MemRead <= 2'b00;
        //     MemToReg <= 0;
        //     Jump <= 0;
        //     Jr <= 0;
        //     Jal <= 0;
        //     ShiftControl <= 0;
        //     case(Instruction[20:16])            //Uses rt as an extension of the opcode
        //         5'b00001: begin                 //bgez
        //             ALUControl <= 5'b11111;
        //             if (BranchOutput) PCSrc <= 1;
        //             else PCSrc <= 0;
        //         end
        //         5'b00000: begin                 //bltz
        //             ALUControl <=5'b11111;
        //             if (BranchOutput) PCSrc <= 1;
        //             else PCSrc <= 0;
        //         end
        //     endcase
        // end
        // 6'b000111: begin            //bgtz
        //     RegWrite <= 0;
        //     ALUSrc <= 0;
        //     RegDst <= 1'bx;
        //     MemWrite <= 2'b00;
        //     MemRead <= 2'b00;
        //     MemToReg <= 0;
        //     Jump <= 0;
        //     Jr <= 0;
        //     Jal <= 0;
        //     ALUControl <= 5'b11111;
        //     ShiftControl <= 0;
        //     if (BranchOutput) PCSrc <= 1;
        //     else PCSrc <= 0;
        // end
        // 6'b000110: begin            //blez
        //     RegWrite <= 0;
        //     ALUSrc <= 0;
        //     RegDst <= 1'bx;
        //     MemWrite <= 2'b00;
        //     MemRead <= 2'b00;
        //     MemToReg <= 0;
        //     Jump <= 0;
        //     Jr <= 0;
        //     Jal <= 0;
        //     ALUControl <= 5'b11111;
        //     ShiftControl <= 0;
        //     if (BranchOutput) PCSrc <= 1;
        //     else PCSrc <= 0;
        // end
        6'b000010: begin            //j
            RegWrite <= 0;
            ALUSrc <= 1'bx;
            RegDst <= 1'bx;
            MemWrite <= 2'b00;
            MemRead <= 2'b00;
            MemToReg <= 0;
            Jump <= 1;
            ALUControl <= 5'b11111;
            ShiftControl <= 0;
            PCSrc <= 0;
        end
//        6'b000011: begin            //jal
//            RegWrite <= 1;
//            ALUSrc <= 0;
//            RegDst <= 1'bx;
//            MemWrite <= 2'b00;
//            MemRead <= 2'b00;
//            MemToReg <= 0;
//            Jump <= 1;
//            Jr <= 0;
//            Jal <= 1;
//            ALUControl <= 5'b11111;
//            ShiftControl <= 0;
//            PCSrc <= 0;
//        end
        //jr has opcode 000000, funct 001000 - see top in rtype
        default: begin
            RegWrite <= 0;
            ALUSrc <= 0;
            RegDst <= 0;
            MemWrite <= 2'b00;
            MemRead <= 2'b00;
            MemToReg <= 0;
            Jump <= 0;
            ALUControl <= 5'b11111;
            ShiftControl <= 0;
            PCSrc <= 0;
        end
        endcase
    end    
endmodule
