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

wire DecodeRegWrite, PCWrite, MuxControl;
wire PreRegWrite, PreALUSrc, PreRegDst, PreMemRead, PreBranch, PreJump, PreJr, PreJal, PreShiftControl;
wire [1:0] PreMemWrite, PreMemToReg;
wire [4:0] PreALUControl;

wire [1:0] MemWrite, MemRead;
wire [4:0] ALUControl, ShiftMuxWire;
wire [31:0] WriteRegister, WriteDataReg, ReadData1, ReadData2, signExtend, jOffset, WritebackOutput, ShiftSwitchWire; 
wire [27:0] tempOffset;
wire A_grt_B, A_ls_B, A_eq_B;
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


//assign PCSrc_Jump_OR = JumpMemory | PCSrc; //Do we grab Jump straight from controller or from memory pipeline?

Mux32Bit2To1 PCountSrc(PCSrcOutput, PCAdder_SignExtensionMemory, PCAddResult, PCSrc); 

Mux32Bit2To1 JRMux(Jump_To_PC, ReadData1Execute, PCSrcOutput, JrExecute); 

Mux32Bit2To1 JumpMux(NextPC, jOffset, Jump_To_PC, Jump);

ProgramCounter Pcount(NextPC, PCResult, Reset, Clk, PCWrite);

InstructionMemory Imem(PCResult, instruction); //Replaced PCSrcOutput with PCResult

PCAdder adder(PCResult, PCAddResult);


//INSTRUCTION FETCH STAGE / DECODE STAGE
Fetch_To_Decode ftd(PCAddResult, instruction,  PCAddResultDecode, instructionDecode, Clk, Reset);

RegisterFile reggy(instructionDecode[25:21], instructionDecode[20:16], RegRdWrite, WriteDataReg, RegWriteWrite, Clk, ReadData1, ReadData2);

SignExtension signE(instructionDecode[15:0], signExtend);

Mux32Bit2To1 ReadData1_SE_Switch(ShiftSwitchWire, signExtend, ReadData1, ShiftControl);

assign tempOffset = instructionDecode[25:0] << 2;
assign jOffset = {PCAddResultDecode[31:28], tempOffset};

assign temp = signExtend << 2;
assign PCAdder_SignExtension = temp + PCAddResultDecode;

Mux5bit2to1 regDest(regDstMux, instructionDecode[15:11], instructionDecode[20:16], RegDst); //rt if 0 , rd if 1

Mux5bit2to1 JalRAMux(regDstOutput, 5'b11111, regDstMux, Jal); //$ra is reg 31

Controller controlly(instructionDecode, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jump, Jr, Jal, ALUControl, ShiftControl);

//Lab 6 work

//TODO: JalRAMux regDstOutput not wired
      //naming inconsistency in rdExecute

Mux5bit2to1 Mux1(RegWrite, PreRegWrite, 1'b0, MuxControl);
Mux5bit2to1 Mux2(ALUSrc, PreALUSrc, 1'b0, MuxControl);
Mux5bit2to1 Mux3(RegDst, PreRegDst, 1'b0, MuxControl);
Mux5bit2to1 Mux4(MemWrite, PreMemWrite, 1'b0, MuxControl);
Mux5bit2to1 Mux5(MemRead, PreMemRead, 1'b0, MuxControl);
Mux5bit2to1 Mux6(Branch, PreBranch, 1'b0, MuxControl);
Mux5bit2to1 Mux7(MemToReg, PreMemToReg, 1'b0, MuxControl);
Mux5bit2to1 Mux8(Jump, PreJump, 1'b0, MuxControl);
Mux5bit2to1 Mux9(Jr, JrPreJr, 1'b0, MuxControl);
Mux5bit2to1 Mux10(Jal, PreJal, 1'b0, MuxControl);
Mux5bit2to1 Mux11(ALUControl, PreALUControl, 1'b0, MuxControl);
Mux5bit2to1 Mux12(ShiftControl, PreShiftControl, 1'b0, MuxControl);

Comparator compy (ReadData1, ReadData2, A_grt_B, A_ls_B, A_eq_B);

HazardDetection hazzy (instructionDecode, A_grt_B, A_ls_B, A_eq_B, RegDstExecute, RdMemory, DecodeRegWrite, PCWrite, MuxControl, RegWriteExecute, RegWriteMemory);


//EXECUTE STAGE
Decode_To_Execute dte (Clk, Reset, DecodeRegWrite, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, MemToReg, Jr, Jal, ALUControl, PCAddResultDecode, ShiftSwitchWire, ReadData2, signExtend,
                                   RegWriteExecute, ALUSrcExecute, RegDstExecute, MemWriteExecute, MemReadExecute, MemToRegExecute, JrExecute, JalExecute, ALUControlExecute, PCAddResultExecute, ReadData1Execute, ReadData2Execute, SignExtExecute);

//modulDecodeo_Execute(Clk, Reset, RegWrite, ALUSrc, RegDst, MemWrite, MemRead, Branch, MemToReg, Jr, Jal, ALUControl, PCAddResult, ReadData1, ReadData2, SignExt, RegDst1, RegDst2, 
//                                 RegWriteOut, ALUSrcOut, RegDstOut, MemWriteOut, MemReadOut, BranchOut, MemToRegOut, JrOut, JalOut, ALUControlOut, PCAddResultOut, ReadData1Out, ReadData2Out, SignExtOut, RegDst1Out, RegDst2Out);
//BRANCH, RegDst1, RegDst2, BranchOut, RegDst1Out, RegDst2Out

//REMOVE REGDST EXECUTE FROM REGISTER FILE (Does it even need to be passed through)
//WILL START HERE AND GO UP 

Mux32Bit2To1 aluSource(ALUSrcOutput, SignExtExecute, ReadData2Execute, ALUSrcExecute); //SignExtOut if 1, ReadData2Out if 0

ALU32Bit alu(ALUControlExecute, ReadData1Execute, ALUSrcOutput, ALUResult, Zero);


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
