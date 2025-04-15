`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 01:12:51 AM
// Design Name: 
// Module Name: control
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


module control (
    input [5:0]opcode_i,
    output reg reg_dst_c_o,
    output reg alu_src_c_o,
    output reg mem_to_reg_c_o,
    output reg reg_write_c_o,
    output reg mem_read_c_o,
    output reg mem_write_c_o,
    output reg branch_c_o,
    output reg j_to_pc_c_o,
    output reg [1:0]alu_op_c_o
);
    always @(*) begin
        case(opcode_i)
            //R Type
            6'b000000: begin
                reg_dst_c_o = 1;
                alu_src_c_o = 0;
                mem_to_reg_c_o = 0;
                reg_write_c_o = 1;
                mem_read_c_o = 0;
                mem_write_c_o = 0;
                branch_c_o = 0;
                alu_op_c_o = 2'b10;
                j_to_pc_c_o = 0;
            end

            //LW
            6'b100011: begin
                reg_dst_c_o = 0;
                alu_src_c_o = 1;
                mem_to_reg_c_o = 1;
                reg_write_c_o = 1;
                mem_read_c_o = 1;
                mem_write_c_o = 0;
                branch_c_o = 0;
                alu_op_c_o = 2'b00;
                j_to_pc_c_o = 0;
            end

            //SW
            6'b101011: begin
                reg_dst_c_o = 1; //X
                alu_src_c_o = 1;
                mem_to_reg_c_o = 1; //X
                reg_write_c_o = 0;
                mem_read_c_o = 0;
                mem_write_c_o = 1;
                branch_c_o = 0;
                alu_op_c_o = 2'b00;
                j_to_pc_c_o = 0;
            end

            //BEQ
            6'b000100: begin
                reg_dst_c_o = 1; //X
                alu_src_c_o = 0;
                mem_to_reg_c_o = 1; //X
                reg_write_c_o = 0;
                mem_read_c_o = 0;
                mem_write_c_o = 0;
                branch_c_o = 1;
                alu_op_c_o = 2'b01;
                j_to_pc_c_o = 0;
            end

            //J
            6'b000100: begin
                reg_dst_c_o = 1; //X
                alu_src_c_o = 1; //X
                mem_to_reg_c_o = 1; //X
                reg_write_c_o = 0;
                mem_read_c_o = 0;
                mem_write_c_o = 0;
                branch_c_o = 1;
                alu_op_c_o = 2'b11; //X
                j_to_pc_c_o = 1;
            end
        endcase
    end
endmodule
