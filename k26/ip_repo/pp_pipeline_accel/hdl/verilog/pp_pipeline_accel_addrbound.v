// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Version: 2022.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module pp_pipeline_accel_addrbound (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        return_r,
        rows_dout,
        rows_num_data_valid,
        rows_fifo_cap,
        rows_empty_n,
        rows_read,
        cols
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_state2 = 3'd2;
parameter    ap_ST_fsm_state3 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
output  [18:0] return_r;
input  [15:0] rows_dout;
input  [2:0] rows_num_data_valid;
input  [2:0] rows_fifo_cap;
input   rows_empty_n;
output   rows_read;
input  [15:0] cols;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg[18:0] return_r;
reg rows_read;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    rows_blk_n;
reg    ap_block_state1;
reg   [18:0] return_r_preg;
wire    ap_CS_fsm_state3;
wire   [31:0] trunc_ln1540_fu_85_p0;
wire  signed [31:0] grp_fu_130_p2;
wire   [19:0] trunc_ln1540_fu_85_p1;
wire   [31:0] trunc_ln1540_1_fu_96_p0;
wire   [21:0] trunc_ln1540_1_fu_96_p1;
wire   [24:0] shl_ln_fu_88_p3;
wire   [24:0] shl_ln1540_1_fu_99_p3;
wire   [24:0] ret_V_fu_107_p2;
wire   [24:0] add_ln587_fu_113_p2;
wire   [15:0] grp_fu_130_p0;
wire   [15:0] grp_fu_130_p1;
reg    grp_fu_130_ce;
reg   [2:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ST_fsm_state2_blk;
wire    ap_ST_fsm_state3_blk;
wire   [31:0] grp_fu_130_p00;
wire   [31:0] grp_fu_130_p10;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 3'd1;
#0 return_r_preg = 19'd0;
end

pp_pipeline_accel_mul_mul_16ns_16ns_32_3_1 #(
    .ID( 1 ),
    .NUM_STAGE( 3 ),
    .din0_WIDTH( 16 ),
    .din1_WIDTH( 16 ),
    .dout_WIDTH( 32 ))
mul_mul_16ns_16ns_32_3_1_U286(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_fu_130_p0),
    .din1(grp_fu_130_p1),
    .ce(grp_fu_130_ce),
    .dout(grp_fu_130_p2)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if ((1'b1 == ap_CS_fsm_state3)) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        return_r_preg <= 19'd0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state3)) begin
            return_r_preg <= {{add_ln587_fu_113_p2[24:6]}};
        end
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) | (rows_empty_n == 1'b0) | (ap_done_reg == 1'b1))) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

assign ap_ST_fsm_state2_blk = 1'b0;

assign ap_ST_fsm_state3_blk = 1'b0;

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & ((ap_start == 1'b0) | (rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)))) begin
        grp_fu_130_ce = 1'b0;
    end else begin
        grp_fu_130_ce = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        return_r = {{add_ln587_fu_113_p2[24:6]}};
    end else begin
        return_r = return_r_preg;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        rows_blk_n = rows_empty_n;
    end else begin
        rows_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        rows_read = 1'b1;
    end else begin
        rows_read = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((ap_start == 1'b0) | (rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln587_fu_113_p2 = (ret_V_fu_107_p2 + 25'd63);

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

always @ (*) begin
    ap_block_state1 = ((ap_start == 1'b0) | (rows_empty_n == 1'b0) | (ap_done_reg == 1'b1));
end

assign grp_fu_130_p0 = grp_fu_130_p00;

assign grp_fu_130_p00 = cols;

assign grp_fu_130_p1 = grp_fu_130_p10;

assign grp_fu_130_p10 = rows_dout;

assign ret_V_fu_107_p2 = (shl_ln_fu_88_p3 - shl_ln1540_1_fu_99_p3);

assign shl_ln1540_1_fu_99_p3 = {{trunc_ln1540_1_fu_96_p1}, {3'd0}};

assign shl_ln_fu_88_p3 = {{trunc_ln1540_fu_85_p1}, {5'd0}};

assign trunc_ln1540_1_fu_96_p0 = grp_fu_130_p2;

assign trunc_ln1540_1_fu_96_p1 = trunc_ln1540_1_fu_96_p0[21:0];

assign trunc_ln1540_fu_85_p0 = grp_fu_130_p2;

assign trunc_ln1540_fu_85_p1 = trunc_ln1540_fu_85_p0[19:0];

endmodule //pp_pipeline_accel_addrbound
