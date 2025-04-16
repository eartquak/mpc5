`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 09:35:36 PM
// Design Name: 
// Module Name: ex_stage
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


module ex_stage (
    input [31:0]data_rn1_i,
    input [31:0]data_rn2_i,
    input [31:0]imm_i,
    input [3:0]addr_wn_i,
    output [31:0]alu_res_o,
    output reg [31:0]data_o,
    output reg [3:0]addr_w_o,
    input alu_src_c_i,
    input mem_to_reg_c_i,
    input reg_write_c_i,
    input mem_read_c_i,
    input mem_write_c_i,
    input [1:0]alu_op_c_i,
    output reg mem_to_reg_c_o,
    output reg reg_write_c_o,
    output reg mem_read_c_o,
    output reg mem_write_c_o
);

    reg [31:0]data_b_i;
    wire [2:0]alu_c;

    always @(*) begin
        data_b_i = alu_src_c_i?imm_i:data_rn2_i;
    end

    // alu_control alu_control_m (
    //     .alu_op_c_i(alu_op_c_i),
    //     .alu_c_o(alu_c)
    // );

    alu alu_m (
        .data_a_i(data_rn1_i),
        .data_b_i(data_b_i),
        .alu_res_o(alu_res_o),
        .alu_c_i(alu_op_c_i)
    );

    always @(*) begin
        data_o = data_rn2_i;
        addr_w_o = addr_wn_i;
        mem_to_reg_c_o = mem_to_reg_c_i;
        reg_write_c_o = reg_write_c_i;
        mem_read_c_o = mem_read_c_i;
        mem_write_c_o = mem_write_c_i;
    end

endmodule
