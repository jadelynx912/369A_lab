`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2023 02:34:38 PM
// Design Name: 
// Module Name: top_level
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


module top_level(clk, rst, address);

input clk, rst; 
input [31:0] address;

wire [31:0] instruction;
wire [31:0] PCResult, PCAddResult, PCSrcOutput;
wire [31:0] PCAddResultDecode, instructionDecode;

///////////////////
wire RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, ALUControl; //controller stuff, no PCSrc?
wire [31:0] WriteRegister, WriteDataReg, ReadData1, ReadData2, signExtend; 

///////////////////
wire [31:0] PCAddResultExecute, ReadData1Execute, ReadData2Execute, SignExtExecute;
wire [4:0] RegDst1Execute, RegDst2Execute;
wire RegWriteExecute, ALUSrcExecute, RegDstExecute, MemWriteExecute, MemReadExecute, BranchExecute, MemToRegExecute, JumpExecute, ALUControlExecute;
wire [31:0] ALUSrcOutput, regDstOutput;

wire [31:0] ALUResult;
wire Zero;
//////////////////////////////////
wire RegWriteMemory, MemWriteMemory, MemReadMemory, BranchMemory, MemToRegMemory, JumpMemory;
wire [31:0] PCAdder_SignExtensionMemory, ALUResultMemory, ReadData2Memory, RdMemory;
wire ZeroMemory;






Mux32Bit2To1 PCountSrc(PCSrcOutput, PCAddResult, inB, jumpFinal); //change inB

ProgramCounter Pcount(PCSrcOutput, PCResult, rst, clk);

InstructionMemory Imem(Address, instruction);

PCAdder adder(PCResult, PCAddResult);


//INSTRUCTION FETCH STAGE / DECODE STAGE
Fetch_To_Decode ftd(instruction, PCAddResult, PCAddResultDecode, instructionDecode, clk);

RegisterFile reggy(instructionDecode[25:21], instructionDecode[20:16], WriteRegister, WriteDataReg, RegWrite, clk, ReadData1, ReadData2);
//WriteData and Write Address to be updated

SignExtension signE(instructionDecode[15:0], signExtend);

Controller controlly(instructionDecode, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, ALUControl);

//DECODE STAGE / EXECUTE STAGE
Decode_To_Execute dte (clk, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, ALUControl, PCAddResult, ReadData1, ReadData2, signE, instructionDecode[20:16], instructionDecode[15:11],
PCAddResultExecute, ReadData1Execute, ReadData2Execute, SignExtExecute, RegDst1Execute, RegDst2Execute,RegWriteExecute, ALUSrcExecute, RegDstExecute, MemWriteExecute, MemReadExecute, BranchExecute, MemToRegExecute, JumpExecute, ALUControlExecute);

//add logic gates//////////////////////////

Mux32Bit2To1 aluSrc(ALUSrcOutput, SignExtExecute, ReadData2Execute, ALUSrcExecute); //SignExtOut if 1, ReadData2Out if 0

Mux32Bit2To1 regDst(regDstOutput, RegDst2Execute, RegDst1Execute, RegDstExecute); //RegDst1Out if 0 , RegDst2Out if 1

ALU32Bit alu(ALUControlExecute, ReadData1Execute, ALUSrcOutput, ALUResult, Zero);

//EXECUTE STAGE / DATA MEMORY STAGE
Execute_To_DataMem etdm(clk, Zero, RegWriteExecute, MemWriteExecute, MemReadExecute, BranchExecute, MemToRegExecute, JumpExecute, PCAdder_SignExtension, ALUResult, ReadData2Execute, regDstOutput, 
RegWriteMemory, MemWriteMemory, MemReadMemory, BranchMemory, MemToRegMemory, JumpMemory, PCAdder_SignExtensionMemory, ALUResultMemory, ReadData2Memory, RdMemory, ZeroMemory);
//IMPLEMENT PCAdder_SignExtension THROUGH LOGIC GATES


DataMemory DataMem(Address, WriteData, Clk, MemWrite, MemRead, ReadData); 

//DATA MEMORY STAGE / WRITE BACK STAGE

Mux32Bit2To1 Writeback(WriteDataReg, inA, inB, sel);



endmodule
