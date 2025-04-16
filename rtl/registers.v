`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2025 10:58:24 PM
// Design Name: 
// Module Name: registers
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


module registers (
    input [3:0]addr_rn1_i,
    input [3:0]addr_rn2_i,
    output reg [31:0]data_rn1_o,
    output reg [31:0]data_rn2_o,
    input [3:0]addr_w_i,
    input [31:0]data_w_i,
    input reg_write_c_i,
    input clk_i,
    input rst_ni
);
    reg [31:0]reg_t[0:16];
    integer i;

    always @(*) begin
        data_rn1_o = reg_t[addr_rn1_i];
        data_rn2_o = reg_t[addr_rn2_i];
    end

    always @(posedge clk_i or negedge rst_ni) begin
        if (rst_ni == 0) begin
            for (i = 0; i < 16; i = i + 1)
                reg_t[i] <= 32'b0;
            reg_t[1] <= 32'd32;
            reg_t[2] <= 32'd21;
        end
        else if (reg_write_c_i == 1) begin
            if (addr_w_i != 0)
                reg_t[addr_w_i] <= data_w_i;
        end
    end
endmodule
