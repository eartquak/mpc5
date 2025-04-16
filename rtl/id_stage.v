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
    input [31:0]instr_i,
    input [3:0]addr_w_i,
    input [31:0]data_w_i,
    output [31:0]data_rn1_o,
    output [31:0]data_rn2_o,
    output reg [31:0]imm_o,
    output reg [3:0]addr_wn_o,
    input reg_write_c_i,
    output alu_src_c_o,
    output mem_to_reg_c_o,
    output reg_write_c_o,
    output mem_read_c_o,
    output mem_write_c_o,
    output [1:0]alu_op_c_o,
    input clk_i,
    input rst_ni
);
    wire [3:0]opcode;
    wire [3:0]addr_wn;
    wire [3:0]addr_rn1;
    wire [3:0]addr_rn2;
    wire [31:0]imm;

    instr_decode instr_decode_m (
        .instr_i(instr_i),
        .opcode_o(opcode),
        .addr_wn_o(addr_wn),
        .addr_rn1_o(addr_rn1),
        .addr_rn2_o(addr_rn2),
        .imm_o(imm[31:16])
    );

    registers registers_m (
        .addr_rn1_i(addr_rn1),
        .addr_rn2_i(addr_rn2),
        .data_rn1_o(data_rn1_o),
        .data_rn2_o(data_rn2_o),
        .addr_w_i(addr_w_i),
        .data_w_i(data_w_i),
        .reg_write_c_i(reg_write_c_i),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );

    control control_m (
        .opcode_i(opcode),
        .alu_src_c_o(alu_src_c_o),
        .mem_to_reg_c_o(mem_to_reg_c_o),
        .reg_write_c_o(reg_write_c_o),
        .mem_read_c_o(mem_read_c_o),
        .mem_write_c_o(mem_write_c_o),
        .alu_op_c_o(alu_op_c_o)
    );

    always @(*) begin
        addr_wn_o = addr_wn;
        imm_o = imm >>> 16;
    end
endmodule
