`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2023 12:53:58 PM
// Design Name: 
// Module Name: ControlMux
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


module ControlMux(RegWrite, PreRegWrite, ALUSrc, PreALUSrc, RegDst, PreRegDst, MemWrite, PreMemWrite, MemRead, PreMemRead, Branch, PreBranch, MemToReg, MemToReg, Jump, PreJump, Jr, PreJr, Jal, PreJal, ALUControl, PreALUControl, ShiftControl, PreShiftControl);

input controlMuxSignal;
output reg RegWrite, ALUSrc, RegDst, MemToReg, Jump, Jr, Jal, ShiftControl, PCSrc;
output reg [4:0] ALUControl;
output reg [1:0] MemWrite, MemRead;

always @(*) begin
    if (controlMuxSignal == 1) begin
    RegWrite <= PreRegWrite;
    ALUSrc <= PreALUSrc;
    RegDst <= PreRegDst;
    MemWrite <= PreMemWrite;
    MemRead <= PreMemRead;
    Branch <= PreBranch;
    MemToReg <= MemToReg;
    Jump <= PreJump;
    Jr <= PreJr;
    Jal <= PreJal;
    ALUControl <= PreALUControl;
    ShiftControl <= PreShiftControl;
    end
    else if (controlMuxSignal == 0) begin
    RegWrite <= 0;
    ALUSrc <= 0;
    RegDst <= 0;
    MemWrite <= 0;
    MemRead <= 0;
    Branch <= 0;
    MemToReg <= 0
    Jump <= 0;
    Jr <= 0;
    Jal <= 0;
    ALUControl <= 0;
    ShiftControl <= 0;
    end
end

endmodule