`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 10:40:11 AM
// Design Name: 
// Module Name: control_tb
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


module control_tb ();
    reg [5:0]opcode_i;
    wire reg_dst_c;
    wire alu_src_c;
    wire mem_to_reg_c;
    wire reg_write_c;
    wire mem_read_c;
    wire mem_write_c;
    wire branch_c;
    wire [1:0]alu_op_c;

    control control_m (
        .opcode_i(opcode_i),
        .reg_dst_c(reg_dst_c),
        .alu_src_c(alu_src_c),
        .mem_to_reg_c(mem_to_reg_c),
        .reg_write_c(reg_write_c),
        .mem_read_c(mem_read_c),
        .mem_write_c(mem_write_c),
        .branch_c(branch_c),
        .alu_op_c(alu_op_c)
    );

    initial begin
        opcode_i = 6'b000000;
        #5;

        opcode_i = 6'b100011;
        #5;

        opcode_i = 6'b101011;
        #5;

        opcode_i = 6'b000100;
        #5;

        $finish;
    end
endmodule
