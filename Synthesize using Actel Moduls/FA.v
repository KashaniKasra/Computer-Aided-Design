module FA (input wire a, input wire b, input wire c_in, output wire sum, output wire cout);
    // declare wires
    wire and_res;
    wire xor_res;
    wire xor_sec_res;
    
    // xors for calculating sum value
    Xor x_inst(a, b, xor_res);
    Xor x_inst_2(xor_res, c_in, sum);
    
    // modules for calculating cout
    And a_inst(xor_res, c_in, xor_sec_res);
    And a_inst_2(a, b, and_res);
    Or or_inst(xor_sec_res, and_res, cout);
endmodule