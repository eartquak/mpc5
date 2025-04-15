`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2025 05:03:15 PM
// Design Name: 
// Module Name: wb_stage
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


module wb_stage (
    input [31:0]data_w_1_i,
    input [31:0]data_w_2_i,
    input [4:0]addr_w_i,
    output reg [31:0]data_w_o,
    output reg [4:0]addr_w_o,
    input mem_to_reg_c_i,
    input reg_write_c_i,
    output reg reg_write_c_o
);
    always @(*) begin
        data_w_o = mem_to_reg_c_i?data_w_1_i:data_w_2_i;
        reg_write_c_o = reg_write_c_i;
        addr_w_o = addr_w_i;
    end
endmodule
