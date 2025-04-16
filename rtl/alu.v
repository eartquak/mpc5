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


//ALU Controls
//AND - 00
//OR  - 01
//NOR - 10
//AND - 11

module alu (
    input [31:0]data_a_i,
    input [31:0]data_b_i,
    output reg [31:0]alu_res_o,
    input [1:0]alu_c_i
);
    always @(*) begin
        case (alu_c_i)
            2'b00: alu_res_o = data_a_i & data_b_i;
            2'b01: alu_res_o = data_a_i | data_b_i;
            2'b10: alu_res_o = ~(data_a_i | data_b_i);
            2'b11: alu_res_o = data_a_i + data_b_i;
        endcase
    end
endmodule
