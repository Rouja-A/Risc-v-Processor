module HazardUnit(input [4:0] Rs1D, Rs2D, RdE, RdM, RdW, Rs2E, Rs1E,
                  input [1:0]PCSrcE,
                  input resultSrcE0, regWriteW, regWriteM,
                  output reg stallF, stallD, flushD, flushE, 
                  output reg [1:0] forwardAE, forwardBE);                    

    always @(Rs1E or RdM or RdW or regWriteM or regWriteW) begin
        if(Rs1E == 5'b0)
            forwardAE <= 2'b00;
        else if((Rs1E == RdM) && regWriteM)
            forwardAE <= 2'b10;
        else if((Rs1E == RdW) && regWriteW)
            forwardAE <= 2'b01;
        else 
            forwardAE <= 2'b00;
    end    

    always @(Rs2E or RdM or RdW or regWriteM or regWriteW) begin
        if(Rs2E == 5'b0)
            forwardBE <= 2'b00;
        else if((Rs2E == RdM) && regWriteM)
            forwardBE <= 2'b10;
        else if((Rs2E == RdW) && regWriteW)
            forwardBE <= 2'b01;
        else 
            forwardBE <= 2'b00;
    end 
                                
    reg lwStall;
    assign lwStall = ((((Rs1D == RdE) || (Rs2D == RdE)) && resultSrcE0)) ? 1'b1 : 1'b0;

    assign stallF = lwStall;
    assign stallD = lwStall;

    assign flushD = (PCSrcE != 2'b00) ? 1'b1 : 1'b0 ;
    assign flushE = lwStall || (PCSrcE != 2'b00);

endmodule

