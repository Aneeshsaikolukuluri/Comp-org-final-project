module instructionMemory ( clk, PC, instruction );
  
  input clk;
  input [3:0] PC;
  output reg [31:0] instruction;
  
  always @(posedge clk) begin
    case(PC)
      0: instruction = 32'b00001000000000000000000000000100; 
      4: instruction = 32'b00000010010100001000000000100000;
      8: instruction = 32'b00000010000100011000000000100000;
      12: instruction = 32'b00000010001100101000000000100000;
    endcase
  end
  
endmodule
  