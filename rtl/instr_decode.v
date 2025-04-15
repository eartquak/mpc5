`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 04:18:14 PM
// Design Name: 
// Module Name: instr_decode
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


module instr_decode (
    input [31:0]instr_i,
    output reg [5:0]opcode_o,
    output reg [4:0]addr_rs_o,
    output reg [25:0]addr_j_o,
    output reg [4:0]addr_rt_o,
    output reg [4:0]addr_rd_o,
    output reg [15:0]imm_o,
    output reg [4:0]shamt_o,
    output reg [5:0]func6_o
);

    always @(*) begin
        opcode_o = instr_i[31:26];
        addr_rs_o = instr_i[25:21];
        addr_j_o = instr_i[25:0];
        addr_rt_o = instr_i[20:16];
        addr_rd_o = instr_i[15:11];
        imm_o = instr_i[15:0];
        shamt_o = instr_i[10:6];
        func6_o = instr_i[5:0];
    end
endmodule
