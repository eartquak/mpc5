`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 02:51:59 AM
// Design Name: 
// Module Name: alu_control_tb
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


module alu_control_tb();
    reg [5:0]func6_i;
    reg [1:0]alu_op_c;
    wire [2:0]alu_c;

    alu_control alu_control_m(.func6_i(func6_i), .alu_op_c(alu_op_c), .alu_c(alu_c));

    initial begin
        func6_i = 6'b100011;
        alu_op_c = 2'b00;
        #5;

        func6_i = 6'b101010;
        alu_op_c = 2'b01;
        #5;

        func6_i = 6'b100000;
        alu_op_c = 2'b10;
        #5;

        func6_i = 6'b100010;
        alu_op_c = 2'b10;
        #5;

        func6_i = 6'b110100;
        alu_op_c = 2'b10;
        #5;

        func6_i = 6'b100101;
        alu_op_c = 2'b10;
        #5;

        func6_i = 6'b101010;
        alu_op_c = 2'b10;
        #5;

        $finish;
    end
endmodule
