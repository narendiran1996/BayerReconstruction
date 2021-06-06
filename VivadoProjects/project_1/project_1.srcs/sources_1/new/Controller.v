`timescale 1ns / 1ps

module Controller
                #
                (
                    parameter NBits = 8,
                    parameter IMWIDTH = 100,
                    parameter IMHEIGHT = 100
                ) 
                (
                    input wire clk,
                    input wire rst,
                    input wire startProcess,

                    output reg [$clog2(IMWIDTH*IMHEIGHT)-1:0]addrToImageMem,
                    output reg doShiftRegisterBanks,
                    output reg [$clog2(IMHEIGHT)-1:0]i_rows,
                    output reg [$clog2(IMWIDTH)-1:0]j_cols,



                    output wire outputValid,
                    output wire processDone
                );

reg [2:0]presentState, nextState;

localparam IDLE = 3'd0, FILL_LBs = 3'd1, COLINC = 3'd2, WAITFORROWCHANGE = 3'd3 , ROWINC = 3'd4, OVER = 3'd5;

always @(posedge clk)
    begin
        if(rst == 1)
            presentState <= IDLE;
        else
            presentState <= nextState;
    end

reg canIncIMaddr;



reg [2:0]waitCycles;

wire completedAll;
assign completedAll =  (i_rows == (IMHEIGHT-2) && j_cols == (IMWIDTH-3));

always @(presentState, startProcess, addrToImageMem, i_rows, j_cols, waitCycles, completedAll)
    begin
        case (presentState)
            IDLE: 
                begin
                    doShiftRegisterBanks = 0;
                    canIncIMaddr = 0;
                    if(startProcess == 1)
                        nextState = FILL_LBs;
                    else
                        nextState = IDLE;
                end
            FILL_LBs:
                begin
                    doShiftRegisterBanks = 1;
                    canIncIMaddr = 1;
                    if(addrToImageMem == 3*IMWIDTH)
                        nextState = COLINC;
                    else
                        nextState = FILL_LBs;
                end
            COLINC:
                begin
                    canIncIMaddr = 1;
                    doShiftRegisterBanks = 1;
                    if(completedAll == 1)
                        nextState = OVER;
                    else if(j_cols == (IMWIDTH-3))
                        nextState = WAITFORROWCHANGE;
                    else
                        nextState = COLINC;
                end
            WAITFORROWCHANGE:
                begin
                    canIncIMaddr = 1;
                    doShiftRegisterBanks = 1;
                    if(waitCycles == 3-1)
                        nextState = ROWINC;
                    else
                        nextState = WAITFORROWCHANGE;
                end
            ROWINC:
                begin
                    canIncIMaddr = 1;
                    doShiftRegisterBanks = 1;
                    nextState = COLINC;
                end
            OVER:
                begin
                    canIncIMaddr = 0;
                    doShiftRegisterBanks = 0;
                    nextState = OVER;
                end
            default: 
                begin
                    canIncIMaddr = 'hx;
                    doShiftRegisterBanks = 'hx;
                    nextState = 'hx;
                end
        endcase        
    end
    
always @(posedge clk)
    begin
        if(rst == 1)
            addrToImageMem <= 0;
        else
            if(canIncIMaddr)
                addrToImageMem <= addrToImageMem + 1;        
    end
always @(posedge clk)
    begin
        if(rst == 1 || j_cols == (IMWIDTH-3))
            j_cols <= 2;
        else
            begin
                if(presentState == COLINC)
                    j_cols <= j_cols + 1;
            end        
    end 

always @(posedge clk )
    begin
        if(rst == 1 || completedAll == 1)
            i_rows <= 1;
        else
            begin
                if(presentState == ROWINC)
                    i_rows <= i_rows + 1;
            end        
    end    

always @(posedge clk )
    begin
        if(rst == 1 || presentState == COLINC)
            waitCycles <= 0;        
        else
            begin
                if(presentState == WAITFORROWCHANGE)
                    waitCycles <= waitCycles + 1;
            end
    end

assign outputValid = (presentState == COLINC);
assign processDone = (presentState == OVER);
endmodule
