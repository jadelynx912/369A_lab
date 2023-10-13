`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2023 03:28:36 PM
// Design Name: 
// Module Name: TopModule
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


module Datapath(Clk, Reset, PCResult, WData);
    input Clk, Reset;
    output reg [32:0] PCResult, WData;
    wire RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, Jr, Jal;
    wire [32:0] Instruction;
    
    
    Controller c1(Instruction, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, Jr, Jal, ALUControl);
                    //GET ADDRESS FROM SOMEWHERE
    ProgramCounter pc1(Address, PCResult, Reset, Clk);
    InstructionMemory im1(PCResult, Instruction);
    PCAdder pca1(PCResult, PCAddResult);
    
    //GET WriteRegister, WriteData, (RegWrite - good I think)
    RegisterFile(Instruction[26:21], Instruction[20:16], WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2);
    Mux32Bit2To1 jumpMux(Immediate, Instruction[15:0], Instruction[26:0], Jump);
    SignExtension(Immediate, ImmediateExtended);
    
        

endmodule
