`timescale 1ns / 1ps

module AbsoluteDifference
                #
                (
                    parameter NBits = 8
                )
                (
                    input wire [NBits-1:0]inp1,
                    input wire [NBits-1:0]inp2,
                    output wire [NBits-1:0]outp
                );

assign outp = (inp1 > inp2) ? inp1 - inp2 : inp2 - inp1;

endmodule
