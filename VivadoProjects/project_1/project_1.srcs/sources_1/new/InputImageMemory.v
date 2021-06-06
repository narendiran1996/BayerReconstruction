`timescale 1ns / 1ps

module InputImageMemory
                #
                (
                    parameter NBits = 8,
                    parameter IMWIDTH = 100,
                    parameter IMHEIGHT = 100,
                    parameter IMMEMFILE = ""
                ) 
                (
                    input wire clk,
                    input wire rst,
                    input wire [$clog2(IMWIDTH*IMHEIGHT)-1:0]addrIn,
                    output reg [NBits-1:0]dataOut
                );

reg [NBits-1:0]MEMREGS[0:(IMWIDTH*IMHEIGHT)-1];


initial
    begin
        $readmemh(IMMEMFILE, MEMREGS);
    end


always @(posedge clk)
    begin
        if(rst == 1)
            dataOut <= 0;
        else
            dataOut <= MEMREGS[addrIn];  
    end

endmodule