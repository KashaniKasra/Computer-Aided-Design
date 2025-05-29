module datapath #(parameter N = 16)(input clk, rst, select, ld_sh1, ld_sh2, en_sh1, en_sh2, sh_type, cnt_en, cnt_type, input [N-1:0] inp_1, inp_2,
                output [N-1:0] result, output inp1_msb, inp2_msb, output up_cout, down_cout);
    // wires
    wire [N-1:0] inp1_shifted, inp2_shifted, mult_out, mux_out;

    // first register
    shift_reg #(N) sh_inst(clk, rst, ld_sh1, mux_out, 1'b0, en_sh1, sh_type, inp1_shifted, inp1_msb);

    // second register
    shift_reg #(N) sh_inst_2(clk, rst, ld_sh2, inp_2, 1'b0, en_sh2, 1'b1, inp2_shifted, inp2_msb);

    // multiplexer to determine the input of the first shift register
    Mux2 #(N) mux_inst(inp_1, mult_out, select, mux_out);

    // multiplier
    array_mult multiplier(inp1_shifted[N-1:8], inp2_shifted[N-1:8], mult_out);

    // counter for tracking the number of shifts
    counter c_inst(.clk(clk), .rst(rst), .en(cnt_en), .type(cnt_type), .count_out(), .down_out(down_cout), .up_out(up_cout));

    // assign result value
    assign result = inp1_shifted;
endmodule