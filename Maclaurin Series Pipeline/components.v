module Register #(parameter n) (input clk, rst, load, input[n-1:0] in, output reg[n-1:0] out);

    always @(posedge clk) begin
        if (rst)
            out <= {n * 1'b0};
        else if (load)
            out <= in;
    end

endmodule

module Register_set (input clk, rst, load, in_ov, input[2:0] in_addr, input[3:0] in_N, input[15:0] in_X, in_Xn, input[31:0] in_res,
                     output out_ov, output[2:0] out_addr, output[3:0] out_N, output[15:0] out_X, out_Xn, output[31:0] out_res);

    Register #(4) register_N(clk, rst, load, in_N, out_N);
    Register #(16) register_X(clk, rst, load, in_X, out_X);
    Register #(16) register_Xn(clk, rst, load, in_Xn, out_Xn);
    Register #(32) register_res(clk, rst, load, in_res, out_res);
    Register #(1) register_ov(clk, rst, load, in_ov, out_ov);
    Register #(3) register_addr(clk, rst, load, in_addr, out_addr);

endmodule

module Counter #(parameter n) (input clk, rst, cnt, output co, output reg[n-1:0] num);

    always @(posedge clk) begin
        if (rst)
            num <= {n * 1'b0};
        else if (cnt)
            num <= num + 1;
    end

    assign co = &num;

endmodule

module Multiplexer #(parameter n) (input src, input[n-1:0] A, B, output[n-1:0] out);

    assign out = (src) ? B : A;

endmodule

module Adder #(parameter n) (input[n-1:0] A, B, output[n-1:0] out);

    assign out = A + B;

endmodule

module Multiplier (input signed[15:0] A, B, output signed[31:0] out);

    assign out = (B == 16'b0111111111111111) ? {A, 16'b0} : (A * B);

endmodule

module Error_detector (input[7:0] X, output error);

    assign error = 1'b0;

endmodule

module Overflow_detector (input previous_ov, input[15:0] X, input[31:0] res, output overflow);

    assign overflow = (previous_ov | res[31] != X[15]) ? 1 : 0;

endmodule

module Pipe (input old_ov, output[2:0] old_addr, input[3:0] old_N, input[15:0] old_X, old_Xn, c, input[31:0] old_res,
             output new_ov, output[2:0] new_addr, output[3:0] new_N, output[15:0] new_X, new_Xn, output[31:0] new_res);

    wire[31:0] mult_Xn, mult_cX, sum_res;

    Adder #(4) adder_N(old_N, 4'b1111, new_N);
    Adder #(32) adder_res(mult_cX, old_res, sum_res);
    Adder #(3) adder_addr(old_addr, 4'b0001, new_addr);

    Multiplier multiplier_Xn(old_X, old_Xn, mult_Xn);
    Multiplier multiplier_cX(old_Xn, c, mult_cX);

    Multiplexer #(32) multiplexer(new_N[3], sum_res, old_res, new_res);

    Overflow_detector overflow_detector(old_ov, old_X, sum_res, new_ov);

    assign new_Xn = mult_Xn[31:16];
    assign new_X = old_X;

endmodule

module LUT (input[2:0] addr1, addr2, addr3, addr4, output reg[15:0] out1, out2, out3, out4);

    always @(addr1, addr2, addr3, addr4) begin
		case(addr1)
			3'b000: out1 = 16'b0111111111111111;
			3'b001: out1 = 16'b1100000000000000;
			3'b010: out1 = 16'b0010101010101010;
			3'b011: out1 = 16'b1010000000000000;
			3'b100: out1 = 16'b0001100110011001;
			3'b101: out1 = 16'b1001010101010101;
			3'b110: out1 = 16'b0001001001001001;
			3'b111: out1 = 16'b1001000000000000;
            default: out1 = 16'b0;
		endcase

        case(addr2)
			3'b000: out2 = 16'b0111111111111111;
			3'b001: out2 = 16'b1100000000000000;
			3'b010: out2 = 16'b0010101010101010;
			3'b011: out2 = 16'b1010000000000000;
			3'b100: out2 = 16'b0001100110011001;
			3'b101: out2 = 16'b1001010101010101;
			3'b110: out2 = 16'b0001001001001001;
			3'b111: out2 = 16'b1001000000000000;
            default: out2 = 16'b0;
		endcase

        case(addr3)
			3'b000: out3 = 16'b0111111111111111;
			3'b001: out3 = 16'b1100000000000000;
			3'b010: out3 = 16'b0010101010101010;
			3'b011: out3 = 16'b1010000000000000;
			3'b100: out3 = 16'b0001100110011001;
			3'b101: out3 = 16'b1001010101010101;
			3'b110: out3 = 16'b0001001001001001;
			3'b111: out3 = 16'b1001000000000000;
            default: out3 = 16'b0;
		endcase

        case(addr4)
			3'b000: out4 = 16'b0111111111111111;
			3'b001: out4 = 16'b1100000000000000;
			3'b010: out4 = 16'b0010101010101010;
			3'b011: out4 = 16'b1010000000000000;
			3'b100: out4 = 16'b0001100110011001;
			3'b101: out4 = 16'b1001010101010101;
			3'b110: out4 = 16'b0001001001001001;
			3'b111: out4 = 16'b1001000000000000;
            default: out4 = 16'b0;
		endcase
	end

endmodule