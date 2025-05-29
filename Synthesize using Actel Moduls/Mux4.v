module Mux4 (input [4:0] a, b, c, d, input [1:0] sel, output [4:0] mux_out);
    C2 #5 C2_inst (.D00(a), .D01(b), .D10(c), .D11(d), .A1(sel[1]), .A0(sel[0]), .B0(1'b1), .B1(1'b0), .out(mux_out));
endmodule