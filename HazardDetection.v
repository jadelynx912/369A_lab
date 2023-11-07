`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2023 12:53:58 PM
// Design Name: 
// Module Name: Fetch_to_Decode
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

//module HazardDetection(instruction, rtExecution, MemReadExecution, MemReadMemory, DecodeRegWrite, PCWrite, MuxControl, rtExecution, rdExecution, rtMemory, rdMemory, regWriteExecution, regWriteMemory);

module HazardDetection(instruction, rdExecution, rdMemory, DecodeRegWrite, PCWrite, MuxControl, regWriteExecution, regWriteMemory);
    input [31:0] instruction;
    //input [4:0] rtExecution, rdExecution, rtMemory, rdMemory;
    input [4:0] rdExecution, rdMemory;
    input regWriteExecution, regWriteMemory;
   // input [1:0] MemReadExecution, MemReadMemory;
    output reg DecodeRegWrite, PCWrite, MuxControl;
    reg [4:0] rs, rt;
    ////// MemReadExecution
    
    
    
    //assign bits through memRead
    
    always @ (*) begin
        rs = instruction[25:21];
        rt = instruction[20:16];
        
        //Execute Stage
//        if ((MemReadExecution != 2'b00) & ((rt == rtExecution) | (rs == rtExecution))) begin
//            PCWrite <= 0;
//            DecodeRegWrite <= 0;
//            MuxControl <= 1;
//        end
//        else begin
//            PCWrite <= 1;
//            DecodeRegWrite <= 0;
//            MuxControl <= 0;
//        end
        
//        //Memory Stage
//        if ((MemReadMemory != 2'b00) & ((rt == rtMemory) | (rs == rtMemory))) begin
//            PCWrite <= 0;
//            DecodeRegWrite <= 0;
//            MuxControl <= 1;
//        end
//        else begin
//            PCWrite <= 1;
//            DecodeRegWrite <= 0;
//            MuxControl <= 0;
//        end
        
        ////Non-memory hazard
        
        /////// Execute Stage
        if ((regWriteExecution == 1) & ((rdExecution == rs) | (rdExecution == rt)))begin
            PCWrite <= 0;
            DecodeRegWrite <= 0;
            MuxControl <= 0;
            
        end        
        
        ////////Memory Stage
         else if ((regWriteMemory == 1) & ((rdMemory == rs) | (rdMemory == rt)))begin
            PCWrite <= 0;
            DecodeRegWrite <= 0;
            MuxControl <= 0;
        end
        else begin
            PCWrite <= 1;
            DecodeRegWrite <= 0;
            MuxControl <= 0;
        end
       
        
    end

endmodule