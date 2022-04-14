`define FIXED_DATA_WIDTH SYM_WIDTH+INT_WIDTH+DEC_WIDTH
(* DONT_TOUCH = "yes" *)
module cordic_iterate #(
    parameter SYM_WIDTH = 1,
    parameter INT_WIDTH = 1,
    parameter DEC_WIDTH = 14,
    parameter n         = 0,  // 表示第n次迭代
    parameter coff      = 0   // 传入预处理参数
) (
    input wire clk,
    input wire en,
    
    input wire signed [`FIXED_DATA_WIDTH-1 : 0] x_0,
    input wire signed [`FIXED_DATA_WIDTH-1 : 0] y_0,
    input wire signed [`FIXED_DATA_WIDTH-1 : 0] z_0,

    output wire signed [`FIXED_DATA_WIDTH-1 : 0] x_1,
    output wire signed [`FIXED_DATA_WIDTH-1 : 0] y_1,
    output wire signed [`FIXED_DATA_WIDTH-1 : 0] z_1
);

wire d;
wire signed [`FIXED_DATA_WIDTH-1 : 0] x_1_r, y_1_r, z_1_r;

assign d = z_0[`FIXED_DATA_WIDTH-1]; //取出符号位
assign z_1_r  = d ? (z_0 + coff) : (z_0 - coff);
assign x_1_r = d ? (x_0+(y_0>>>n)) : (x_0-(y_0>>>n)); 
assign y_1_r = d ? (y_0-(x_0>>>n)) : (y_0+(x_0>>>n)); 

dffl #(`FIXED_DATA_WIDTH) dffl_x (clk, en, x_1_r, x_1);
dffl #(`FIXED_DATA_WIDTH) dffl_y (clk, en, y_1_r, y_1);
dffl #(`FIXED_DATA_WIDTH) dffl_z (clk, en, z_1_r, z_1);

endmodule