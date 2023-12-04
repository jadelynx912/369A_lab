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


module top_level(Clk, Reset, xCoord, yCoord, sad);

input Clk, Reset; 
output [31:0] xCoord, yCoord, sad;
wire [31:0] PCResult;

wire [31:0] instruction;
wire [31:0] PCAddResult, PCSrcOutput, NextPC;
wire [31:0] PCAddResultDecode, instructionDecode;

///////////////////
wire PCWrite, flushControl;

wire RegWrite, ALUSrc, RegDst, MemToReg, Jump, PCSrc; 
wire [1:0] MemWrite, MemRead;
wire [4:0] ALUControl;

wire [4:0] regDstMux;
wire [31:0] ReadData1, ReadData2, signExtend, jOffset, temp, PCAdder_SignExtension; 
wire [27:0] tempOffset;
wire Branch, BranchOutput;

//////////////////////////////////
wire [31:0] ReadData1Execute, ReadData2Execute, SignExtExecute, ALUSrcOutput;
wire [4:0] ALUControlExecute, rdExecute;
wire RegWriteExecute, ALUSrcExecute, MemToRegExecute;
wire[1:0] MemWriteExecute, MemReadExecute;

wire [31:0] ALUResult;

////////////////////////////////// Forwarding vars

wire [1:0] fwdControlA, fwdControlB;

wire [31:0] fwdOutA, fwdOutB;

wire [4:0] RSExecute, RTExecute;


//////////////////////////////////
wire RegWriteMemory, MemToRegMemory;
wire [31:0] ALUResultMemory, ReadData2Memory, ReadData;
wire [4:0] RdMemory;
wire [1:0] MemWriteMemory, MemReadMemory;

//////////////////////////////////
wire RegWriteWrite, MemToRegWrite;
wire [31:0] MemReadDataWrite, ALUResultWrite, WritebackOutput;
wire [4:0] RegRdWrite;

Mux32Bit2To1 PCountSrc(PCSrcOutput, PCAdder_SignExtension, PCAddResult, PCSrc); 

//Mux32Bit2To1 JRMux(Jump_To_PC, ReadData1, PCSrcOutput, Jr); 

Mux32Bit2To1 JumpMux(NextPC, jOffset, PCSrcOutput, Jump);

ProgramCounter Pcount(NextPC, PCResult, Reset, Clk, PCWrite);

InstructionMemory Imem(PCResult, instruction);

PCAdder adder(PCResult, PCAddResult);


//INSTRUCTION FETCH STAGE / DECODE STAGE
Fetch_To_Decode ftd(PCAddResult, instruction,  PCAddResultDecode, instructionDecode, Clk, Reset, DecodeWrite, flushControl);

RegisterFile reggy(instructionDecode[25:21], instructionDecode[20:16], RegRdWrite, WritebackOutput, RegWriteWrite, Clk, ReadData1, ReadData2, xCoord, yCoord, sad);

SignExtension signE(instructionDecode[15:0], signExtend);

//Mux32Bit2To1 ReadData1_SE_Switch(ShiftSwitchWire, signExtend, ReadData1, ShiftControl);

assign tempOffset = instructionDecode[25:0] << 2;
assign jOffset = {PCAddResultDecode[31:28], tempOffset};

assign temp = signExtend << 2;
assign PCAdder_SignExtension = temp + PCAddResultDecode;

Mux5bit2to1 regDest(regDstMux, instructionDecode[15:11], instructionDecode[20:16], RegDst); //rt if 0 , rd if 1



//Mux5bit2to1 JalRAMux(regDstOutput, 5'b11111, regDstMux, Jal); //$ra is reg 31



Controller controlly(instructionDecode, BranchOutput, controlMuxSignal, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, MemToReg, Jump, ALUControl, PCSrc);
//Controller(Instruction, gt, lt, eq, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, MemToReg, Jump, Jr, Jal, ALUControl, ShiftControl, PCSrc);

Comparator compy (instructionDecode, ReadData1, ReadData2, Branch, BranchOutput);

//ControlMux controlMux1(PreRegWrite, PreALUSrc, PreRegDst, PreMemWrite, PreMemRead, PreMemToReg, PreJump, PreALUControl, PreShiftControl, PrePCSrc,
//                        RegWrite, ALUSrc, RegDst, MemWrite, MemRead, MemToReg, Jump, ALUControl, ShiftControl, PCSrc, controlMuxSignal);
//ControlMux(PreRegWrite, PreALUSrc, PreRegDst, PreMemWrite, PreMemRead, PreMemToReg, PreJump, PreJr, PreJal, PreALUControl, PreShiftControl, PrePCSrc,
//                    RegWrite, ALUSrc, RegDst, MemWrite, MemRead, MemToReg, Jump, Jr, Jal, ALUControl, ShiftControl, PCSrc, controlMuxSignal);


HazardDetection hazzy (instructionDecode, BranchOutput, Branch, MemReadExecute, MemReadMemory, rdExecute, RdMemory, RegWriteExecute, RegWriteMemory, DecodeWrite, PCWrite, controlMuxSignal, flushControl);


//EXECUTE STAGE
Decode_To_Execute dte (Clk, Reset, instructionDecode[25:21], instructionDecode[20:16], RegWrite, ALUSrc, MemWrite, MemRead, MemToReg, ALUControl, ReadData1, ReadData2, signExtend, regDstMux,
    RSExecute, RTExecute, RegWriteExecute, ALUSrcExecute, MemWriteExecute, MemReadExecute, MemToRegExecute, ALUControlExecute, ReadData1Execute, ReadData2Execute, SignExtExecute, rdExecute);

Mux32Bit2To1 aluSource(ALUSrcOutput, SignExtExecute, ReadData2Execute, ALUSrcExecute); //SignExtOut if 1, ReadData2Out if 0

Mux32Bit3To1 forwdAMux(fwdOutA, ReadData1Execute, ALUResultMemory, WritebackOutput, fwdControlA);

Mux32Bit3To1 forwdBMux(fwdOutB, ALUSrcOutput, ALUResultMemory, WritebackOutput, fwdControlB);

ALU32Bit alu(ALUControlExecute, fwdOutA, fwdOutB, ALUResult);

Forwarding forwd(fwdControlA, fwdControlB, RegWriteMemory, RdMemory, RegWriteWrite, RegRdWrite, RSExecute, RTExecute);

//DATA MEMORY STAGE
Execute_To_DataMem etdm(Clk, Reset, RegWriteExecute, MemWriteExecute, MemReadExecute, MemToRegExecute, ReadData2Execute, ALUResult, rdExecute, 
                                    RegWriteMemory, MemWriteMemory, MemReadMemory, MemToRegMemory, ReadData2Memory, ALUResultMemory, RdMemory);


DataMemory DataMem(ALUResultMemory, ReadData2Memory, Clk, MemWriteMemory, MemReadMemory, ReadData); 


//WRITE BACK STAGE
DataMem_To_WriteBack dmtw(Clk, Reset, ReadData, ALUResultMemory, RdMemory, RegWriteMemory, MemToRegMemory,
			                          MemReadDataWrite, ALUResultWrite, RegRdWrite, RegWriteWrite, MemToRegWrite); 

Mux32Bit2To1 Writeback(WritebackOutput, ALUResultWrite, MemReadDataWrite, MemToRegWrite);




//Mux32Bit2To1 LastMux(WriteDataReg, PCAddResultWrite, WritebackOutput, JalWrite); 

//PCAddResultWrite can destroy


endmodule
