`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2025 10:35:41 PM
// Design Name: 
// Module Name: instr_mem
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


module instr_mem #(
    parameter IM_SIZE = 32,
    parameter IM_ADDR_SIZE = 5
) (
    input [31:0]addr_i,
    output reg [31:0]instr_o,
    // input [31:0]instr_i,
    // input write_instr_c,
    input clk_i,
    input rst_ni
);
    integer i;
    reg [7:0]instr_t[0:IM_SIZE - 1];

    //read instruction
    always @(*) begin
        if (addr_i[1:0] == 2'b0) begin
            for (i = 0; i < 4; i = i + 1)
                instr_o[8*i +: 8] = instr_t[addr_i + i];
        end
        else
            $display("instruction misaligned");
    end
    
    //write instruction
    always @(posedge clk_i or negedge rst_ni) begin
        if (rst_ni == 0) begin
            for (i = 0; i < IM_SIZE; i = i + 1)
                instr_t[i] <= 8'b0;
            {instr_t[3], instr_t[2], instr_t[1], instr_t[0]} <= 32'b0000_0000_0010_0001_0000000000001001;
            {instr_t[7], instr_t[6], instr_t[5], instr_t[4]} <= 32'h1413_0000;
            {instr_t[11], instr_t[10], instr_t[9], instr_t[8]} <= 32'h3654_0000;
            {instr_t[15], instr_t[14], instr_t[13], instr_t[12]} <= 32'h7760_4556;
            {instr_t[19], instr_t[18], instr_t[17], instr_t[16]} <= 32'hF9780000;
            
        end
    end
endmodule
