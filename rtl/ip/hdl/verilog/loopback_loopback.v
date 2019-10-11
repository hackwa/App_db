// ==============================================================
// RTL generated by Scout HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2.0
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="loopback_loopback,hls_ip_2019_2_0,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xcu200-fsgd2104-2-e,HLS_INPUT_CLOCK=3.333000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=0.669000,HLS_SYN_LAT=-1,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=8,HLS_SYN_LUT=86,HLS_VERSION=2019_2_0}" *)

module loopback_loopback (
        ap_clk,
        ap_rst_n,
        input_r_TDATA,
        input_r_TVALID,
        input_r_TREADY,
        input_r_TKEEP,
        input_r_TLAST,
        output_r_TDATA,
        output_r_TVALID,
        output_r_TREADY,
        output_r_TKEEP,
        output_r_TLAST
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_pp0_stage0 = 3'd2;
parameter    ap_ST_fsm_state4 = 3'd4;

input   ap_clk;
input   ap_rst_n;
input  [31:0] input_r_TDATA;
input   input_r_TVALID;
output   input_r_TREADY;
input  [3:0] input_r_TKEEP;
input  [0:0] input_r_TLAST;
output  [31:0] output_r_TDATA;
output   output_r_TVALID;
input   output_r_TREADY;
output  [3:0] output_r_TKEEP;
output  [0:0] output_r_TLAST;

reg input_r_TREADY;

(* shreg_extract = "no" *) reg    ap_rst_reg_2;
(* shreg_extract = "no" *) reg    ap_rst_reg_1;
(* shreg_extract = "no" *) reg    ap_rst_n_inv;
reg    input_r_TDATA_blk_n;
(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
reg    output_r_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter1;
wire   [0:0] tmp_last_V_fu_72_p1;
reg    ap_block_state2_pp0_stage0_iter0;
wire    ap_block_state3_pp0_stage0_iter1;
reg    ap_block_pp0_stage0_11001;
wire    ap_CS_fsm_state1;
reg    ap_block_pp0_stage0_subdone;
reg    ap_block_pp0_stage0_01001;
reg   [2:0] ap_NS_fsm;
wire    ap_CS_fsm_state4;
wire    regslice_both_output_V_data_V_U_apdone_blk;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire    regslice_both_input_V_data_V_U_apdone_blk;
wire   [31:0] input_r_TDATA_int;
wire    input_r_TVALID_int;
reg    input_r_TREADY_int;
wire    regslice_both_input_V_data_V_U_ack_in;
wire    regslice_both_input_V_keep_V_U_apdone_blk;
wire   [3:0] input_r_TKEEP_int;
wire    regslice_both_input_V_keep_V_U_vld_out;
wire    regslice_both_input_V_keep_V_U_ack_in;
wire    regslice_both_input_V_last_V_U_apdone_blk;
wire   [0:0] input_r_TLAST_int;
wire    regslice_both_input_V_last_V_U_vld_out;
wire    regslice_both_input_V_last_V_U_ack_in;
wire   [31:0] output_r_TDATA_int;
reg    output_r_TVALID_int;
wire    output_r_TREADY_int;
wire    regslice_both_output_V_data_V_U_vld_out;
wire    regslice_both_output_V_keep_V_U_apdone_blk;
wire    regslice_both_output_V_keep_V_U_ack_in_dummy;
wire    regslice_both_output_V_keep_V_U_vld_out;
wire    regslice_both_output_V_last_V_U_apdone_blk;
wire    regslice_both_output_V_last_V_U_ack_in_dummy;
wire    regslice_both_output_V_last_V_U_vld_out;

// power-on initialization
initial begin
#0 ap_rst_reg_2 = 1'b1;
#0 ap_rst_reg_1 = 1'b1;
#0 ap_rst_n_inv = 1'b1;
#0 ap_CS_fsm = 3'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

regslice_both #(
    .DataWidth( 32 ))
regslice_both_input_V_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(input_r_TDATA),
    .vld_in(input_r_TVALID),
    .ack_in(regslice_both_input_V_data_V_U_ack_in),
    .data_out(input_r_TDATA_int),
    .vld_out(input_r_TVALID_int),
    .ack_out(input_r_TREADY_int),
    .apdone_blk(regslice_both_input_V_data_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 4 ))
regslice_both_input_V_keep_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(input_r_TKEEP),
    .vld_in(input_r_TVALID),
    .ack_in(regslice_both_input_V_keep_V_U_ack_in),
    .data_out(input_r_TKEEP_int),
    .vld_out(regslice_both_input_V_keep_V_U_vld_out),
    .ack_out(input_r_TREADY_int),
    .apdone_blk(regslice_both_input_V_keep_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 1 ))
regslice_both_input_V_last_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(input_r_TLAST),
    .vld_in(input_r_TVALID),
    .ack_in(regslice_both_input_V_last_V_U_ack_in),
    .data_out(input_r_TLAST_int),
    .vld_out(regslice_both_input_V_last_V_U_vld_out),
    .ack_out(input_r_TREADY_int),
    .apdone_blk(regslice_both_input_V_last_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 32 ))
regslice_both_output_V_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(output_r_TDATA_int),
    .vld_in(output_r_TVALID_int),
    .ack_in(output_r_TREADY_int),
    .data_out(output_r_TDATA),
    .vld_out(regslice_both_output_V_data_V_U_vld_out),
    .ack_out(output_r_TREADY),
    .apdone_blk(regslice_both_output_V_data_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 4 ))
regslice_both_output_V_keep_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(4'd15),
    .vld_in(output_r_TVALID_int),
    .ack_in(regslice_both_output_V_keep_V_U_ack_in_dummy),
    .data_out(output_r_TKEEP),
    .vld_out(regslice_both_output_V_keep_V_U_vld_out),
    .ack_out(output_r_TREADY),
    .apdone_blk(regslice_both_output_V_keep_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 1 ))
regslice_both_output_V_last_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(input_r_TLAST_int),
    .vld_in(output_r_TVALID_int),
    .ack_in(regslice_both_output_V_last_V_U_ack_in_dummy),
    .data_out(output_r_TLAST),
    .vld_out(regslice_both_output_V_last_V_U_vld_out),
    .ack_out(output_r_TREADY),
    .apdone_blk(regslice_both_output_V_last_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (tmp_last_V_fu_72_p1 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if ((1'b1 == ap_CS_fsm_state1)) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if ((1'b1 == ap_CS_fsm_state1)) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    ap_rst_n_inv <= ap_rst_reg_1;
end

always @ (posedge ap_clk) begin
    ap_rst_reg_1 <= ap_rst_reg_2;
end

always @ (posedge ap_clk) begin
    ap_rst_reg_2 <= ~ap_rst_n;
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        input_r_TDATA_blk_n = input_r_TVALID_int;
    end else begin
        input_r_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((regslice_both_input_V_data_V_U_ack_in == 1'b1) & (input_r_TVALID == 1'b1))) begin
        input_r_TREADY = 1'b1;
    end else begin
        input_r_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        input_r_TREADY_int = 1'b1;
    end else begin
        input_r_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        output_r_TDATA_blk_n = output_r_TREADY_int;
    end else begin
        output_r_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        output_r_TVALID_int = 1'b1;
    end else begin
        output_r_TVALID_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        ap_ST_fsm_pp0_stage0 : begin
            if (~((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((1'b1 == ap_CS_fsm_state4) & (regslice_both_output_V_data_V_U_apdone_blk == 1'b0))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd2];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((input_r_TVALID_int == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((output_r_TREADY_int == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((ap_enable_reg_pp0_iter0 == 1'b1) & ((output_r_TREADY_int == 1'b0) | (input_r_TVALID_int == 1'b0))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((output_r_TREADY_int == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((ap_enable_reg_pp0_iter0 == 1'b1) & ((output_r_TREADY_int == 1'b0) | (input_r_TVALID_int == 1'b0))));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter0 = (input_r_TVALID_int == 1'b0);
end

assign ap_block_state3_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign output_r_TDATA_int = (input_r_TDATA_int + 32'd1);

assign output_r_TVALID = regslice_both_output_V_data_V_U_vld_out;

assign tmp_last_V_fu_72_p1 = input_r_TLAST_int;

endmodule //loopback_loopback
