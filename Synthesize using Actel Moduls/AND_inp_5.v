module AND_inp_5 (input a , b, c, d, e, output out);
    wire middle;
    AND_inp_3 and1(a, b, c, middle);
    AND_inp_3 and2(middle, d, e, out);
endmodule