`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 10:22:31 AM
// Design Name: 
// Module Name: registers_tb
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


module registers_tb ();
    reg [4:0]addr_a_i;
    reg [4:0]addr_b_i;
    wire [31:0]data_a_o;
    wire [31:0]data_b_o;
    reg [4:0]addr_w_i;
    reg [31:0]data_w_i;
    reg reg_write_c;
    reg clk_i = 1;
    reg rst_ni = 1;

    registers registers_m(
        .addr_a_i(addr_a_i),
        .addr_b_i(addr_b_i),
        .data_a_o(data_a_o),
        .data_b_o(data_b_o),
        .addr_w_i(addr_w_i),
        .data_w_i(data_w_i),
        .reg_write_c(reg_write_c),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );

    always
        #5 clk_i = ~clk_i;

    initial begin
        reg_write_c = 0;
        rst_ni = 0;
        #1;
        rst_ni = 1;
        #1;

        addr_a_i = 5'd1;
        addr_b_i = 5'd3;
        reg_write_c = 0;
        @(posedge clk_i);

        addr_w_i = 5'd8;
        data_w_i = 32'd128;
        reg_write_c = 1;
        @(posedge clk_i);

        addr_w_i = 5'd5;
        data_w_i = 32'd62;
        reg_write_c = 1;
        @(posedge clk_i);

        addr_w_i = 5'd12;
        data_w_i = 32'd56;
        reg_write_c = 1;
        @(posedge clk_i);

        addr_a_i = 5'd8;
        addr_b_i = 5'd5;
        reg_write_c = 0;
        @(posedge clk_i);

        addr_a_i = 5'd12;
        addr_b_i = 5'd2;
        reg_write_c = 0;
        @(posedge clk_i);

        $finish;
    end
endmodule
