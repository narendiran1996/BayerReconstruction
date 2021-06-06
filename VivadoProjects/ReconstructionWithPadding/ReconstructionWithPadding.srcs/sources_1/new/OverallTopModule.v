`timescale 1ns / 1ps

module OverallTopModule
                #
                (
                    parameter NBits = 8,
                    parameter IMWIDTH = 504,
                    parameter IMHEIGHT = 377,
                    parameter IMMEMFILE = "/home/narendiran//newProjectLocation/DeMosaicBased/BayerImagePadded.mem"
                ) 
                (
                    input wire clk,
                    input wire rst,                    
                    input wire startProcess,


                    output wire outputValid,
                    output wire processDone,

                    output wire [11-1:0]RoutFinal,
                    output wire [11-1:0]GoutFinal,
                    output wire [11-1:0]BoutFinal
                );


wire [$clog2(IMWIDTH*IMHEIGHT)-1:0]addrToImageMem;
wire doShiftRegisterBanks;

wire [$clog2(IMHEIGHT)-1:0]i_rows;
wire [$clog2(IMWIDTH)-1:0]j_cols;
Controller
                #
                (
                    .NBits(NBits),
                    .IMWIDTH(IMWIDTH),
                    .IMHEIGHT(IMHEIGHT)
                ) 
                CTR
                (
                    .clk(clk),
                    .rst(rst),
                    .startProcess(startProcess),

                    .addrToImageMem(addrToImageMem),
                    .doShiftRegisterBanks(doShiftRegisterBanks),
                    .i_rows(i_rows),
                    .j_cols(j_cols),

                    .outputValid(outputValid),
                    .processDone(processDone)
                );

wire [NBits-1:0]ImagedataOut;

InputImageMemory
                #
                (
                    .NBits(NBits),
                    .IMWIDTH(IMWIDTH),
                    .IMHEIGHT(IMHEIGHT),
                    .IMMEMFILE(IMMEMFILE)
                ) 
                IIM
                (
                    .clk(clk),
                    .rst(rst),
                    .addrIn(addrToImageMem),
                    .dataOut(ImagedataOut)
                );

wire [NBits-1:0]R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14;
RegisterBanks3x5
                #
                (
                    .NBits(NBits),
                    .IMWIDTH(IMWIDTH),
                    .IMHEIGHT(IMHEIGHT)
                )
                RB3x5 
                (
                     .clk(clk),
                    .rst(rst),
                    .inps(ImagedataOut),
                    .doShift(doShiftRegisterBanks),                
                    .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4),
                    .R5(R5), .R6(R6), .R7(R7), .R8(R8), .R9(R9), 
                    .R10(R10), .R11(R11), .R12(R12), .R13(R13), .R14(R14)

                );

wire [$clog2(255 + 255 + 255)-1:0]DV_out;
wire [$clog2(255 + 255 + 255)-1:0]DH_out;
EdgeDetectorForDVDH
                #
                (
                    .NBits(NBits),
                    .IMWIDTH(IMWIDTH),
                    .IMHEIGHT(IMHEIGHT)
                )
                DVDHedgeINs
                (
                    .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4),
                    .R5(R5), .R6(R6), .R7(R7), .R8(R8), .R9(R9), 
                    .R10(R10), .R11(R11), .R12(R12), .R13(R13), .R14(R14),
                    .DV_out(DV_out),
                    .DH_out(DH_out)
                );

wire [10-1:0]GoutInterPolated;
GInterpolatorGout
                #
                (
                    .NBits(NBits),
                    .IMWIDTH(IMWIDTH),
                    .IMHEIGHT(IMHEIGHT)
                )
                GintPins
                (
                    .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4),
                    .R5(R5), .R6(R6), .R7(R7), .R8(R8), .R9(R9), 
                    .R10(R10), .R11(R11), .R12(R12), .R13(R13), .R14(R14),
                    .DV_out(DV_out),
                    .DH_out(DH_out),
                    .Gout(GoutInterPolated)                    
                );

wire [11-1:0]RBout_M1;
RBinpAtBR_M1 
                #
                (
                    .NBits(NBits),
                    .IMWIDTH(IMWIDTH),
                    .IMHEIGHT(IMHEIGHT)
                )
                RBM1
                (
                    .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4),
                    .R5(R5), .R6(R6), .R7(R7), .R8(R8), .R9(R9), 
                    .R10(R10), .R11(R11), .R12(R12), .R13(R13), .R14(R14),
                    .DV_out(DV_out),
                    .DH_out(DH_out),
                    .Gupdated(GoutInterPolated),
                    .RBout(RBout_M1)
                );

wire [10-1:0]RBout_M2;
RBinpAtG_M2
                #
                (
                    .NBits(NBits),
                    .IMWIDTH(IMWIDTH),
                    .IMHEIGHT(IMHEIGHT)
                )
                RBM2
                (
                    .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4),
                    .R5(R5), .R6(R6), .R7(R7), .R8(R8), .R9(R9), 
                    .R10(R10), .R11(R11), .R12(R12), .R13(R13), .R14(R14),
                    .RBout_M2(RBout_M2)
                );
wire [9-1:0]RBout_M3;

RBinpAtG_M3
                #
                (
                    .NBits(NBits),
                    .IMWIDTH(IMWIDTH),
                    .IMHEIGHT(IMHEIGHT)
                )
                RBM3
                (
                    .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4),
                    .R5(R5), .R6(R6), .R7(R7), .R8(R8), .R9(R9), 
                    .R10(R10), .R11(R11), .R12(R12), .R13(R13), .R14(R14),
                    .RBout_M3(RBout_M3)
                );

RGBCreation
                #
                (
                    .NBits(NBits),
                    .IMWIDTH(IMWIDTH),
                    .IMHEIGHT(IMHEIGHT)
                )
                RGBCreationins
                (
                    .i_rows(i_rows),
                    .j_cols(j_cols),

                    .R7(R7),
                    .GoutInterPolated(GoutInterPolated),
                    .RBout_M1(RBout_M1),
                    .RBout_M2(RBout_M2),
                    .RBout_M3(RBout_M3),

                    .RoutFinal(RoutFinal),
                    .GoutFinal(GoutFinal),
                    .BoutFinal(BoutFinal)
                );
endmodule