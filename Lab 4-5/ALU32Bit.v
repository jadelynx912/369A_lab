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

	input [4:0] ALUControl; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed
	input signed [31:0] A, B;	    // inputs

	output signed reg [31:0] ALUResult;	// answer
	output reg Zero;	    // Zero=1 if ALUResult == 0

    always @ (ALUControl, A, B) begin
        case (ALUControl)  
            5'b00001: begin                 // Addition
                ALUResult <= A + B;
                Zero <= 0;
            end
            5'b00010: begin                 //Subtraction
                ALUResult <= A - B;
                Zero <= 0;
            end
            5'b00011: begin                 // Multiplication
                ALUResult <= A * B;
                Zero <= 0;
            end
            5'b00100: begin                 // Logical shift left
                ALUResult <= B << A[10:6];
                Zero <= 0;
            end
            5'b00101: begin                 // Logical shift right 
                ALUResult <= B >> A[10:6];
                Zero <= 0;
            end
            5'b00110: begin                 // Logical and
                ALUResult <= A & B;
                Zero <= 0;
            end
            5'b00111: begin                 //Logical or
                ALUResult <= A | B;
                Zero <= 0;
            end    
	        5'b01000: begin                 //Logical xor
                ALUResult <= A ^ B;
                Zero <= 0;
            end
            5'b01011: begin                 // Branch if greater than or equal to zero (bgez)
                ALUResult <= (A>=B)?8'd1:8'd0;
                if (ALUResult == 1) Zero <= 1;
                else Zero <= 0;
            end
            5'b01100: begin                 // Branch on equal (beq)
                ALUResult <= (A==B)?8'd1:8'd0;
	           if (ALUResult == 1) Zero <= 1;
	           else Zero <= 0;
            end
	       5'b01101: begin                  // Logical nor
	           ALUResult <= ~(A | B);
	           Zero <= 0;
            end
	    5'b01110: begin                    //Logical slt
	        if (A != B) begin
                if (A > B) begin
                    ALUResult <= 0;
	            Zero <=0;
                end
                else begin
                    ALUResult <= 1;
                    Zero <= 0;
                end
            end 
            else begin
                if (A <= B) begin
                    ALUResult <= 0;
                    Zero <= 0;
                end
	            else begin
	               ALUResult <= 1;
                       Zero <= 0;
                end
            end
        end
	    5'b01111:  begin                    //Branch on not equal (bne)
   	        ALUResult <= (A!=B)?8'd1:8'd0;
            if (ALUResult == 1) Zero <= 1;
            else Zero <= 0;
        end
        5'b10000: begin                     //Branch on greater than zero (btgz)
	        ALUResult <= (A>B)?8'd1:8'd0;
	        if (ALUResult == 1) Zero <= 1;
	        else Zero <= 0;
	    end
        5'b10001: begin                     // Branch if less than or equal to zero (blez)
            ALUResult <= (A<=B)?8'd1:8'd0;
            if (ALUResult == 1) Zero <= 1;
            else Zero <= 0;
        end
	    5'b10010: begin                     //Branch on less than zero (bltz)
            ALUResult <= (A<B)?8'd1:8'd0;
            if (ALUResult == 1) Zero <= 1;
            else Zero <= 0;
        end
        default: begin
            ALUResult = 0; 
            if (ALUResult == 0) Zero <= 1;
            else Zero <= 0;
        end
   endcase
end 
	

endmodule

