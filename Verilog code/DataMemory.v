module DataMemory(input [31:0] memAdr, writeData, input memWrite, clk, output [31:0] readData);

    reg [7:0] dataMemory [0:$pow(2,16)-1]; 

    wire [31:0] adr;
    assign adr = {memAdr[31:2], 2'b00};

    initial $readmemb("data.mem", dataMemory, 1000); 

    always @(posedge clk) begin
        if(memWrite)
            {dataMemory[adr], dataMemory[adr + 1], 
                dataMemory[adr + 2], dataMemory[adr + 3]} <= writeData;
    end

    assign readData = {dataMemory[adr], dataMemory[adr + 1], 
                        dataMemory[adr + 2], dataMemory[adr + 3]};

endmodule

