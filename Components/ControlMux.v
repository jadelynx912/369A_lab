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


module ControlMux(PreRegWrite, PreALUSrc, PreRegDst, PreMemWrite, PreMemRead, PreMemToReg, PreJump, PreALUControl, PreShiftControl, PrePCSrc,
                    RegWrite, ALUSrc, RegDst, MemWrite, MemRead, MemToReg, Jump, ALUControl, ShiftControl, PCSrc, controlMuxSignal);


input controlMuxSignal;
input PreRegWrite, PreALUSrc,PreRegDst, PreMemToReg, PreJump, PreShiftControl, PrePCSrc;
input [1:0] PreMemWrite, PreMemRead;
input [4:0] PreALUControl;

output reg RegWrite, ALUSrc, RegDst, MemToReg, Jump, ShiftControl, PCSrc;
output reg [4:0] ALUControl;
output reg [1:0] MemWrite, MemRead;

always @(*) begin
    if (controlMuxSignal == 1) begin
        RegWrite <= PreRegWrite;
        ALUSrc <= PreALUSrc;
        RegDst <= PreRegDst;
        MemWrite <= PreMemWrite;
        MemRead <= PreMemRead;
        MemToReg <= PreMemToReg;
        Jump <= PreJump;
        ALUControl <= PreALUControl;
        ShiftControl <= PreShiftControl;
        PCSrc <= PrePCSrc;
    end
    else begin
        RegWrite <= 0;
        ALUSrc <= 0;
        RegDst <= 0;
        MemWrite <= 0;
        MemRead <= 0;
        MemToReg <= 0;
        Jump <= 0;
        ALUControl <= 0;
        ShiftControl <= 0;
        PCSrc <= 0;
    end
end

endmodule