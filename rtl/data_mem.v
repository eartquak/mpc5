`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2025 11:35:06 PM
// Design Name: 
// Module Name: data_mem
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


module data_mem #(
    parameter DM_SIZE = 64
) (
    input [31:0]addr_i,
    output reg [31:0]data_o,
    input [31:0]data_i,
    input mem_read_c_i,
    input mem_write_c_i,
    input clk_i,
    input rst_ni
);
    reg [7:0]mem_t[0:DM_SIZE-1];
    integer i;

    always @(*) begin
        if (mem_read_c_i == 1) begin
            for (i = 0; i < 4; i = i + 1)
                data_o[i*8 +: 8] = mem_t[addr_i + i];
        end
    end

    always @(posedge clk_i or negedge rst_ni) begin
        if (rst_ni == 0) begin
            for (i = 0; i < DM_SIZE; i = i + 1)
                mem_t[i] <= 8'b0;
        end
        else begin 
            if (mem_write_c_i == 1) begin
                for (i = 0; i < 4; i = i + 1)
                    mem_t[addr_i + i] <= data_i[i*8 +: 8];
            end
        end
    end
endmodule
