`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 04:52:18 PM
// Design Name: 
// Module Name: if_stage
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


module if_stage (
    input pc_write_c_i,
    output [31:0]instr_o,
    input clk_i,
    input rst_ni
);
    reg [31:0]pc_t;

    wire [31:0]pc_n;

    instr_mem instr_mem_m (
        .addr_i(pc_t),
        .instr_o(instr_o),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );

    pc_incr pc_incr_m (
        .pc_i(pc_t),
        .pc_o(pc_n),
        .pc_write_c_i(pc_write_c_i)
    );

    always @(posedge clk_i or negedge rst_ni) begin
        if (rst_ni == 0)
            pc_t <= 32'b0;
        else
            pc_t <= pc_n;
    end

endmodule
