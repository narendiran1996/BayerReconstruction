`timescale 1ns / 1ps


module RBinpAtG_M2
                #
                (
                    parameter NBits = 8,
                    parameter IMWIDTH = 100,
                    parameter IMHEIGHT = 100
                )
                (
                    input wire [8-1:0]R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14,
                    output wire [10-1:0]RBout_M2
                );


wire [10-1:0]t1;
wire [9-1:0]t3;

assign t1 = R1 + R3 + R11 + R13;
assign t3 = R2 + R12;

assign RBout_M2 = (t3>>1) + (R7>>1) - (t1>>3);
endmodule
