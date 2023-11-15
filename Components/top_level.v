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


module top_level(Clk, Reset, xCoord, yCoord);

input Clk, Reset; 
output [31:0] xCoord, yCoord;
wire [31:0] WriteDataReg;
wire [31:0] PCResult;

wire [31:0] instruction;
wire [31:0] PCAddResult, PCSrcOutput, Jump_To_PC, NextPC;
wire [31:0] PCAddResultDecode, instructionDecode;

///////////////////
wire PCWrite, MuxControl, flushControl;

wire PreRegWrite, PreALUSrc, PreRegDst, PreMemToReg, PreJump, PreJr, PreJal, PreShiftControl, PrePCSrc;
wire [1:0] PreMemWrite, PreMemRead;
wire [4:0] PreALUControl;
wire RegWrite, ALUSrc, RegDst, MemToReg, Jump, Jr, Jal, ShiftControl, PCSrc; 
wire [1:0] MemWrite, MemRead;
wire [4:0] ALUControl;

wire [4:0] regDstMux, regDstOutput;
wire [31:0] ReadData1, ReadData2, signExtend, jOffset, ShiftSwitchWire, temp, PCAdder_SignExtension; 
wire [27:0] tempOffset;
wire Branch, BranchOutput;

//////////////////////////////////
wire [31:0] PCAddResultExecute, ReadData1Execute, ReadData2Execute, SignExtExecute, ALUSrcOutput;
wire [4:0] ALUControlExecute, rdExecute;
wire RegWriteExecute, ALUSrcExecute, MemToRegExecute, JalExecute;
wire[1:0] MemWriteExecute, MemReadExecute;

wire [31:0] ALUResult;

//////////////////////////////////
wire RegWriteMemory, MemToRegMemory, JalMemory;
wire [31:0] PCAddResultMemory, ALUResultMemory, ReadData2Memory, ReadData;
wire [4:0] RdMemory;
wire [1:0] MemWriteMemory, MemReadMemory;

//////////////////////////////////
wire RegWriteWrite, MemToRegWrite, JalWrite;
wire [31:0] MemReadDataWrite, ALUResultWrite, PCAddResultWrite, WritebackOutput;
wire [4:0] RegRdWrite;

Mux32Bit2To1 PCountSrc(PCSrcOutput, PCAdder_SignExtension, PCAddResult, PCSrc); 

Mux32Bit2To1 JRMux(Jump_To_PC, ReadData1, PCSrcOutput, Jr); 

Mux32Bit2To1 JumpMux(NextPC, jOffset, Jump_To_PC, Jump);

ProgramCounter Pcount(NextPC, PCResult, Reset, Clk, PCWrite);

InstructionMemory Imem(PCResult, instruction);

PCAdder adder(PCResult, PCAddResult);


//INSTRUCTION FETCH STAGE / DECODE STAGE
Fetch_To_Decode ftd(PCAddResult, instruction,  PCAddResultDecode, instructionDecode, Clk, Reset, DecodeWrite, flushControl);

RegisterFile reggy(instructionDecode[25:21], instructionDecode[20:16], RegRdWrite, WriteDataReg, RegWriteWrite, Clk, ReadData1, ReadData2, xCoord, yCoord);

SignExtension signE(instructionDecode[15:0], signExtend);

Mux32Bit2To1 ReadData1_SE_Switch(ShiftSwitchWire, signExtend, ReadData1, ShiftControl);

assign tempOffset = instructionDecode[25:0] << 2;
assign jOffset = {PCAddResultDecode[31:28], tempOffset};

assign temp = signExtend << 2;
assign PCAdder_SignExtension = temp + PCAddResultDecode;

Mux5bit2to1 regDest(regDstMux, instructionDecode[15:11], instructionDecode[20:16], RegDst); //rt if 0 , rd if 1

Mux5bit2to1 JalRAMux(regDstOutput, 5'b11111, regDstMux, Jal); //$ra is reg 31

Controller controlly(instructionDecode, BranchOutput, PreRegWrite, PreALUSrc, PreRegDst, PreMemWrite, PreMemRead, PreMemToReg, PreJump, PreJr, PreJal, PreALUControl, PreShiftControl, PrePCSrc);
//Controller(Instruction, gt, lt, eq, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, MemToReg, Jump, Jr, Jal, ALUControl, ShiftControl, PCSrc);

Comparator compy (instructionDecode, ReadData1, ReadData2, Branch, BranchOutput);

ControlMux controlMux1(PreRegWrite, PreALUSrc, PreRegDst, PreMemWrite, PreMemRead, PreMemToReg, PreJump, PreJr, PreJal, PreALUControl, PreShiftControl, PrePCSrc,
                        RegWrite, ALUSrc, RegDst, MemWrite, MemRead, MemToReg, Jump, Jr, Jal, ALUControl, ShiftControl, PCSrc, controlMuxSignal);
//ControlMux(PreRegWrite, PreALUSrc, PreRegDst, PreMemWrite, PreMemRead, PreMemToReg, PreJump, PreJr, PreJal, PreALUControl, PreShiftControl, PrePCSrc,
//                    RegWrite, ALUSrc, RegDst, MemWrite, MemRead, MemToReg, Jump, Jr, Jal, ALUControl, ShiftControl, PCSrc, controlMuxSignal);


HazardDetection hazzy (instructionDecode, BranchOutput, Branch, MemReadExecute, MemReadMemory, rdExecute, RdMemory, RegWriteExecute, RegWriteMemory, DecodeWrite, PCWrite, controlMuxSignal, flushControl);


//EXECUTE STAGE
Decode_To_Execute dte (Clk, Reset, RegWrite, ALUSrc, MemWrite, MemRead, MemToReg, Jal, ALUControl, PCAddResultDecode, ShiftSwitchWire, ReadData2, signExtend, regDstOutput,
    RegWriteExecute, ALUSrcExecute, MemWriteExecute, MemReadExecute, MemToRegExecute, JalExecute, ALUControlExecute, PCAddResultExecute, ReadData1Execute, ReadData2Execute, SignExtExecute, rdExecute);

Mux32Bit2To1 aluSource(ALUSrcOutput, SignExtExecute, ReadData2Execute, ALUSrcExecute); //SignExtOut if 1, ReadData2Out if 0

ALU32Bit alu(ALUControlExecute, ReadData1Execute, ALUSrcOutput, ALUResult);


//DATA MEMORY STAGE
Execute_To_DataMem etdm(Clk, Reset, RegWriteExecute, MemWriteExecute, MemReadExecute, MemToRegExecute, JalExecute, ReadData2Execute, ALUResult, PCAddResultExecute, rdExecute, 
                                    RegWriteMemory, MemWriteMemory, MemReadMemory, MemToRegMemory, JalMemory, ReadData2Memory, ALUResultMemory, PCAddResultMemory, RdMemory);

DataMemory DataMem(ALUResultMemory, ReadData2Memory, Clk, MemWriteMemory, MemReadMemory, ReadData); 


//WRITE BACK STAGE
DataMem_To_WriteBack dmtw(Clk, Reset, PCAddResultMemory, ReadData, ALUResultMemory, RdMemory, RegWriteMemory, MemToRegMemory, JalMemory,
			                          PCAddResultWrite, MemReadDataWrite, ALUResultWrite, RegRdWrite, RegWriteWrite, MemToRegWrite, JalWrite); 

Mux32Bit2To1 Writeback(WritebackOutput, ALUResultWrite, MemReadDataWrite, MemToRegWrite);

Mux32Bit2To1 LastMux(WriteDataReg, PCAddResultWrite, WritebackOutput, JalWrite); 



endmodule
