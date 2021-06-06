`timescale 1ns / 1ps

module RegisterBanks3x5
                #
                (
                    parameter NBits = 8,
                    parameter IMWIDTH = 100,
                    parameter IMHEIGHT = 100
                ) 
                (
                    input wire clk,
                    input wire rst,
                    input wire [NBits-1:0]inps,
                    input wire doShift,                
                    output wire [NBits-1:0]R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14
                );

wire [NBits-1:0]W1, W2, W3;

SingleLineM      #
                (
                    .NBits(NBits),
                    .MWidth(IMWIDTH)
                )
                LB1                
                    (
                    .clk(clk),
                    .rst(rst),
                    .doShift(doShift),
                    .inp(W2),
                    .outp(W3),
                    .R1(R0),
                    .R2(R1),
                    .R3(R2),
                    .R4(R3),
                    .R5(R4)
                );

SingleLineM
                #
                    (
                    .NBits(NBits),
                    .MWidth(IMWIDTH)
                )
                LB2                
                (
                    .clk(clk),
                    .rst(rst),
                    .doShift(doShift),
                    .inp(W1),
                    .outp(W2),
                    .R1(R5),
                    .R2(R6),
                    .R3(R7),
                    .R4(R8),
                    .R5(R9)                
                );

SingleLineM
                #
                (
                    .NBits(NBits),
                    .MWidth(IMWIDTH)
                )
                LB3                
                (
                    .clk(clk),
                    .rst(rst),
                    .doShift(doShift),
                    .inp(inps),
                    .outp(W1),
                    .R1(R10),
                    .R2(R11),
                    .R3(R12),
                    .R4(R13),
                    .R5(R14)               
                );

                
endmodule
