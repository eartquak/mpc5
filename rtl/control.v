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
    input [3:0]opcode_i,
    input stall_control_c_i,
    output reg alu_src_c_o,
    output reg mem_to_reg_c_o,
    output reg reg_write_c_o,
    output reg mem_read_c_o,
    output reg mem_write_c_o,
    output reg [1:0]alu_op_c_o
);
    always @(*) begin
        if (stall_control_c_i == 1) begin
            alu_src_c_o = 0;
            mem_to_reg_c_o = 0;
            reg_write_c_o = 0;
            mem_read_c_o = 0;
            mem_write_c_o = 0;
            alu_op_c_o = 2'b00;
        end
        else begin
            case(opcode_i)
                //SW
                4'b0000: begin
                    alu_src_c_o = 1;
                    mem_to_reg_c_o = 1;
                    reg_write_c_o = 0;
                    mem_read_c_o = 0;
                    mem_write_c_o = 1;
                    alu_op_c_o = 2'b11;
                end

                //AND
                4'b0001: begin
                    alu_src_c_o = 0;
                    mem_to_reg_c_o = 0;
                    reg_write_c_o = 1;
                    mem_read_c_o = 0;
                    mem_write_c_o = 0;
                    alu_op_c_o = 2'b00;
                end

                //NOR
                4'b0011: begin
                    alu_src_c_o = 0;
                    mem_to_reg_c_o = 0;
                    reg_write_c_o = 1;
                    mem_read_c_o = 0;
                    mem_write_c_o = 0;
                    alu_op_c_o = 2'b10;
                end

                //ORI
                4'b0111: begin
                    alu_src_c_o = 1;
                    mem_to_reg_c_o = 0;
                    reg_write_c_o = 1;
                    mem_read_c_o = 0;
                    mem_write_c_o = 0;
                    alu_op_c_o = 2'b01;
                end

                //ADD
                4'b1111: begin
                    alu_src_c_o = 0;
                    mem_to_reg_c_o = 0;
                    reg_write_c_o = 1;
                    mem_read_c_o = 0;
                    mem_write_c_o = 0;
                    alu_op_c_o = 2'b11;
                end
                default: begin
                    alu_src_c_o = 0;
                    mem_to_reg_c_o = 0;
                    reg_write_c_o = 0;
                    mem_read_c_o = 0;
                    mem_write_c_o = 0;
                    alu_op_c_o = 2'b00;
                end
            endcase
        end
    end
endmodule
