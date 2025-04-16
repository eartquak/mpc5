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
    output reg [3:0]opcode_o,
    output reg [3:0]addr_wn_o,
    output reg [3:0]addr_rn1_o,
    output reg [3:0]addr_rn2_o,
    output reg [15:0]imm_o
);

    always @(*) begin
        opcode_o = instr_i[31:28];
        addr_wn_o = instr_i[27:24];
        addr_rn1_o = instr_i[23:20];
        addr_rn2_o = instr_i[19:16];
        imm_o = instr_i[15:0];
    end
endmodule
