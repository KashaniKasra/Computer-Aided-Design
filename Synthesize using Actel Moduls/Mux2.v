module Mux2 #(parameter N = 5) (input [N-1:0] a, b, input sel, output [N-1:0] mux_out);
    C2 #N C2_inst (.D00(a), .D01(b), .D10(), .D11(), .A1(1'b0), .B1(1'b0), .A0(sel), .B0(1'b1), .out(mux_out));
endmodule