`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2025 09:52:20 PM
// Design Name: 
// Module Name: pc_incr
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


module pc_incr (
    input [31:0]pc_i,
    output reg [31:0]pc_o
);
    reg [32:2]c = 30'h0000001;

    genvar i;
    generate
        for (i = 3; i < 33; i = i + 1) begin: gen_carry
            always @(*)
                c[i] = pc_i[i-1] & c[i-1];
        end
    endgenerate

    always @(*) begin
        pc_o = {(pc_i[31:2] ^ c[31:2]), pc_i[1:0]};
    end


endmodule
