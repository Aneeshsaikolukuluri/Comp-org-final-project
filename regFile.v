module Regfile(rs, rt, rd,
v0, v1, v2, v3, read1, read2);

    input [4:0] rs; //rs
    input [4:0] rt; //rt
    input [4:0] rd;
    input [31:0] v0, v1, v2, v3;

    output reg[31:0] read1, read2;

    // initial begin
    //     $display("REGISTER_FILE");
    //     $display("regs: %b, %b\n", rs, rt);
    // end
 
    always @(rs, rt, rd) begin
        case (rs)
            5'b10000: begin
                read1 = v0;
            end
            5'b10001: begin
                read1 = v1;
            end
            5'b10010: begin
                read1 = v2;
            end
            5'b10011: begin
                read1 = v3;
            end
            default: begin
                read1 = 32'b00000000000000000000000000000000;
            end
        endcase
        case (rt)
            5'b10000: begin
                read2 = v0;
            end
            5'b10001: begin
                read2 = v1;
            end
            5'b10010: begin
                read2 = v2;
            end
            5'b10011: begin
                read2 = v3;
            end
            default: begin
                read2 = 32'b00000000000000000000000000000000;
            end
        endcase
        $display("RS :: %b", rs);
        $display("RT :: %b", rt);
    end
endmodule

