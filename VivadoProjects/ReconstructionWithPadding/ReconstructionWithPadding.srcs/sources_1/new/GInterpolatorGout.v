`timescale 1ns / 1ps

module GInterpolatorGout
                #
                (
                    parameter NBits = 8,
                    parameter IMWIDTH = 100,
                    parameter IMHEIGHT = 100
                )
                (
                    input wire [8-1:0]R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14,
                    input wire [$clog2(255 + 255 + 255)-1:0]DV_out,
                    input wire [$clog2(255 + 255 + 255)-1:0]DH_out,
                    output wire [10-1:0]Gout
                );


wire [9-1:0]G_t1, G_t2, G_t3;

assign G_t1 = R6 + R8;
assign G_t2 = R2 + R12;
assign G_t3 = R5 + R9;

wire [8-1:0]G1_o1;
Multiply3by8 #(.NBits(9)) mm (.inp(G_t1), .outp(G1_o1));
wire [6-1:0]G1_o2;
assign G1_o2 = G_t2>>3;
wire [7-1:0]G1_o3;
assign G1_o3 = G_t3>>2;

wire [10-1:0]G1;
assign G1 = G1_o1 + G1_o2 + (R7>>1) - G1_o3;



wire [8-1:0]G2_o1;
assign G2_o1 = G_t1>>1;
wire [6-1:0]G2_o2;
assign G2_o2 = 0;
wire [7-1:0]G2_o3;
assign G2_o3 = G_t3>>2;

wire [10-1:0]G2;
assign G2 = G2_o1 + G2_o2 + (R7>>1) - G2_o3;


wire [6-1:0]G3_o1;
assign G3_o1 = G_t1>>3;
wire [8-1:0]G3_o2;
Multiply3by8 #(.NBits(9)) mm2 (.inp(G_t2), .outp(G3_o2));
wire [6-1:0]G3_o3;
assign G3_o3 = G_t3>>3;

wire [10-1:0]G3;
assign G3 = G3_o1 + G3_o2 + (R7>>2) - G3_o3;

assign Gout = (DH_out > DV_out) ? G3 : ((DH_out < DV_out) ? G2 : G1);
endmodule