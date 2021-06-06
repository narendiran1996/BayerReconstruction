`timescale 1ns / 1ps

module EdgeDetectorForDVDH
                #
                (
                    parameter NBits = 8,
                    parameter IMWIDTH = 100,
                    parameter IMHEIGHT = 100
                )
                (
                    input wire [NBits-1:0]R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14,
                    output wire [$clog2(255 + 255 + 255)-1:0]DV_out,
                    output wire [$clog2(255 + 255 + 255)-1:0]DH_out
                );

wire [NBits-1:0]S1, S2, S3, S4, S5, S6;

AbsoluteDifference #(.NBits(NBits)) A1 (.inp1(R1), .inp2(R11), .outp(S1));
AbsoluteDifference #(.NBits(NBits)) A2 (.inp1(R2), .inp2(R12), .outp(S2));
AbsoluteDifference #(.NBits(NBits)) A3 (.inp1(R3), .inp2(R13), .outp(S3));

assign DV_out = S1 + S2 + S3;


AbsoluteDifference #(.NBits(NBits)) A4 (.inp1(R1), .inp2(R3), .outp(S4));
AbsoluteDifference #(.NBits(NBits)) A5 (.inp1(R6), .inp2(R8), .outp(S5));
AbsoluteDifference #(.NBits(NBits)) A6 (.inp1(R11), .inp2(R13), .outp(S6));

assign DH_out = S4 + S5 + S6;

endmodule