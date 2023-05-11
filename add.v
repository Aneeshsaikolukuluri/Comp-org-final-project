module add(clk, PC, result); 
    input clk; 
    input[3:0] PC; 
    output reg[3:0] result;
    
    always @(negedge clk) begin
        result = PC + 4;
    end

endmodule