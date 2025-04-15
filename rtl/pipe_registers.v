`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2025 07:34:54 PM
// Design Name: 
// Module Name: pipe_registers
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


module pipe_registers #(
    parameter PIPE_SIZE = 64
) (
    input [PIPE_SIZE-1:0]pipe_i,
    output reg [PIPE_SIZE-1:0]pipe_o,
    input stall_c_i,
    input flush_c_i,
    input clk_i,
    input rst_ni
);
    reg [PIPE_SIZE-1:0]pipe_t;

    always @(posedge clk_i or negedge rst_ni) begin
        if (rst_ni == 0)
            pipe_t <= {PIPE_SIZE{1'b0}};
        else begin
            if (flush_c_i == 1)
                pipe_t <= {PIPE_SIZE{1'b0}};
            else
                pipe_t <= stall_c_i?pipe_t:pipe_i;
        end
    end

    always @(*) begin
        pipe_o = pipe_t;
    end

endmodule
