`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 10:38:47 PM
// Design Name: 
// Module Name: core
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


module core (
    input clk_i,
    input rst_ni
);  
    reg flush = 0;
    reg stall = 0;


    wire [31:0]pipe_if_id_i;
    wire [31:0]pipe_if_id_o;
    pipe_registers #(.PIPE_SIZE(32)) pipe_if_id_m (
        .pipe_i(pipe_if_id_i),
        .pipe_o(pipe_if_id_o),
        .flush_c_i(flush),
        .stall_c_i(stall),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );
    //31:00 - instr
    
    wire [106:0]pipe_id_ex_i;
    wire [106:0]pipe_id_ex_o;
    pipe_registers #(.PIPE_SIZE(107)) pipe_id_ex_m (
        .pipe_i(pipe_id_ex_i),
        .pipe_o(pipe_id_ex_o),
        .flush_c_i(flush),
        .stall_c_i(stall),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );
    //106:75 - data_1
    //74:43 - data_2
    //42:11 - imm
    //10:7 - wn
    //6 - alu_src_c
    //5 - mem_to_reg_c
    //4 - reg_write_c
    //3 - mem_read_c
    //2 - mem_write_c
    //1:0 - alu_op_c
    
    wire [71:0]pipe_ex_mem_i;
    wire [71:0]pipe_ex_mem_o;
    pipe_registers #(.PIPE_SIZE(72)) pipe_ex_mem_m (
        .pipe_i(pipe_ex_mem_i),
        .pipe_o(pipe_ex_mem_o),
        .flush_c_i(flush),
        .stall_c_i(stall),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );
    //71:40 - alu_res
    //39:8 - data_w
    //7:4 - addr_w
    //3 - mem_to_reg_c
    //2 - reg_write_c
    //1 - mem_read_c
    //0 - mem_write_c
    
    wire [69:0]pipe_mem_wb_i;
    wire [69:0]pipe_mem_wb_o;
    pipe_registers #(.PIPE_SIZE(70)) pipe_mem_wb_m (
        .pipe_i(pipe_mem_wb_i),
        .pipe_o(pipe_mem_wb_o),
        .flush_c_i(flush),
        .stall_c_i(stall),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );
    //69:38 - data_w_1
    //37:6 - data_w_2
    //5:2 - addr_w
    //1 - mem_to_reg_c
    //0 - reg_write_c
    
    wire [3:0]addr_w;
    wire [31:0]data_w;
    wire reg_write_c;
    wire [1:0]fa_c;
    wire [1:0]fb_c;

    reg [3:0]id_ex_addr_rs_reg;
    reg [3:0]id_ex_addr_rt_reg;

    always @(posedge clk_i or negedge rst_ni) begin
        if(rst_ni == 0) begin
            id_ex_addr_rs_reg <= 0;
            id_ex_addr_rt_reg <= 0;
        end
        else begin
            id_ex_addr_rs_reg <= pipe_if_id_o[23:20];
            id_ex_addr_rt_reg <= pipe_if_id_o[19:16];
        end
    end

    forward forward_m (
        .ex_mem_reg_write_c(pipe_ex_mem_o[2]),
        .mem_wb_reg_write_c(pipe_mem_wb_o[1]),
        .ex_mem_addr_rd(pipe_ex_mem_o[7:4]),
        .mem_wb_addr_rd(pipe_ex_mem_o[5:2]),
        .id_ex_addr_rs(id_ex_addr_rs_reg),
        .id_ex_addr_rt(id_ex_addr_rt_reg),
        .fa_c(fa_c),
        .fb_c(fb_c)
    );

    if_stage if_stage_m (
        .instr_o(pipe_if_id_i[31:0]),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );

    id_stage id_stage_m (
        .instr_i(pipe_if_id_o[31:0]),
        .addr_w_i(addr_w),
        .data_w_i(data_w),
        .data_rn1_o(pipe_id_ex_i[106:75]),
        .data_rn2_o(pipe_id_ex_i[74:43]),   
        .imm_o(pipe_id_ex_i[42:11]),
        .addr_wn_o(pipe_id_ex_i[10:7]),
        .reg_write_c_i(reg_write_c),
        .alu_src_c_o(pipe_id_ex_i[6]),
        .mem_to_reg_c_o(pipe_id_ex_i[5]),
        .reg_write_c_o(pipe_id_ex_i[4]),
        .mem_read_c_o(pipe_id_ex_i[3]),
        .mem_write_c_o(pipe_id_ex_i[2]),
        .alu_op_c_o(pipe_id_ex_i[1:0]),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );

    ex_stage ex_stage_m (
        .data_rn1_i(pipe_id_ex_o[106:75]),
        .data_rn2_i(pipe_id_ex_o[74:43]),
        .imm_i(pipe_id_ex_o[42:11]),
        .addr_wn_i(pipe_id_ex_o[10:7]),
        .alu_res_o(pipe_ex_mem_i[71:40]),
        .data_o(pipe_ex_mem_i[39:8]),
        .addr_w_o(pipe_ex_mem_i[7:4]),
        .alu_src_c_i(pipe_id_ex_o[6]),
        .mem_to_reg_c_i(pipe_id_ex_o[5]),
        .reg_write_c_i(pipe_id_ex_o[4]),
        .mem_read_c_i(pipe_id_ex_o[3]),
        .mem_write_c_i(pipe_id_ex_o[2]),
        .alu_op_c_i(pipe_id_ex_o[1:0]),
        .forward_a_c_i(fa_c),
        .forward_b_c_i(fb_c),
        .mem_to_reg_c_o(pipe_ex_mem_i[3]),
        .reg_write_c_o(pipe_ex_mem_i[2]),
        .mem_read_c_o(pipe_ex_mem_i[1]),
        .mem_write_c_o(pipe_ex_mem_i[0]),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );

    mem_stage mem_stage_m (
        .alu_res_i(pipe_ex_mem_o[71:40]),
        .data_i(pipe_ex_mem_o[39:8]),
        .addr_w_i(pipe_ex_mem_o[7:4]),
        .data_w_1_o(pipe_mem_wb_i[69:38]),
        .data_w_2_o(pipe_mem_wb_i[37:6]),
        .addr_w_o(pipe_mem_wb_i[5:2]),
        .mem_to_reg_c_i(pipe_ex_mem_o[3]),
        .reg_write_c_i(pipe_ex_mem_o[2]),
        .mem_read_c_i(pipe_ex_mem_o[1]),
        .mem_write_c_i(pipe_ex_mem_o[0]),
        .mem_to_reg_c_o(pipe_mem_wb_i[1]),
        .reg_write_c_o(pipe_mem_wb_i[0]),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );

    wb_stage wb_stage_m (
        .data_w_1_i(pipe_mem_wb_o[69:38]),
        .data_w_2_i(pipe_mem_wb_o[37:6]),
        .addr_w_i(pipe_mem_wb_o[5:2]),
        .data_w_o(data_w),
        .addr_w_o(addr_w),
        .mem_to_reg_c_i(pipe_mem_wb_o[1]),
        .reg_write_c_i(pipe_mem_wb_o[0]),
        .reg_write_c_o(reg_write_c)
    );
endmodule
