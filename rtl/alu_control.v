`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 01:00:59 AM
// Design Name: 
// Module Name: alu_control
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


module alu_control (
    input [5:0]func6_i,
    input [1:0]alu_op_c_i,
    output reg [2:0]alu_c_o
);
    always @(*) begin
        alu_c_o[2] = alu_op_c_i[0] | (alu_op_c_i[1] & func6_i[1]);
        alu_c_o[1] = (~alu_op_c_i[1]) | (~func6_i[2]);
        alu_c_o[0] = alu_op_c_i[1] & (func6_i[3] | func6_i[0]);
    end
endmodule
