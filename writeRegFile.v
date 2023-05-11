
//writeReg File, bottom of regFile, top.v
//Wrote some comments in testbench2
module WriteRegfile(regWrite, rd,
    v0, v1, v2, v3,
    writeData, value0, value1, value2, value3);

    input regWrite; //control bit
    input [4:0] rd; //rd
    input [31:0] v0,v1,v2,v3;
    input [31:0] writeData;

    output reg[31:0] value0, value1, value2, value3; //will be in testbench, global vars.


    always @(writeData) begin
        case(regWrite)
            1: begin
                case (rd)
                    5'b10000: begin
                        value0 = writeData;
                        value1 = v1;
                        value2 = v2;
                        value3 = v3;
                    end
                    5'b10001: begin
                        value1 = writeData;
                        value0 = v0;
                        value2 = v1;
                        value3 = v2;
                    end
                    5'b10010: begin
                        value2 = writeData;
                        value0 = v0;
                        value1 = v1;
                        value3 = v3;
                    end
                    5'b10011: begin
                        value3 = writeData;
                        value0 = v0;
                        value1 = v1;
                        value2 = v2;
                    end
                endcase
            end
        endcase
    end
endmodule