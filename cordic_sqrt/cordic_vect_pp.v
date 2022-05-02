`define FIXED_DATA_WIDTH SYM_WIDTH+INT_WIDTH+DEC_WIDTH

// 计算结果 sqrt = K*(x^2 + y^2)^0.5
// 其中伸缩因子 K = 1.6467
module cordic_vect_pp #(
    parameter SYM_WIDTH = 1,
    parameter INT_WIDTH = 1,
    parameter DEC_WIDTH = 14
)(
    input wire clk,
    input wire rstn,
    input wire data_ready,

    input wire signed [`FIXED_DATA_WIDTH-1 : 0] init_x,
    input wire signed [`FIXED_DATA_WIDTH-1 : 0] init_y,
    input wire signed [`FIXED_DATA_WIDTH-1 : 0] init_z,

    output wire data_valid,
    output wire signed [`FIXED_DATA_WIDTH-1 : 0] sqrt
);

localparam signed [`FIXED_DATA_WIDTH-1 : 0] coff_0 = 'sh3242; //0.7853
localparam signed [`FIXED_DATA_WIDTH-1 : 0] coff_1 = 'sh1DAB; //0.4636
localparam signed [`FIXED_DATA_WIDTH-1 : 0] coff_2 = 'sh0FAC; //0.2449
localparam signed [`FIXED_DATA_WIDTH-1 : 0] coff_3 = 'sh07F6; //0.1244
localparam signed [`FIXED_DATA_WIDTH-1 : 0] coff_4 = 'sh03FE; //0.0624
localparam signed [`FIXED_DATA_WIDTH-1 : 0] coff_5 = 'sh01FF; //0.0312
localparam signed [`FIXED_DATA_WIDTH-1 : 0] coff_6 = 'sh00FF; //0.0156
localparam signed [`FIXED_DATA_WIDTH-1 : 0] coff_7 = 'sh007F; //0.0078
localparam signed [`FIXED_DATA_WIDTH-1 : 0] coff_8 = 'sh003F; //0.0039
localparam signed [`FIXED_DATA_WIDTH-1 : 0] coff_9 = 'sh0020; //0.0020

wire signed [`FIXED_DATA_WIDTH-1 : 0] x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8, x_9, x_10;
wire signed [`FIXED_DATA_WIDTH-1 : 0] y_1, y_2, y_3, y_4, y_5, y_6, y_7, y_8, y_9, y_10;
wire signed [`FIXED_DATA_WIDTH-1 : 0] z_1, z_2, z_3, z_4, z_5, z_6, z_7, z_8, z_9, z_10;

wire en_u0_u1, en_u1_u2, en_u2_u3, en_u3_u4, en_u4_u5, en_u5_u6, en_u6_u7, en_u7_u8, en_u8_u9, en_u9_u10;

assign sqrt = x_10;
assign data_valid = en_u9_u10;

cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 0, coff_0) 
cordic_iterate_0 (clk, data_ready, init_x, init_y, init_z, en_u0_u1, x_1, y_1, z_1);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 1, coff_1) 
cordic_iterate_1 (clk, en_u0_u1, x_1, y_1, z_1, en_u1_u2, x_2, y_2, z_2);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 2, coff_2) 
cordic_iterate_2 (clk, en_u1_u2, x_2, y_2, z_2, en_u2_u3, x_3, y_3, z_3);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 3, coff_3) 
cordic_iterate_3 (clk, en_u2_u3, x_3, y_3, z_3, en_u3_u4, x_4, y_4, z_4);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 4, coff_4) 
cordic_iterate_4 (clk, en_u3_u4, x_4, y_4, z_4, en_u4_u5, x_5, y_5, z_5);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 5, coff_5) 
cordic_iterate_5 (clk, en_u4_u5, x_5, y_5, z_5, en_u5_u6, x_6, y_6, z_6);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 6, coff_6) 
cordic_iterate_6 (clk, en_u5_u6, x_6, y_6, z_6, en_u6_u7, x_7, y_7, z_7);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 7, coff_7) 
cordic_iterate_7 (clk, en_u6_u7, x_7, y_7, z_7, en_u7_u8, x_8, y_8, z_8);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 8, coff_8) 
cordic_iterate_8 (clk, en_u7_u8, x_8, y_8, z_8, en_u8_u9, x_9, y_9, z_9);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 9, coff_9) 
cordic_iterate_9 (clk, en_u8_u9, x_9, y_9, z_9, en_u9_u10, x_10, y_10, z_10);

endmodule 