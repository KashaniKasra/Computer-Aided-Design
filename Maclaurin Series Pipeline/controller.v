module Controller (input clk, rst, start, overflow, error, input[2:0] N, output reg ready, valid, src, load);

    parameter [2:0] s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4, s5 = 5;
	reg [2:0] ps, ns;
    reg cnt1, cnt2;
    wire co1, co;
    wire[1:0] num2;
    wire[2:0] stage;

    Counter #(3) counter1(clk, rst, cnt1, co1, stage);
    Counter #(2) counter2(clk, rst, cnt2, co, num2);

    always @(posedge clk) begin
		if (rst)
			ps <= s0;
		else
			ps <= ns;
	end

    always @(ps, start, error, co, N) begin
		case (ps)
			s0: ns = start ? s1 : s0;
			s1: ns = (N <= 4) ? s2 : s3;
			s2: ns = error ? s5 : s2;
			s3: ns = error ? s5 : co ? s4 : s3;
			s4: ns = error ? s5 : co ? s3 : s4;
			s5: ns = s5;
			default: ns = s0;
		endcase
	end

    always @(ps) begin
		{ready, valid, src, load, cnt1, cnt2} = 6'b0;
		case (ps)
			s0:;
			s1: ready = 1'b1;
			s2: begin {src, load, ready} = 3'b011; cnt1 = (stage == 3'b100) ? 0 : 1;  valid = (stage == 3'b100) ? 1 : 0; end
			s3: begin {src, load, cnt2, ready} = 4'b0111; cnt1 = (stage == 3'b100) ? 0: 1; valid = (stage == 3'b100) ? 1 : 0; end
			s4: {src, load, cnt2} = 3'b111;
			s5:;
			default:;
		endcase
	end

endmodule