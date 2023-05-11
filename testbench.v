`define assert(actual, expected, display) \
    if (actual == expected) \
        $display("  PASSED! "); \
    else begin \
        $display(" ** %s:   ", display); \
    end \
// End of `assert macro.

`timescale 1 ns / 1 ns
module testbench; 
    reg enable, clk, rst;
    reg[3:0] pc;
    reg[31:0] v0, v1, v2, v3;
    wire[31:0] value0, value1, value2, value3;

    initial begin
        v0 = 1;
        v1 = 111;
        v2 = 27;
        v3 = 3;
    end

    wire[3:0] newPC;
    wire[3:0] control; 
    wire[31:0] instruction;
    wire[31:0] writeData;

    initial begin 
        pc = 0; 
        
    end

    top dut(pc, instruction, newPC, 
        control, 
        clk, rst, enable,
        v0, v1, v2, v3,
        value0, value1, 
        value2, value3, 
        writeData
    );

    initial clk = 1; 
    always begin 
        #1 clk = ~clk;
    end 

    //David --> Incorrect PC updates faster than 
    //it takes to execute instruction. New instruction
    //will be fetched before old one finishes executing
    always @(newPC) begin
        pc = newPC;
    end

    always @(value0, value1, value2, value3) begin
        v0 = value0;
        v1 = value1;
        v2 = value2;
        v3 = value3;
    end

    initial begin 
        $display("SET OF MIPS INSTRUCTIONS:");
        $display("j 8");
        $display("add $s0,$s2,$s0");
        $display("add $s0,$s0,$s1");
        $display("add $s0,$s1,$s2\n");

        $display("=============================================");
        // FIRST INSTRUCTION: ("j 8")
        $display("PC :: %b\n", pc);
        #1
        $display("Instruction: %b", instruction);
        $display("CONTROL: %b\n", control);

        $display("PC == 0000:");
        `assert(pc, 4'b0000, "FAIL");
        $display("Instruction == 00001000000000000000000000000100:");
        `assert(instruction, 32'b00001000000000000000000000000100, "FAIL");
        $display("CONTROL: 1000:");
        `assert(control, 4'b1000, "FAIL");
        $display("=============================================");

        // SECOND INSTRUCTION: ("add $s0,$s0,$s1")
        #2
        $display("PC :: %b", pc);
        $display("Instruction: %b", instruction);
        $display("CONTROL :: %b\n", control);

        $display("PC == 1000:");
        `assert(pc, 4'b1000, "FAIL");
        $display("Instruction == 00000010000100011000000000100000:");
        `assert(instruction,32'b00000010000100011000000000100000, "FAIL");
        $display("CONTROL: 0101:");
        `assert(control, 4'b0101, "FAIL");
        $display("=============================================");

        // THIRD INSTRUCTION: ("add $s0,$s1,$s2")
        #2
        $display("PC :: %b", pc);
        $display("Instruction: %b", instruction);
        $display("CONTROL :: %b\n", control);

        $display("PC == 1000:");
        `assert(pc, 4'b1100, "FAIL");
        $display("Instruction == 00000010001100101000000000100000:");
        `assert(instruction, 32'b00000010001100101000000000100000, "FAIL");
        $display("CONTROL: 0101:");
        `assert(control, 4'b0101, "FAIL");
        $display("=============================================");
    
        $finish; 
    end 
endmodule 
	