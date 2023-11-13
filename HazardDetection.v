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

module HazardDetection(instruction, Branch, MemReadExecution, MemReadMemory, rdExecution, rdMemory, regWriteExecution, regWriteMemory, DecodeRegWrite, PCWrite, MuxControl, flushControl);
    input [31:0] instruction;
    input [4:0] rdExecution, rdMemory;
    input regWriteExecution, regWriteMemory, Branch;
    input [1:0] MemReadExecution, MemReadMemory;
    
    output reg DecodeRegWrite, PCWrite, MuxControl, flushControl;
    reg [4:0] rs, rt;
        
    reg [3:0] path;
    always @ (*) begin
        rs = instruction[25:21];
        rt = instruction[20:16];
                
        /////// Execute Stage
        //r-type followed by branch
        if ((Branch == 1) & (rdMemory != 0) & (regWriteMemory == 1) & ((rdMemory == rs) | (rdMemory == rt))) begin
            PCWrite <= 0;
            DecodeRegWrite <= 0;
            MuxControl <= 0;
            flushControl <= 1;
            path <= 3;
        end
        
        else if ((Branch == 1) & (rdExecution != 0) & (regWriteExecution == 1) & ((rdExecution == rs) | (rdExecution == rt))) begin
            PCWrite <= 0;
            DecodeRegWrite <= 0;
            MuxControl <= 0;
            flushControl <= 1;
            path <= 4;
        end
        //lw followed by branch
        else if ((Branch == 1) & (rdMemory != 0) & ((MemReadMemory != 2'b00) & ((rt == rdMemory) | (rs == rdMemory)))) begin
        //MemReadMemory, MemReadExecute, regWriteExecute; 
            PCWrite <= 0;
            DecodeRegWrite <= 0;
            MuxControl <= 0;
            flushControl <= 1;
            path <= 5;
        end

        else if((Branch == 1) & (rdExecution != 0) & (MemReadExecution != 2'b00) & ((rt == rdExecution) | (rs == rdExecution))) begin
        //MemReadMemory, MemReadExecute, regWriteExecute; 
            PCWrite <= 0;
            DecodeRegWrite <= 0;
            MuxControl <= 0;
            flushControl <= 1;
            path <= 6;
        end
//Above 2 might be able to be combined - I think they can

        //r-type followed by JR
        else if (((instruction[31:26] == 6'b000000) & (instruction[5:0] == 6'b001000)) & (((rdMemory != 0) & (regWriteMemory == 1) & (rdMemory == 31)) | ((rdExecution != 0) &(regWriteExecution == 1) & ((rdExecution == 31))))) begin
            PCWrite <= 0;
            DecodeRegWrite <= 0;
            MuxControl <= 0;
            flushControl <= 1;
            path <= 7;
        end        
        
        //lw followed by JR
        //checks both opcode and func
        else if (((instruction[31:26] == 6'b000000) & (instruction[5:0] == 6'b001000)) & (((rdMemory != 0) & (MemReadMemory != 2'b00) & (rdMemory == 31)) | ((rdExecution != 0) & (MemReadExecution != 2'b00) & (rdExecution == 31)))) begin
            PCWrite <= 0;
            DecodeRegWrite <= 0;
            MuxControl <= 0;
            flushControl <= 1;
            path <= 8;
        end     
           
        else if ((rdExecution != 0) & (regWriteExecution == 1) & ((rdExecution == rs) | (rdExecution == rt)))begin //nop
            PCWrite <= 0;
            DecodeRegWrite <= 0;
            MuxControl <= 0;
            flushControl <= 0;
            path <= 1;
            
        end        
        ////////Memory Stage
         else if ((rdMemory != 0) & (regWriteMemory == 1) & ((rdMemory == rs) | (rdMemory == rt)))begin //nop
            PCWrite <= 0;
            DecodeRegWrite <= 0;
            MuxControl <= 0;
            flushControl <= 0;
            path <= 2;
        end
        
        else begin //Normal function
            PCWrite <= 1;
            DecodeRegWrite <= 1;
            MuxControl <= 1;
            flushControl <= 0;
            path <= 9;
        end
        
        
        
                
        if (Branch == 1) begin
            flushControl <= 1;
        
        end
    end

endmodule

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