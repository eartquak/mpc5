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
    input [4:0]addr_1_i,
    input [4:0]addr_2_i,
    output reg [31:0]data_1_o,
    output reg [31:0]data_2_o,
    input [4:0]addr_w_i,
    input [31:0]data_w_i,
    input reg_write_c_i,
    input clk_i,
    input rst_ni
);
    reg [31:0]reg_t[0:31];
    integer i;

    always @(*) begin
        data_rs_o = reg_t[addr_1_i];
        data_rt_o = reg_t[addr_2_i];
    end

    always @(posedge clk_i or negedge rst_ni) begin
        if (rst_ni == 0) begin
            for (i = 0; i < 32; i = i + 1)
                reg_t[i] <= 32'b0;
        end
        else if (reg_write_c_i == 1) begin
            if (addr_w_i != 0)
                reg_t[addr_w_i] <= data_w_i;
        end
    end
endmodule
