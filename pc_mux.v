module Pc_mux ( PC, instruction, Jump, result );
    input [3:0] PC;
    input [31:0] instruction;
    input Jump;
    output reg [3:0] result;

    always @(PC) begin
        if (Jump) begin
            result = PC + instruction[25:0];
        end
        else begin
            result = PC;
        end
    end
endmodule
