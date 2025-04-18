`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2025 12:49:49 PM
// Design Name: 
// Module Name: hazard_detect
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


module hazard_detect (
    input mem_read_ex_c_i,
    input [3:0]addr_wn_ex_i,
    input [3:0]addr_rn2_id_i,
    input [3:0]addr_rn1_id_i,
    output reg stall_if_id_c_o,
    output reg pc_write_c_o,
    output reg stall_control_c_o
);
    always @(*) begin
        if ((mem_read_ex_c_i == 1) && ((addr_wn_ex_i == addr_rn2_id_i) || (addr_wn_ex_i == addr_rn1_id_i))) begin
            stall_if_id_c_o = 1;
            pc_write_c_o = 0;
            stall_control_c_o = 1;
        end
        else begin
            stall_if_id_c_o = 0;
            pc_write_c_o = 1;
            stall_control_c_o = 0;
        end
    end
endmodule
