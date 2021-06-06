`timescale 1ns / 1ps


module tbBayerReconstructionTestOut();

reg clk, rst, startProcess;
wire  outputValid, outputDone;
wire [11-1:0]Rout, Gout, Bout;
OverallTopModule DUT
                (
                    clk,
                    rst,                    
                    startProcess,

                    outputValid,
                    outputDone,


                    Rout, Gout, Bout
                ); 


always
    begin
        clk  = 1;
        #5;
        clk  = 0;
        #5;
    end
    

initial
    begin
        rst = 1;
        startProcess = 0;
        #47;
        rst = 0;
        #56;
        startProcess = 1;
    end

integer f1, f2, f3;
initial begin
    f1 = $fopen("/media/narendiran/MOVIES/DeMosaicBased/OutputFiles/RoutPadded.tx","w");
    f2 = $fopen("/media/narendiran/MOVIES/DeMosaicBased/OutputFiles/GoutPadded.tx","w");
    f3 = $fopen("/media/narendiran/MOVIES/DeMosaicBased/OutputFiles/BoutPadded.tx","w");
end

always @(posedge clk)
    begin
        if(outputValid)
            begin
                $fwrite(f1, "%d\n", $signed(Rout));
                $fwrite(f2, "%d\n", $signed(Gout));
                $fwrite(f3, "%d\n", $signed(Bout));
            end
        if(outputDone)
            begin
                $fclose(f1);
                $fclose(f2);    
                $fclose(f3);        
                $finish;
            end
            
    end
endmodule
