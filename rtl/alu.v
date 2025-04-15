`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 12:34:51 AM
// Design Name: 
// Module Name: alu
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


module alu (
    input [31:0]data_a_i,
    input [31:0]data_b_i,
    output reg [31:0]alu_res_o,
    output reg zero_c_o,
    input [2:0]alu_c_i
);
    always @(*) begin
        case (alu_c_i)
            3'b010: alu_res_o = data_a_i + data_b_i;
            3'b110: alu_res_o = data_a_i - data_b_i;
            3'b000: alu_res_o = data_a_i & data_b_i;
            3'b001: alu_res_o = data_a_i | data_b_i;
            3'b111: alu_res_o = (data_a_i < data_b_i)?32'h00000001:32'h00000000;
        endcase

        zero_c_o = (alu_res_o == 32'b0)?32'h00000001:32'h00000000;
    end
endmodule
