`timescale 1ns / 1ps


module RGBCreation
                #
                (
                    parameter NBits = 8,
                    parameter IMWIDTH = 100,
                    parameter IMHEIGHT = 100
                )
                (
                    input wire [$clog2(IMHEIGHT)-1:0]i_rows,
                    input wire [$clog2(IMWIDTH)-1:0]j_cols,

                    input wire [8-1:0]R7,
                    input wire [10-1:0]GoutInterPolated,
                    input wire [11-1:0]RBout_M1,
                    input wire [10-1:0]RBout_M2,
                    input wire [9-1:0]RBout_M3,

                    output reg [11-1:0]RoutFinal,
                    output reg [11-1:0]GoutFinal,
                    output reg [11-1:0]BoutFinal
                );


always @(*)
    begin
         if ((i_rows[0] == 0) && (j_cols[0] == 0)) // Blue Color -- Even i's && even j's
            begin 
                RoutFinal = RBout_M1;
                GoutFinal = {GoutInterPolated[10-1], GoutInterPolated};
                BoutFinal = R7;
            end
        else if ((i_rows[0] == 1) && (j_cols[0] == 1)) // Red Color -- Odd i's && odd j's
            begin 
                RoutFinal = R7;
                GoutFinal = {GoutInterPolated[10-1], GoutInterPolated};
                BoutFinal = RBout_M1;
            end
        else if ((i_rows[0] == 0) && (j_cols[0] == 1)) // Green Color (BGBG...) -- Even i's && odd j's
            begin 
                RoutFinal = {RBout_M2[10-1], RBout_M2};
                GoutFinal = R7;
                BoutFinal = {{2{RBout_M3[9-1]}}, RBout_M3};
            end
        else if ((i_rows[0] == 1) && (j_cols[0] == 0)) // Green Color (GRGR...) -- Odd i's && even j's
            begin 
                RoutFinal = {{2{RBout_M3[9-1]}}, RBout_M3};
                GoutFinal = R7;
                BoutFinal = {RBout_M2[10-1], RBout_M2};
            end
        else
            begin
                RoutFinal = 'hx;
                GoutFinal = 'hx;
                BoutFinal = 'hx;
            end
    end

endmodule
