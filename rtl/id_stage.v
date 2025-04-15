`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 06:20:17 PM
// Design Name: 
// Module Name: id_stage
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


module id_stage (
    input [31:0]pc_n_seq_i,
    input [31:0]instr_i,
    input [4:0]addr_w_i,
    input [31:0]data_w_i,
    output reg [31:0]pc_n_seq_o,
    output reg [31:0]data_rs_o,
    output reg [31:0]data_rt_o,
    output reg [31:0]imm_o,
    output reg [5:0]func6_o,
    output reg [4:0]addr_rt_o,
    output reg [4:0]addr_rd_o,
    input reg_write_c_i,
    output reg reg_dst_c_o,
    output reg alu_src_c_o,
    output reg mem_to_reg_c_o,
    output reg reg_write_c_o,
    output reg mem_read_c_o,
    output reg mem_write_c_o,
    output reg branch_c_o,
    output reg j_to_pc_c_o,
    output reg [1:0]alu_op_c_o,
    input clk_i,
    input rst_ni
);
    reg [5:0]opcode;
    reg [4:0]addr_rs;
    reg [25:0]addr_j;
    reg [4:0]addr_rt;
    reg [4:0]addr_rd;
    reg [31:0]imm;
    reg [4:0]shamt;
    reg [5:0]func6;

    instr_decode instr_decode_m (
        .instr_i(instr_i),
        .opcode_o(opcode_o),
        .addr_rs_o(addr_rs),
        .addr_j_o(addr_j),
        .addr_rt_o(addr_rt),
        .addr_rd_o(addr_rd),
        .imm_o(imm[31:16]),
        .shamt_o(shamt),
        .func6_o(func6)
    );

    registers registers_m (
        .addr_1_i(addr_rs),
        .addr_2_i(addr_rt),
        .data_1_o(data_rs_o),
        .data_2_o(data_rt_o),
        .addr_w_i(addr_w_i),
        .data_w_i(data_w_i),
        .reg_write_c_i(reg_write_c_i),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );

    control control_m (
        .opcode_i(opcode),
        .reg_dst_c_o(reg_dst_c_o),
        .alu_src_c_o(alu_src_c_o),
        .mem_to_reg_c_o(mem_to_reg_c_o),
        .reg_write_c_o(reg_write_c_o),
        .mem_read_c_o(mem_read_c_o),
        .mem_write_c_o(mem_read_c_o),
        .branch_c_o(branch_c_o),
        .j_to_pc_c_o(j_to_pc_c_o),
        .alu_op_c_o(alu_op_c_o)
    );

    always @(*) begin
        pc_n_seq_o = pc_n_seq_i;
        addr_rt_o = addr_rt;
        addr_rd_o = addr_rd;
        func6_o = func6;
        imm_o = imm >>> 16;
    end
endmodule
