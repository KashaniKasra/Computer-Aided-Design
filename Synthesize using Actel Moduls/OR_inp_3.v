module OR_inp_3 (input a , b, c, output out);
    C2 #(1) C2_inst(.D00(1'b0), .D01(1'b1), .D10(1'b1), .D11(1'b1), .A1(a), .B1(b), .A0(c), .B0(1'b1), .out(out));
endmodule