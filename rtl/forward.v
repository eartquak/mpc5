
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2025 02:16:34 AM
// Design Name: 
// Module Name: forward
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


module forward(
    input ex_mem_reg_write_c,
    input mem_wb_reg_write_c,
    input [3:0]ex_mem_addr_rd,
    input [3:0]mem_wb_addr_rd,
    input [3:0]id_ex_addr_rs,
    input [3:0]id_ex_addr_rt,
    output reg [1:0]fa_c,
    output reg [1:0]fb_c
    );

    always @ (*) begin
        if(ex_mem_reg_write_c == 1 && ex_mem_addr_rd !== 4'd0 && ex_mem_addr_rd == id_ex_addr_rs)
            fa_c = 2'b10;
        else if(mem_wb_reg_write_c == 1 && mem_wb_addr_rd !== 4'd0 && mem_wb_addr_rd == id_ex_addr_rs)
            fa_c = 2'b01;
        else
            fa_c = 2'b00;

        if(ex_mem_reg_write_c == 1 && ex_mem_addr_rd !== 4'd0 && ex_mem_addr_rd == id_ex_addr_rt)
            fb_c = 2'b10;
        else if(mem_wb_reg_write_c == 1 && mem_wb_addr_rd !== 4'd0 && mem_wb_addr_rd == id_ex_addr_rt)
            fb_c = 2'b01;
        else
            fb_c = 2'b00;
    end

endmodule
