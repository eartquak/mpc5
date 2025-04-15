`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 03:02:24 AM
// Design Name: 
// Module Name: instr_mem_tb
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


module instr_mem_tb ();
    reg [31:0]addr_i;
    wire [31:0]instr_o;
    reg [31:0]instr_i;
    reg write_instr_c;
    reg clk_i = 1;
    reg rst_ni = 1;

    instr_mem instr_mem_m(
        .addr_i(addr_i),
        .instr_o(instr_o),
        .instr_i(instr_i),
        .write_instr_c(write_instr_c),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );

    always
        #5 clk_i = ~clk_i;
    initial begin
        write_instr_c = 0;
        rst_ni = 0;
        #1;
        rst_ni = 1;
        #1;

        addr_i = 32'b0;
        @(posedge clk_i);

        addr_i = 32'd8;
        instr_i = 32'd128;
        write_instr_c = 1;
        @(posedge clk_i);

        addr_i = 32'd5;
        instr_i = 32'd62;
        write_instr_c = 1;
        @(posedge clk_i);

        addr_i = 32'd12;
        instr_i = 32'd56;
        write_instr_c = 1;
        @(posedge clk_i);

        addr_i = 32'd8;
        write_instr_c = 0;
        @(posedge clk_i);

        addr_i = 32'd12;
        write_instr_c = 0;
        @(posedge clk_i);

        $finish;
    end

endmodule
