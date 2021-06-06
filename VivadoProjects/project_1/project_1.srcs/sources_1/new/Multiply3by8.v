module Multiply3by8 
            #
            (
                parameter NBits = 8
            )
            (
                input wire [NBits-1:0]inp,
                output wire [NBits+2-3-1:0]outp
            );
    

wire [NBits+2-1:0]mul3Val;
assign mul3Val = (inp<<1) + inp;

assign outp = mul3Val>>3;

endmodule