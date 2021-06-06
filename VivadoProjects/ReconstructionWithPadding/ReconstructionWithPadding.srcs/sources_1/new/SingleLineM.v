`timescale 1ns / 1ps

module SingleLineM
                #
                (
                    parameter NBits = 8,
                    parameter MWidth = 100
                )
                (
                    input wire clk,
                    input wire rst,
                    input wire doShift,
                    input wire [NBits-1:0]inp,
                    output wire [NBits-1:0]outp,
                    output wire [NBits-1:0]R1,R2,R3,R4,R5
                );
                


reg [NBits-1:0]BUFFER[0:MWidth-1];
integer i;

always@(posedge clk)
    begin
        if(rst == 1)
            begin
                for(i=0; i<MWidth; i= i + 1)
                    begin
                        BUFFER[i] = 0;
                    end 
            end
        else
            begin
                if(doShift == 1)
                    begin
                        BUFFER[0] <= inp;
                        for(i = 1; i < MWidth; i = i + 1)
                            BUFFER[i] <= BUFFER[i-1];
                    end
            end
    end
assign outp = BUFFER[MWidth-1];

assign R1 = BUFFER[MWidth-1];
assign R2 = BUFFER[MWidth-2];
assign R3 = BUFFER[MWidth-3];
assign R4 = BUFFER[MWidth-4];
assign R5 = BUFFER[MWidth-5];

endmodule