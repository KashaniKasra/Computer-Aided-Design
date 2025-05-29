module OR_inp_5 (input a , b, c, d, e, output out);
    wire middle;
    OR_inp_3 or1(a, b, c, middle);
    OR_inp_3 or2(middle, d, e, out);
endmodule