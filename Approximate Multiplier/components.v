module Register (input clk, rst, clr, load, input[7:0] in, output reg[7:0] out);

    always @(posedge clk) begin
        if (rst)
            out <= 16'b0;
        else if (clr)
            out <= 16'b0;
        else if (load)
            out <= in;
    end

endmodule

module ShiftRegister (input clk, rst, clr, shL, load, serIn, input[15:0] in, output reg serOut, output reg[15:0] out);

    always @(posedge clk) begin
        if (rst)
            out <= 16'b0;
        else if (clr)
            out <= 16'b0;
        else if (load)
            out <= in;
        else if (shL)
            {serOut, out} <= {out, serIn};
    end

endmodule

module Counter #(parameter n) (input clk, rst, clr, cnt, output co, output reg[n-1:0] num);

    always @(posedge clk) begin
        if (rst)
            num <= {n * 1'b0};
        else if (clr)
            num <= {n * 1'b0};
        else if (cnt)
            num <= num + 1;
    end

    assign co = &num;

endmodule

module inputRAM (input[3:0] adr, output[15:0] data);

    reg [15:0] RAM [0:15];

    initial $readmemb("data_input.txt", RAM);

    assign data = RAM[adr];

endmodule

module outputRAM (input clk, rst, we, input[2:0] adr, input[31:0] data);

    reg [31:0] RAM [0:7];

    initial $readmemh("data_output.txt", RAM);

    always @(posedge clk) begin
        if (we)
            RAM[adr] <= data;
    end

endmodule

module Concatenator (input[4:0] left, input[15:0] multed, input[4:0] right, output[31:0] out);

    assign out = multed << right;

endmodule

module Subtractor (input[4:0] A, output[4:0] out);

    assign out = 16 - A;

endmodule

module Multiplier (input[7:0] A, B, output[15:0] out);

    assign out = A * B;

endmodule

module RightShifter (input[3:0] in, output[3:0] out);

    assign out = in >> 1;

endmodule