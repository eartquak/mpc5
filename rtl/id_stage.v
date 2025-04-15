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
    output [31:0]data_rs_o,
    output [31:0]data_rt_o,
    output reg [31:0]imm_o,
    output reg [5:0]func6_o,
    output reg [4:0]addr_rt_o,
    output reg [4:0]addr_rd_o,
    input reg_write_c_i,
    output reg_dst_c_o,
    output alu_src_c_o,
    output mem_to_reg_c_o,
    output reg_write_c_o,
    output mem_read_c_o,
    output mem_write_c_o,
    output branch_c_o,
    output j_to_pc_c_o,
    output [1:0]alu_op_c_o,
    input clk_i,
    input rst_ni
);
    wire [5:0]opcode;
    wire [4:0]addr_rs;
    wire [25:0]addr_j;
    wire [4:0]addr_rt;
    wire [4:0]addr_rd;
    wire [31:0]imm;
    wire [4:0]shamt;
    wire [5:0]func6;

    instr_decode instr_decode_m (
        .instr_i(instr_i),
        .opcode_o(opcode),
        .addr_rs_o(addr_rs),
        .addr_j_o(addr_j),
        .addr_rt_o(addr_rt),
        .addr_rd_o(addr_rd),
        .imm_o(imm[31:16]),
        .shamt_o(shamt),
        .func6_o(func6)
    );

    registers registers_m (
        .addr_rs_i(addr_rs),
        .addr_rt_i(addr_rt),
        .data_rs_o(data_rs_o),
        .data_rt_o(data_rt_o),
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
        .mem_write_c_o(mem_write_c_o),
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
