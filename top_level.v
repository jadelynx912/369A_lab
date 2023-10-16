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


module top_level(Clk, Reset, PCResult, WData);

input Clk, Reset; 
output [31:0] WData;
input [31:0] PCResult;

wire [31:0] instruction;
wire [31:0] PCAddResult, PCSrcOutput;
wire [31:0] PCAddResultDecode, instructionDecode;

///////////////////
wire PCSrc;
wire RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, ALUControl; 
wire [31:0] WriteRegister, WriteDataReg, ReadData1, ReadData2, signExtend; 

///////////////////
wire [31:0] temp;
wire temp1, temp2;


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

wire [31:0] ReadData;






Mux32Bit2To1 PCountSrc(PCSrcOutput, PCAdder_SignExtensionMemory, PCAddResult, PCSrc); 

ProgramCounter Pcount(PCSrcOutput, PCResult, rst, Clk);

InstructionMemory Imem(PCSrcOutput, instruction);

PCAdder adder(PCResult, PCAddResult);


//INSTRUCTION FETCH STAGE / DECODE STAGE
Fetch_To_Decode ftd(instruction, PCAddResult, PCAddResultDecode, instructionDecode, Clk);

RegisterFile reggy(instructionDecode[25:21], instructionDecode[20:16], RdMemory, WriteDataReg, RegWrite, Clk, ReadData1, ReadData2);

SignExtension signE(instructionDecode[15:0], signExtend);

Controller controlly(instructionDecode, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, ALUControl);

//DECODE STAGE / EXECUTE STAGE
Decode_To_Execute dte (Clk, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, ALUControl, PCAddResult, ReadData1, ReadData2, signE, instructionDecode[20:16], instructionDecode[15:11],
PCAddResultExecute, ReadData1Execute, ReadData2Execute, SignExtExecute, RegDst1Execute, RegDst2Execute,RegWriteExecute, ALUSrcExecute, RegDstExecute, MemWriteExecute, MemReadExecute, BranchExecute, MemToRegExecute, JumpExecute, ALUControlExecute);

assign temp = SignExtExecute << 2;
assign PCAdder_SignExtension = temp + PCAddResultExecute;

Mux32Bit2To1 aluSrc(ALUSrcOutput, SignExtExecute, ReadData2Execute, ALUSrcExecute); //SignExtOut if 1, ReadData2Out if 0

Mux32Bit2To1 regDst(regDstOutput, RegDst2Execute, RegDst1Execute, RegDstExecute); //RegDst1Out if 0 , RegDst2Out if 1

ALU32Bit alu(ALUControlExecute, ReadData1Execute, ALUSrcOutput, ALUResult, Zero);

//EXECUTE STAGE / DATA MEMORY STAGE
Execute_To_DataMem etdm(Clk, Zero, RegWriteExecute, MemWriteExecute, MemReadExecute, BranchExecute, MemToRegExecute, JumpExecute, PCAdder_SignExtension, ALUResult, ReadData2Execute, regDstOutput, 
RegWriteMemory, MemWriteMemory, MemReadMemory, BranchMemory, MemToRegMemory, JumpMemory, PCAdder_SignExtensionMemory, ALUResultMemory, ReadData2Memory, RdMemory, ZeroMemory);


assign temp1 = Zero;
assign temp2 = BranchMemory;

assign PCSrc = temp1 & temp2;
 
DataMemory DataMem(ALUResultMemory, ReadData2Memory, Clk, MemWriteMemory, MemReadMemory, ReadData); 

//DATA MEMORY STAGE / WRITE BACK STAGE


// need to declare this register
Mux32Bit2To1 Writeback(WriteDataReg, ALUResultWrite, ReadDataWrite, MemToRegWrite);



endmodule
