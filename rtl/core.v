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


    wire [63:0]pipe_if_id_i;
    wire [63:0]pipe_if_id_o;
    pipe_registers #(.PIPE_SIZE(64)) pipe_if_id_m (
        .pipe_i(pipe_if_id_i),
        .pipe_o(pipe_if_id_o),
        .flush_c_i(flush),
        .stall_c_i(stall),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );
    //63:32 - pc_n_seq
    //31:00 - instr
    
    wire [153:0]pipe_id_ex_i;
    wire [153:0]pipe_id_ex_o;
    pipe_registers #(.PIPE_SIZE(154)) pipe_id_ex_m (
        .pipe_i(pipe_id_ex_i),
        .pipe_o(pipe_id_ex_o),
        .flush_c_i(flush),
        .stall_c_i(stall),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );
    //153:122 - pc_n_seq
    //121:90 - data_1
    //89:58 - data_2
    //57:26 - imm
    //25:20 - func6
    //19:15 - rt
    //14:10 - rd
    //9 - reg_dst_c
    //8 - alu_src_c
    //7 - mem_to_reg_c
    //6 - reg_write_c
    //5 - mem_read_c
    //4 - mem_write_c
    //3 - branch_c
    //2 - j_to_pc_c
    //1:0 - alu_op_c
    
    wire [107:0]pipe_ex_mem_i;
    wire [107:0]pipe_ex_mem_o;
    pipe_registers #(.PIPE_SIZE(108)) pipe_ex_mem_m (
        .pipe_i(pipe_ex_mem_i),
        .pipe_o(pipe_ex_mem_o),
        .flush_c_i(flush),
        .stall_c_i(stall),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );
    //107:76 - pc_beq
    //75:44 - alu_res
    //43:12 - data_2
    //11:7 - addr_w
    //6 - mem_to_reg_c
    //5 - reg_write_c
    //4 - mem_read_c
    //3 - mem_write_c
    //2 - branch_c
    //1 - j_to_pc_c
    //0 - zero_c
    
    wire [71:0]pipe_mem_wb_i;
    wire [71:0]pipe_mem_wb_o;
    pipe_registers #(.PIPE_SIZE(72)) pipe_mem_wb_m (
        .pipe_i(pipe_mem_wb_i),
        .pipe_o(pipe_mem_wb_o),
        .flush_c_i(flush),
        .stall_c_i(stall),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );
    //71:40 - data_w_1
    //39:8 - data_w_2
    //7:3 - addr_w
    //2 - mem_to_reg_c
    //1 - reg_write_c
    //0 - j_to_pc_c
    
    wire pc_src_c;
    wire [4:0]addr_w;
    wire [31:0]data_w;
    wire reg_write_c;

    if_stage if_stage_m (
        .pc_beq_i(pipe_ex_mem_o[107:76]),
        .pc_n_seq_o(pipe_if_id_i[63:32]),
        .instr_o(pipe_if_id_i[31:0]),
        .pc_src_c_i(pc_src_c),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );

    id_stage id_stage_m (
        .pc_n_seq_i(pipe_if_id_o[63:32]),
        .instr_i(pipe_if_id_o[31:0]),
        .addr_w_i(addr_w),
        .data_w_i(data_w),
        .pc_n_seq_o(pipe_id_ex_i[153:122]),
        .data_rs_o(pipe_id_ex_i[121:90]),
        .data_rt_o(pipe_id_ex_i[89:58]),
        .imm_o(pipe_id_ex_i[57:26]),
        .func6_o(pipe_id_ex_i[25:20]),
        .addr_rt_o(pipe_id_ex_i[19:15]),
        .addr_rd_o(pipe_id_ex_i[14:10]),
        .reg_write_c_i(reg_write_c),
        .reg_dst_c_o(pipe_id_ex_i[9]),
        .alu_src_c_o(pipe_id_ex_i[8]),
        .mem_to_reg_c_o(pipe_id_ex_i[7]),
        .reg_write_c_o(pipe_id_ex_i[6]),
        .mem_read_c_o(pipe_id_ex_i[5]),
        .mem_write_c_o(pipe_id_ex_i[4]),
        .branch_c_o(pipe_id_ex_i[3]),
        .j_to_pc_c_o(pipe_id_ex_i[2]),
        .alu_op_c_o(pipe_id_ex_i[1:0]),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );

    ex_stage ex_stage_m (
        .data_rs_i(pipe_id_ex_o[121:90]),
        .data_rt_i(pipe_id_ex_o[89:58]),
        .imm_i(pipe_id_ex_o[57:26]),
        .func6_i(pipe_id_ex_o[25:20]),
        .addr_rt_i(pipe_id_ex_o[19:15]),
        .addr_rd_i(pipe_id_ex_o[14:10]),
        .pc_n_seq_i(pipe_id_ex_o[153:122]),
        .alu_res_o(pipe_ex_mem_i[75:44]),
        .data_o(pipe_ex_mem_i[43:12]),
        .addr_w_o(pipe_ex_mem_i[11:7]),
        .pc_beq_o(pipe_ex_mem_i[107:76]),
        .reg_dst_c_i(pipe_id_ex_o[9]),
        .alu_src_c_i(pipe_id_ex_o[8]),
        .mem_to_reg_c_i(pipe_id_ex_o[7]),
        .reg_write_c_i(pipe_id_ex_o[6]),
        .mem_read_c_i(pipe_id_ex_o[5]),
        .mem_write_c_i(pipe_id_ex_o[4]),
        .branch_c_i(pipe_id_ex_o[3]),
        .j_to_pc_c_i(pipe_id_ex_o[2]),
        .alu_op_c_i(pipe_id_ex_o[1:0]),
        .mem_to_reg_c_o(pipe_ex_mem_i[6]),
        .reg_write_c_o(pipe_ex_mem_i[5]),
        .mem_read_c_o(pipe_ex_mem_i[4]),
        .mem_write_c_o(pipe_ex_mem_i[3]),
        .branch_c_o(pipe_ex_mem_i[2]),
        .j_to_pc_c_o(pipe_ex_mem_i[1]),
        .zero_c_o(pipe_ex_mem_i[0])
    );

    mem_stage mem_stage_m (
        .alu_res_i(pipe_ex_mem_o[75:44]),
        .data_i(pipe_ex_mem_o[43:12]),
        .addr_w_i(pipe_ex_mem_o[11:7]),
        .data_w_1_o(pipe_mem_wb_i[71:40]),
        .data_w_2_o(pipe_mem_wb_i[39:8]),
        .addr_w_o(pipe_mem_wb_i[7:3]),
        .mem_to_reg_c_i(pipe_ex_mem_o[6]),
        .reg_write_c_i(pipe_ex_mem_o[5]),
        .mem_read_c_i(pipe_ex_mem_o[4]),
        .mem_write_c_i(pipe_ex_mem_o[3]),
        .branch_c_i(pipe_ex_mem_o[2]),
        .j_to_pc_c_i(pipe_ex_mem_o[1]),
        .zero_c_i(pipe_ex_mem_o[0]),
        .mem_to_reg_c_o(pipe_mem_wb_i[2]),
        .reg_write_c_o(pipe_mem_wb_i[1]),
        .pc_src_c_o(pc_src_c),
        .clk_i(clk_i),
        .rst_ni(rst_ni)
    );

    wb_stage wb_stage_m (
        .data_w_1_i(pipe_mem_wb_o[71:40]),
        .data_w_2_i(pipe_mem_wb_o[39:8]),
        .addr_w_i(pipe_mem_wb_o[7:3]),
        .data_w_o(data_w),
        .addr_w_o(addr_w),
        .mem_to_reg_c_i(pipe_mem_wb_o[2]),
        .reg_write_c_i(pipe_mem_wb_o[1]),
        .reg_write_c_o(reg_write_c)
    );
endmodule
