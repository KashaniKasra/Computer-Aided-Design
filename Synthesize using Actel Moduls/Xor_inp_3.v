module Xor_inp_3(input a, b, c, output out);
    wire not_c;
    Not n(c, not_c);
    c2 C2_inst(.D00(c), .D01(not_c), .D10(not_c), .D11(c), .A1(a), .B1(b), .A0(a), .B0(b), .out(out));
endmodule