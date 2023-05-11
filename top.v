module top(pc, instruction, newPC, 
    control, 
    clk, rst, enable, 
    v0, v1, v2, v3,
    value0, value1,
    value2, value3, 
    writeData
);
    input clk, rst, enable; 
    input[3:0] pc; 
    input[31:0] writeData;
    input[31:0] v0,v1,v2,v3;

    output[3:0] newPC;
    output[3:0] control; 
    output[31:0] instruction; 
    output[31:0] value0, value1, value2, value3;

    wire Jump;
    wire RegWrite;
    wire [1:0] ALUOp;
    wire [31:0] r1, r2;
    wire [31:0] ALUresult;
    wire [3:0] PC_4;

    // Control:
    // 0 : Jump
    // 1-2 : ALUOp
    // 3 : RegWrite 
   
    // wire[31:0] shiftLeftTwo; 
   
    // wire[3:0]  ALUcontrol; 
    // wire[31:0] mainALUresult;

    
    instructionMemory instructionMem(clk, pc, instruction); 
    // control bits are interpreted as big endian because they are 
    // an integer array 
    Control ctrl(instruction, control, ALUOp, Jump, RegWrite);

    // Regfile registerunit(RegWrite, 
    //     instruction[25:21], instruction[20:16], 
    //     instruction[15:11], 
    //     ALUResult, v0, v1, v2, v3,
    //     value0, value1, value2, value3,
    //     r1, r2);



    Regfile registerunit(instruction[25:21], instruction[20:16], 
        instruction[15:11], 
        v0, v1, v2, v3, 
        r1, r2
    );

    alu operation(r1, r2, ALUOp, ALUresult);

    WriteRegfile writeregisterunit(RegWrite, instruction[15:11], 
        v0, v1, v2, v3,
        ALUresult,
        value0, value1, value2, value3
    );
    

    add addPC(clk, pc, PC_4);

    Pc_mux pcmux( PC_4, instruction, Jump, newPC );


endmodule 