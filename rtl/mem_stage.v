`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 10:12:19 PM
// Design Name: 
// Module Name: mem_stage
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


module mem_stage (
    input [31:0]alu_res_i,
    input [31:0]data_i,
    output reg [31:0]data_w_1_o,
    output reg [31:0]data_w_2_o,
    output reg [4:0]addr_w_o,
    input mem_to_reg_c_i,
    input reg_write_c_i,
    input mem_read_c_i,
    input mem_write_c_i,
    input branch_c_i,
    input j_to_pc_c_i,
    input zero_c_i,
    output reg mem_to_reg_c_o,
    output reg reg_write_c_o,
    output reg pc_src_c_o
);

    data_mem data_mem_m (
        .addr_i(alu_res_i),
        .data_o(data_w_1_o),
        .data_i(data_i),
        .mem_read_c(mem_read_c_i),
        .mem_write_c(mem_write_c_i),
        .clk_i(clk_i),
        .rst_ni(rst_ni),
    );

    always @(*) begin
        data_w_2_o = alu_res_i;
        mem_to_reg_c_o = mem_to_reg_c_i;
        reg_write_c_o = reg_write_c_i;
        pc_src_c_o = zero_c_i & branch_c_i;
    end
endmodule
