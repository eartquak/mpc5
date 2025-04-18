`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2025 09:08:37 PM
// Design Name: 
// Module Name: core_tb
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


module core_tb ();
    reg clk_i = 1;
    reg rst_ni = 1;

    core core_m (
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );

    always
        #5 clk_i = ~clk_i;

    initial begin
        rst_ni = 0;
        #7 rst_ni = 1;

        #95 $finish;
    end
endmodule
