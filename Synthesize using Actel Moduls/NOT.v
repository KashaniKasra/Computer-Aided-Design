module Not(input a, output out);
	C1 C1_inst (.A0(1'b1), .A1(1'b0), .SA(a), .B0(), .B1(), .SB(), .S0(1'b0), .S1(1'b0), .F(out));
endmodule