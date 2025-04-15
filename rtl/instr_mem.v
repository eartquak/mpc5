`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2025 10:35:41 PM
// Design Name: 
// Module Name: instr_mem
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


module instr_mem #(
    parameter IM_SIZE = 32
) (
    input [31:0]addr_i,
    output reg [31:0]instr_o,
    input [31:0]instr_i,
    // input write_instr_c,
    input clk_i,
    input rst_ni
);
    integer i;
    reg [7:0]instr_t[0:IM_SIZE - 1];

    //read instruction
    always @(*) begin
        if (addr_i[1:0] == 2'b0) begin
            for (i = 0; i < 4; i = i + 1)
                instr_o[8*i +: 8] = instr_t[addr_i + i];
        end
        else $display("instruction misaligned");
    end
    
    //write instruction
    always @(posedge clk_i or negedge rst_ni) begin
        if (rst_ni == 0) begin
            for (i = 0; i < IM_SIZE; i = i + 1)
                instr_t[i] <= 8'b0;
        end
        // else begin
        //     if (write_instr_c == 1) begin
        //         if (addr_i[1:0] == 2'b0) begin
        //             for (i = 0; i < 4; i = i + 1)
        //                 instr_t[addr_i + i] <= instr_i[8*i +: 8];
        //         end
        //         else $display("instruction misaligned");
        //     end
        // end
    end
endmodule
