`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2025 10:22:40 PM
// Design Name: 
// Module Name: adder_32
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


module adder_32(
    input [31:0]a_i,
    input [31:0]b_i,
    output reg [31:0]s_o,
    output reg c_o
);

    reg [32:0]c = 33'b0;
    reg [31:0]g;
    reg [31:0]p;

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin: gen_gen_prop
            always @(*) begin
                g[i] = a_i[i] & b_i[i];
                p[i] = a_i[i] | b_i[i];
            end
        end
    endgenerate


    genvar j;
    generate
        for (j = 1; j < 33; j = j + 1) begin: gen_carry
            always @(*) begin
                c[i] = g[i-1] | (p[i-1] & c[i-1]);
            end
        end
    endgenerate

    always @(*) begin
        s_o = ((a_i ^ b_i) ^ c[31:0]);
        c_o = c[32];
    end
endmodule
