`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 02:41:37 AM
// Design Name: 
// Module Name: alu_tb
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


module alu_tb();
    reg [31:0]data_a_i;
    reg [31:0]data_b_i;
    wire [31:0]data_o;
    wire zero_o;
    reg [2:0]alu_c;

    alu alu_m(.data_a_i(data_a_i), .data_b_i(data_b_i), .data_o(data_o), .zero_o(zero_o), .alu_c(alu_c));

    initial begin
        data_a_i = 32'd45;
        data_b_i = 32'd30;
        alu_c = 3'b010;
        #5;

        data_a_i = 32'd30;
        data_b_i = 32'd30;
        alu_c = 3'b110;
        #5;

        data_a_i = 32'd45;
        data_b_i = 32'd30;
        alu_c = 3'b000;
        #5;

        data_a_i = 32'd45;
        data_b_i = 32'd30;
        alu_c = 3'b001;
        #5;

        data_a_i = 32'd45;
        data_b_i = 32'd30;
        alu_c = 3'b111;
        #5;

        $finish;
    end
endmodule
