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


module top_level(Clk, Reset, PCResult, WriteDataReg);

input Clk, Reset; 
output [31:0] WriteDataReg;
output [31:0] PCResult;

wire [31:0] instruction;
wire [31:0] PCAddResult, PCSrcOutput, Jump_To_PC, NextPC;
wire [31:0] PCAddResultDecode, instructionDecode;

///////////////////
wire PCSrc, PCSrc_Jump_OR;
wire RegWrite, ALUSrc, RegDst, Branch, MemToReg, Jump, Jr, Jal; 
wire [1:0] MemWrite, MemRead;
wire [4:0] ALUControl, ShiftMuxWire;
wire [31:0] WriteRegister, WriteDataReg, ReadData1, ReadData2, signExtend, jOffset, WritebackOutput, ShiftSwitchWire; 
wire [27:0] tempOffset;
///////////////////
wire [31:0] temp;
wire temp1, temp2;

wire [31:0] PCAddResultExecute, ReadData1Execute, ReadData2Execute, SignExtExecute, jOffsetExecute;
wire [4:0] RegDst1Execute, RegDst2Execute, regDstMux, regDstOutput, ALUControlExecute;
wire RegWriteExecute, ALUSrcExecute, RegDstExecute, BranchExecute, MemToRegExecute, JrExecute, JalExecute;
wire [31:0] ALUSrcOutput, PCAdder_SignExtension;
wire[1:0] MemWriteExecute, MemReadExecute;

wire [31:0] ALUResult;
wire Zero;
//////////////////////////////////
wire RegWriteMemory, BranchMemory, MemToRegMemory, JumpMemory, JrMemory, JalMemory;
wire [31:0] PCAdder_SignExtensionMemory, PCAddResultMemory, ALUResultMemory, ReadData1Memory, ReadData2Memory;
wire [4:0] RdMemory;
wire [1:0] MemWriteMemory, MemReadMemory;
wire ZeroMemory;

wire RegWriteWrite, MemToRegWrite, JalWrite;
wire [31:0] ReadData, MemReadDataWrite, ALUResultWrite, PCAddResultWrite;
wire [4:0] RegRdWrite;


//Branch PC may be fucked and needs to be checked
//Branch vs BranchPC???
//Double check I pass through ALUControl, and RD Mux values through as 5 bits and not signals.
//DATAMEN_TO_WRITEBACK MISSING CONTROL SIGNALS
//Check any signal that should be 5 bits
//RegDstOutput should be 5 bits


//assign PCSrc_Jump_OR = JumpMemory | PCSrc; //Do we grab Jump straight from controller or from memory pipeline?

Mux32Bit2To1 PCountSrc(PCSrcOutput, PCAdder_SignExtensionMemory, PCAddResult, PCSrc); 

Mux32Bit2To1 JRMux(Jump_To_PC, ReadData1Execute, PCSrcOutput, JrExecute); 

Mux32Bit2To1 JumpMux(NextPC, jOffset, Jump_To_PC, Jump);

ProgramCounter Pcount(NextPC, PCResult, Reset, Clk);

InstructionMemory Imem(PCResult, instruction); //Replaced PCSrcOutput with PCResult

PCAdder adder(PCResult, PCAddResult);


//INSTRUCTION FETCH STAGE / DECODE STAGE
Fetch_To_Decode ftd(PCAddResult, instruction,  PCAddResultDecode, instructionDecode, Clk, Reset);

RegisterFile reggy(instructionDecode[25:21], instructionDecode[20:16], RegRdWrite, WriteDataReg, RegWriteWrite, Clk, ReadData1, ReadData2);

SignExtension signE(instructionDecode[15:0], signExtend);

Mux32Bit2To1 ReadData1_SE_Switch(ShiftSwitchWire, signExtend, ReadData1, ShiftControl);

assign tempOffset = instructionDecode[25:0] << 2;
assign jOffset = {PCAddResultDecode[31:28], tempOffset};

Controller controlly(instructionDecode, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, Jr, Jal, ALUControl, ShiftControl);

//DECODE STAGE / EXECUTE STAGE
Decode_To_Execute dte (Clk, Reset, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jr, Jal, ALUControl, PCAddResultDecode, ShiftSwitchWire, ReadData2, signExtend, instructionDecode[20:16], instructionDecode[15:11],
RegWriteExecute, ALUSrcExecute, RegDstExecute, MemWriteExecute, MemReadExecute, BranchExecute, MemToRegExecute, JrExecute, JalExecute, ALUControlExecute, PCAddResultExecute, ReadData1Execute, ReadData2Execute, SignExtExecute, RegDst1Execute, RegDst2Execute);

assign temp = SignExtExecute << 2;
assign PCAdder_SignExtension = temp + PCAddResultExecute;

Mux32Bit2To1 aluSource(ALUSrcOutput, SignExtExecute, ReadData2Execute, ALUSrcExecute); //SignExtOut if 1, ReadData2Out if 0

Mux5bit2to1 regDest(regDstMux, RegDst2Execute, RegDst1Execute, RegDstExecute); //RegDst1Out if 0 , RegDst2Out if 1

Mux5bit2to1 JalRAMux(regDstOutput, 5'b11111, regDstMux, JalExecute); //$ra is reg 31

ALU32Bit alu(ALUControlExecute, ReadData1Execute, ALUSrcOutput, ALUResult, Zero);


//EXECUTE STAGE / DATA MEMORY STAGE
Execute_To_DataMem etdm(Clk, Reset, RegWriteExecute, MemWriteExecute, MemReadExecute, BranchExecute, MemToRegExecute, JalExecute, Zero, ReadData2Execute, ALUResult, PCAddResultExecute, PCAdder_SignExtension, regDstOutput, 
RegWriteMemory, MemWriteMemory, MemReadMemory, BranchMemory, MemToRegMemory, JalMemory, ZeroMemory, ReadData2Memory, ALUResultMemory, PCAddResultMemory, PCAdder_SignExtensionMemory, RdMemory);

assign temp1 = ZeroMemory;
assign temp2 = BranchMemory;

assign PCSrc = temp1 & temp2;
DataMemory DataMem(ALUResultMemory, ReadData2Memory, Clk, MemWriteMemory, MemReadMemory, ReadData); 

//DATA MEMORY STAGE / WRITE BACK STAGE
DataMem_To_WriteBack dmtw(Clk, Reset, PCAddResultMemory, ReadData, ALUResultMemory, RdMemory, RegWriteMemory, MemToRegMemory, JalMemory,
			PCAddResultWrite, MemReadDataWrite, ALUResultWrite, RegRdWrite, RegWriteWrite, MemToRegWrite, JalWrite); 

Mux32Bit2To1 Writeback(WritebackOutput, ALUResultWrite, MemReadDataWrite, MemToRegWrite);

Mux32Bit2To1 LastMux(WriteDataReg, PCAddResultWrite, WritebackOutput, JalWrite); 



endmodule
