module Controller (input clk, rst, start, serOut, x15, co3, co4, co5, input[3:0] num4, num5,
                   output reg clrL, shL, loadL, serIn, clr1, load1, clr2, load2, clr3, cnt3, clr4, cnt4, clr5, cnt5, we, done);

    parameter [2:0] s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4, s5 = 5, s6 = 6, s7 = 7;
	reg [2:0] ps, ns;

    always @(posedge clk) begin
		if (rst)
			ps <= s0;
		else
			ps <= ns;
	end

    always @(ps, start, x15, num4, num5, co5) begin
		case (ps)
			s0: ns = start ? s1 : s0;
			s1: ns = start ? s1 : s2;
			s2: ns = s3;
			s3: ns = (~x15 & num4 != 8) ? s4 : s5;
			s4: ns = s3;
			s5: ns = num5[0] ? s6 : s2;
			s6: ns = co5 ? s7 : s2;
			s7: ns = s0;
			default: ns = s0;
		endcase
	end

    always @(ps) begin
		{clrL, shL, loadL, serIn, clr1, load1, clr2, load2, clr3, cnt3, clr4, cnt4, clr5, cnt5, we, done} = 16'b0;
		case (ps)
			s0:;
			s1: {clrL, clr1, clr2, clr3, clr4, clr5} = 6'b111111;
			s2: {loadL, clr4} = 2'b11;
			s3:;
			s4: {cnt3, cnt4, shL} = 3'b111;
			s5: begin cnt5 = num5[0] ? 0 : 1; load1 = num5[0] ? 0 : 1; load2 = num5[0] ? 1 : 0; end
			s6: {we, clrL, clr1, clr2, clr3, clr4, cnt5} = 7'b1111111;
			s7: done = 1'b1;
			default:;
		endcase
	end

endmodule