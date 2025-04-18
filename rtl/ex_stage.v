`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 09:35:36 PM
// Design Name: 
// Module Name: ex_stage
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


module ex_stage (
    input [31:0]data_rn1_i,
    input [31:0]data_rn2_i,
    input [31:0]imm_i,
    input [3:0]addr_wn_i,
    input [31:0]data_rn_mem_i,
    input [31:0]data_rn_wb_i,
    output [31:0]alu_res_o,
    output reg [31:0]data_o,
    output reg [3:0]addr_w_o,
    input alu_src_c_i,
    input mem_to_reg_c_i,
    input reg_write_c_i,
    input mem_read_c_i,
    input mem_write_c_i,
    input [1:0]alu_op_c_i,
    input [1:0]forward_a_c_i,
    input [1:0]forward_b_c_i,
    output reg mem_to_reg_c_o,
    output reg reg_write_c_o,
    output reg mem_read_c_o,
    output reg mem_write_c_o
);

    reg [31:0]data_a_i;
    reg [31:0]data_b_i;
    reg [31:0]alu_res_o_t;
    reg [31:0]alu_res_o_tt;
    
    always @(*) begin
        case(forward_a_c_i)
            2'b00: data_a_i = data_rn1_i;
            2'b01: data_a_i = data_rn_wb_i;
            2'b10: data_a_i = data_rn_mem_i;
        endcase

        if (alu_src_c_i == 1)
            data_b_i = imm_i;
        else begin 
            case(forward_b_c_i)
                2'b00: data_b_i = data_rn2_i;
                2'b01: data_b_i = data_rn_wb_i;
                2'b10: data_b_i = data_rn_mem_i;
            endcase
        end
    end

    alu alu_m (
        .data_a_i(data_a_i),
        .data_b_i(data_b_i),
        .alu_res_o(alu_res_o),
        .alu_c_i(alu_op_c_i)
    );
    
    always @(*) begin
        data_o = data_rn2_i;
        addr_w_o = addr_wn_i;
        mem_to_reg_c_o = mem_to_reg_c_i;
        reg_write_c_o = reg_write_c_i;
        mem_read_c_o = mem_read_c_i;
        mem_write_c_o = mem_write_c_i;
    end

endmodule
