// Control Unit
module Control (instruction, control, ALUOp, Jump, RegWrite);
  input [31:0] instruction;	// Instruction [31-26] will give the opcode
  output reg[3:0] control;
  output reg[1:0] ALUOp;
  output reg Jump;
  output reg RegWrite;

  always @(instruction) begin
    case(instruction[31:26])
        6'b000000: begin
            $display("Type of Instruction Performed: R_type\n");
            control = 4'b0101;
            ALUOp = 2'b10;
            RegWrite = 1;
            Jump = 0;
        end
        6'b000010: begin
            $display("Type of Instruction Performed: Jump\n");
            control = 4'b1000;
            ALUOp = 2'b00;
            RegWrite = 0;
            Jump = 1;
        end
    endcase
  end
endmodule
 