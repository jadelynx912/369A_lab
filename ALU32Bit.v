`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero);

	input [3:0] ALUControl; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed
	input [31:0] A, B;	    // inputs

	output reg [31:0] ALUResult;	// answer
	output reg Zero;	    // Zero=1 if ALUResult == 0

    /* Please fill in the implementation here... */
    always @ (ALUControl, A, B, ALUResult, Zero) begin
        case (ALUControl)
        4'b0000: // Addition
           ALUResult = A + B ; 
        4'b0001: // Subtraction
           ALUResult = A - B ;
        4'b0010: // Multiplication
           ALUResult = A * B;
        4'b0011: // Division
           ALUResult = A / B;
        4'b0100: // Logical shift left
           ALUResult = A << 1;
         4'b0101: // Logical shift right
           ALUResult = A >> 1;
	     4'b0110://  Logical and 
           ALUResult = A & B;
	     4'b0111://  Logical or
           ALUResult = A | B;
	     4'b1000: //  Logical xor 
           ALUResult = A ^ B;
	     4'b1001: //  Logical nor
           ALUResult = ~(A | B);
	     4'b1010: // Logical nand 
           ALUResult = ~(A & B);
         4'b1011: // Logical xnor
           ALUResult = ~(A ^ B);
         4'b1100:// Greater comparison
           ALUResult = (A>B)?8'd1:8'd0;
         4'b1101:// Equal comparison   
            ALUResult = (A==B)?8'd1:8'd0;
	     default: Zero = 1; 
        endcase
    end 

endmodule

