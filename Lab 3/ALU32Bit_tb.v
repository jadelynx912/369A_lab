`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

	reg [3:0] ALUControl;   // control bits for ALU operation
	reg [31:0] A, B;	        // inputs

	wire [31:0] ALUResult;	// answer
	wire Zero;	        // Zero=1 if ALUResult == 0

    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B), 
        .ALUResult(ALUResult), 
        .Zero(Zero)
    );

	initial begin
	
        A <= 2;
	    B <= 1;
	    ALUControl <= 5'b00001; //3
	    #10
	    ALUControl <= 5'b00010; //1
	    #10
	    ALUControl <= 5'b00011; //2
	    #10
	    ALUControl <= 5'b00100; //4
	    #10
	    ALUControl <= 5'b00101; //1
	    A <= 1;
	    B <= 0;
	    ALUControl <= 5'b00110; //0
	    #10
	    ALUControl <= 5'b00111; //1
	    #10
	    ALUControl <= 5'b01000; //1
	    #10
	    ALUControl <= 5'b01001; //1
	    #10
	    ALUControl <= 5'b01010; //0
	    #10
	    A <= 3;
	    B <= 0;
	    ALUControl <= 5'b01011; //1 and Zero = 1
	    #10
	    A <= 0; //1 and Zero = 1
	    #10
	    ALUControl <= 5'b01100; //1 and Zero = 1
	    A <= 1;
	    ALUControl <= 5'b01100; //0 and Zero = 1
	    #10
	    ALUControl <= 5'b01110; //0 
	    #10
	    ALUControl <= 5'b01111; //1 and Zero = 1
	    #10
	    A <= 0; //0 and Zero = 1
	    #10
	    ALUControl <= 5'b10000; //0 and Zero = 1
	    #10
	    A <= 1;  //1 and Zero = 1
	    #10
	    ALUControl <= 5'b10001; //0 and Zero = 1
	    #10
	    ALUControl <= 5'b10010; //0 and Zero = 1
	    #10
	    ALUControl <= 5'b0; //Zero = 1
	    
	    
	    
	    
	    
	
	end

endmodule

