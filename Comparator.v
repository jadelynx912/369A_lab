`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2023 12:53:58 PM
// Design Name: 
// Module Name: Comparator
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
// Percent Effort: Kari Cordes - 33%, William Rains - 33%, Samantha Perry - 33%
// 
//////////////////////////////////////////////////////////////////////////////////

module Comparator(A, B, A_grt_B, A_ls_B, A_eq_B);
  input [3:0] A, B,
  output reg A_grt_B, A_ls_B, A_eq_B;
  
  always@(*) begin
    A_grt_B = 0; A_ls_B = 0; A_eq_B = 0;
    if(A>B) A_grt_B = 1'b1;
    else if(A<B) A_less_B = 1'b1;
    else A_eq_B = 1'b1;
  end


endmodule