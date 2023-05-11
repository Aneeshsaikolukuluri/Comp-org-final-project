module alu(rs_value, rt_value, ALUOp, result);
    input[31:0] rs_value, rt_value;
    input[1:0] ALUOp; 
    output reg[31:0] result;
    
    // If ALUOp is 2'b10, then result is the rs_value and rt_value added
    // Else result is zero
    always @(rs_value, rt_value) begin
        if (ALUOp == 2'b10) begin
            result = rs_value + rt_value;

            $display("RS_VAL :: %d", rs_value);
            $display("RT_VAL :: %d", rt_value);
            $display("RESULT :: %d\n", result);
        end
        else begin
            result = 32'b00000000000000000000000000000000;
        end
    end 
endmodule 
