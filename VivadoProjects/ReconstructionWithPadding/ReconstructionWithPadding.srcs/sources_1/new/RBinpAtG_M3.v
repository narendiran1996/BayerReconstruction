`timescale 1ns / 1ps

module RBinpAtG_M3
                #
                (
                    parameter NBits = 8,
                    parameter IMWIDTH = 100,
                    parameter IMHEIGHT = 100
                )
                (
                    input wire [8-1:0]R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14,
                    output wire [9-1:0]RBout_M3
                );

assign RBout_M3 = (R6 + R8)>>1;
endmodule
