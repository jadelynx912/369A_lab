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
// Percent Effor: William Rains 33%, Kari Cordes 33%, Samantha Perry 33%
//
//////////////////////////////////////////////////////////////////////////////////


module top_level(Clk, Reset, PCResult);

input Clk, Reset; 
//output [31:0] WData;
input [31:0] PCResult;

wire [31:0] instruction;
wire [31:0] PCAddResult, PCSrcOutput, Jump_To_PC;
wire [31:0] PCAddResultDecode, instructionDecode;

///////////////////
wire PCSrc, PCSrc_Jump_OR;
wire RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, Jr, Jal, ALUControl; 
wire [31:0] WriteRegister, WriteDataReg, ReadData1, ReadData2, signExtend, signExtend25, signExtend15, WritebackOutput; 

///////////////////
wire [31:0] temp;
wire temp1, temp2;


wire [31:0] PCAddResultExecute, ReadData1Execute, ReadData2Execute, SignExtExecute;
wire [4:0] RegDst1Execute, RegDst2Execute;
wire RegWriteExecute, ALUSrcExecute, RegDstExecute, MemWriteExecute, MemReadExecute, BranchExecute, MemToRegExecute, JumpExecute, ALUControlExecute, JrExecute, JalExecute;
wire [31:0] ALUSrcOutput, regDstOutput, regDstMux;

wire [31:0] ALUResult, BranchPCExecute;
wire Zero;
//////////////////////////////////
wire RegWriteMemory, MemWriteMemory, MemReadMemory, BranchMemory, MemToRegMemory, JumpMemory, JrMemory, JalMemory, BranchPCMemory;
wire [31:0] PCAdder_SignExtensionMemory, ALUResultMemory, ReadData2Memory, RdMemory;
wire ZeroMemory;

wire RegWriteWrite, MemToRegWrite, JalWrite;
wire [31:0] ReadData, MemReadDataWrite, ALUResultWrite, BranchPCWrite;
wire [4:0] RegRdWrite;


//Branch PC may be fucked and needs to be checked
//Branch vs BranchPC???
//Double check I pass through ALUControl, and RD Mux values through as 5 bits and not signals.
//DATAMEN_TO_WRITEBACK MISSING CONTROL SIGNALS
//Check any signal that should be 5 bits
//RegDstOutput should be 5 bits
//May need to replace JR with JR Memory


assign PCSrc_Jump_OR = JumpMemory | PCSrc; //Do we grab Jump straight from controller or from memory pipeline?

Mux32Bit2To1 PCountSrc(PCSrcOutput, PCAdder_SignExtensionMemory, PCAddResult, PCSrc); 

Mux32Bit2To1 JumpMux(Jump_To_PC, , PCSrcOutput, Jr); // May need to replace JR with JR Memory?????

ProgramCounter Pcount(Jump_To_PC, PCResult, Reset, Clk);

InstructionMemory Imem(PCResult, instruction); //Replaced PCSrcOutput with PCResult

PCAdder adder(PCResult, PCAddResult);


//INSTRUCTION FETCH STAGE / DECODE STAGE
Fetch_To_Decode ftd(PCAddResult, instruction,  PCAddResultDecode, instructionDecode, Clk, Reset);

RegisterFile reggy(instructionDecode[25:21], instructionDecode[20:16], RegRdWrite, WriteDataReg, RegWriteWrite, Clk, ReadData1, ReadData2);

SignExtension signE(instructionDecode[15:0], signExtend15);

SignExtension_25to32 signE25(instructionDecode[25:0], signExtend25);

Mux32Bit2To1 SignExtensionMuxxy(signExtend, signExtend25, signExtend15, Jump);

Controller controlly(instructionDecode, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, Jr, Jal, ALUControl);

//DECODE STAGE / EXECUTE STAGE
Decode_To_Execute dte (Clk, Reset, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, Jr, Jal, ALUControl, PCAddResult, ReadData1, ReadData2, signExtend, instructionDecode[20:16], instructionDecode[15:11],
PCAddResultExecute, ReadData1Execute, ReadData2Execute, SignExtExecute, RegDst1Execute, RegDst2Execute,RegWriteExecute, ALUSrcExecute, RegDstExecute, MemWriteExecute, MemReadExecute, BranchExecute, MemToRegExecute, JumpExecute, JrExecute, JalExecute, ALUControlExecute);

assign temp = SignExtExecute << 2;
assign PCAdder_SignExtension = temp + PCAddResultExecute;

Mux32Bit2To1 aluSource(ALUSrcOutput, SignExtExecute, ReadData2Execute, ALUSrcExecute); //SignExtOut if 1, ReadData2Out if 0

Mux32Bit2To1 regDest(regDstMux, RegDst2Execute, RegDst1Execute, RegDstExecute); //RegDst1Out if 0 , RegDst2Out if 1

Mux32Bit2To1 JalRAMux(regDstOutput, 29, regDstMux, JalExecute); //How tf do you implement ra here?

ALU32Bit alu(ALUControlExecute, ReadData1Execute, ALUSrcOutput, ALUResult, Zero);

assign BranchPCExecute = PCAddResultExecute; //for organizational purposes

//EXECUTE STAGE / DATA MEMORY STAGE
Execute_To_DataMem etdm(Clk, Reset, RegWriteExecute, MemWriteExecute, MemReadExecute, BranchExecute, MemToRegExecute, JumpExecute, JrExecute, JalExecute, Zero, ReadData2Execute, ALUResult, PCAdder_SignExtension, BranchPCExecute, regDstOutput, 
RegWriteMemory, MemWriteMemory, MemReadMemory, BranchMemory, MemToRegMemory, JumpMemory, JrMemory, JalMemory, ZeroMemory, ReadData2Memory, ALUResultMemory, PCAdder_SignExtensionMemory, BranchPCMemory, RdMemory);

assign temp1 = ZeroMemory;
assign temp2 = BranchMemory;

assign PCSrc = temp1 & temp2;
 
DataMemory DataMem(ALUResultMemory, ReadData2Memory, Clk, MemWriteMemory, MemReadMemory, ReadData); 

//DATA MEMORY STAGE / WRITE BACK STAGE
DataMem_To_WriteBack dmtw(Clk, Reset, PCAddResult, ReadData, ALUResultMemory, RdMemory, BranchPCMemory, RegWriteMemory, MemToRegMemory, JalMemory,
			PCAddResultWrite, MemReadDataWrite, ALUResultWrite, RegRdWrite, BranchPCWrite, RegWriteWrite, MemToRegWrite, JalWrite); 

//PCAddResult being passed in, why?

Mux32Bit2To1 Writeback(WritebackOutput, ALUResultWrite, MemReadDataWrite, MemToRegWrite);

Mux32Bit2To1 LastMux(WriteDataReg, BranchPCWrite, WritebackOutput, JalWrite); 



endmodule
