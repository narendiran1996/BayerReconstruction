`timescale 1ns / 1ps


module RBinpAtBR_M1 
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
                    input wire [10-1:0]Gupdated,
                    output wire [11-1:0]RBout
                );
wire [11-1:0]GupdatedSign;
assign GupdatedSign = {Gupdated[10-1], Gupdated};

wire [10-1:0]t1, t2;
wire [9-1:0]t3, t4;

assign t1 = R1 + R3 + R11 + R13;
assign t2 = R2 + R12 + R6 + R8;
assign t3 = R2 + R12;
assign t4 = R6 + R8;


wire [11-1:0]RB1, RB2, RB3;
assign RB1 = (t1>>2) + GupdatedSign - (t2>>2);

wire [8-1:0]M1;
Multiply3by8 #(.NBits(9))m1(.inp(t3), .outp(M1));
assign RB2 = (t1>>2) + GupdatedSign - (t4>>3) - M1;


wire [8-1:0]M2;
Multiply3by8 #(.NBits(9))m2(.inp(t4), .outp(M2));
assign RB3 = (t1>>2) + GupdatedSign - (t3>>3) - M2;

assign RBout = (DH_out > DV_out) ? RB2 : ((DH_out < DV_out) ? RB3 : RB1);

endmodule
