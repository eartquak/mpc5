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
    input [31:0]data_rs_i,
    input [31:0]data_rt_i,
    input [31:0]imm_i,
    input [5:0]func6_i,
    input [4:0]addr_rt_i,
    input [4:0]addr_rd_i,
    input [31:0]pc_n_seq_i,
    output [31:0]alu_res_o,
    output reg [31:0]data_o,
    output reg [4:0]addr_w_o,
    output reg [31:0]pc_beq_o,
    input reg_dst_c_i,
    input alu_src_c_i,
    input mem_to_reg_c_i,
    input reg_write_c_i,
    input mem_read_c_i,
    input mem_write_c_i,
    input branch_c_i,
    input j_to_pc_c_i,
    input [1:0]alu_op_c_i,
    output reg mem_to_reg_c_o,
    output reg reg_write_c_o,
    output reg mem_read_c_o,
    output reg mem_write_c_o,
    output reg branch_c_o,
    output reg j_to_pc_c_o,
    output zero_c_o
);

    reg [31:0]data_b_i;
    wire [2:0]alu_c;

    always @(*) begin
        data_b_i = alu_src_c_i?imm_i:data_rt_i;
    end

    alu_control alu_control_m (
        .func6_i(func6_i),
        .alu_op_c_i(alu_op_c_i),
        .alu_c_o(alu_c)
    );

    alu alu_m (
        .data_a_i(data_rs_i),
        .data_b_i(data_b_i),
        .alu_res_o(alu_res_o),
        .zero_c_o(zero_c_o),
        .alu_c_i(alu_c)
    );

    always @(*) begin
        pc_beq_o = pc_n_seq_i + (imm_i << 2);
        data_o = data_rt_i;
        addr_w_o = reg_dst_c_i?addr_rd_i:addr_rt_i;
        mem_to_reg_c_o = mem_to_reg_c_i;
        reg_write_c_o = reg_write_c_i;
        mem_read_c_o = mem_read_c_i;
        mem_write_c_o = mem_write_c_i;
        branch_c_o = branch_c_i;
        j_to_pc_c_o = j_to_pc_c_i;
    end

endmodule
