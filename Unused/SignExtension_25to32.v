`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension_25to32(in, out);
    /* A 16-Bit input word */
    input [25:0] in;
    
    /* A 32-Bit output word */
    output reg [31:0] out;
    
    always @( in ) begin
        out[31:0] <= { {26{in[25]}}, in[25:0] };
    end

endmodule
