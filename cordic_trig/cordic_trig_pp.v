`define FIXED_DATA_WIDTH SYM_WIDTH+INT_WIDTH+DEC_WIDTH
`define DATA_INT_MSB INT_WIDTH+DEC_WIDTH-1
`define DATA_INT_LSB DEC_WIDTH

module cordic_trig_pp #(
    parameter SYM_WIDTH = 1,
    parameter INT_WIDTH = 1,
    parameter DEC_WIDTH = 14
) (
    input wire clk,
    input wire rstn,
    input wire data_ready,

    input wire signed [`FIXED_DATA_WIDTH-1 : 0] target_rad,

    input wire data_valid,
    output wire signed [`FIXED_DATA_WIDTH-1 : 0] real_sin_rad,
    output wire signed [`FIXED_DATA_WIDTH-1 : 0] real_cos_rad
);

localparam signed [`FIXED_DATA_WIDTH-1 : 0] X_INIT = 'sh26DD;
localparam signed [`FIXED_DATA_WIDTH-1 : 0] Y_INIT = 'sh0000;
localparam DEEPH = 10;

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
wire [DEEPH-1:0] valid_buffer, valid_init;

assign valid_init = {data_ready, valid_buffer[DEEPH-1 : 1]};
assign data_valid = valid_buffer[0];
assign real_sin_rad = y_10;
assign real_cos_rad = x_10;

cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 0, coff_0) 
cordic_iterate_0 (clk, valid_init[DEEPH-1], X_INIT, Y_INIT, target_rad, x_1, y_1, z_1);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 1, coff_1) 
cordic_iterate_1 (clk, valid_init[DEEPH-2], x_1, y_1, z_1, x_2, y_2, z_2);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 2, coff_2) 
cordic_iterate_2 (clk, valid_init[DEEPH-3], x_2, y_2, z_2, x_3, y_3, z_3);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 3, coff_3) 
cordic_iterate_3 (clk, valid_init[DEEPH-4], x_3, y_3, z_3, x_4, y_4, z_4);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 4, coff_4) 
cordic_iterate_4 (clk, valid_init[DEEPH-5], x_4, y_4, z_4, x_5, y_5, z_5);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 5, coff_5) 
cordic_iterate_5 (clk, valid_init[DEEPH-6], x_5, y_5, z_5, x_6, y_6, z_6);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 6, coff_6) 
cordic_iterate_6 (clk, valid_init[DEEPH-7], x_6, y_6, z_6, x_7, y_7, z_7);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 7, coff_7) 
cordic_iterate_7 (clk, valid_init[DEEPH-8], x_7, y_7, z_7, x_8, y_8, z_8);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 8, coff_8) 
cordic_iterate_8 (clk, valid_init[DEEPH-9], x_8, y_8, z_8, x_9, y_9, z_9);
cordic_iterate #(SYM_WIDTH, INT_WIDTH, DEC_WIDTH, 9, coff_9) 
cordic_iterate_9 (clk, valid_init[DEEPH-10], x_9, y_9, z_9, x_10, y_10, z_10);

dffr #(DEEPH) dffr_delay (clk, rstn, valid_init, valid_buffer);

endmodule