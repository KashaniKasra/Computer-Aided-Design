module mult_unit(input x_inp, y_inp, p_inp, c_inp, output x_out, y_out, p_out, c_out);
    
    // assigns
    assign x_out = x_inp;
    assign y_out = y_inp;
    
    wire xy, and_sec_out, and_third_out, and_fourth_out, x_out_second;
    
    // logic of the unit
    And and_first(.a(p_inp), .b(xy), .out(and_sec_out));
    And and_second(.a(x_inp), .b(y_inp), .out(xy));
    And and_third(.a(p_inp), .b(c_inp), .out(and_third_out));
    And and_fourth(.a(xy), .b(c_inp), .out(and_fourth_out));
    OR_inp_3 or_inst(.a(and_sec_out) , .b(and_third_out), .c(and_fourth_out), .out(c_out));
    // Xor x_out_first(.a(p_inp), .b(xy), .out(x_out_second));
    // Xor x_outr_sec(.a(x_out_second), .b(c_inp), .out(p_out));
    Xor_inp_3 xor_inst_three_input(.a(p_inp), .b(xy), .c(c_inp), .out(p_out));

endmodule