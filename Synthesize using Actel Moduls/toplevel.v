module aprox_multiplier(input clk, rst, start, reset, input [15:0] inp1, inp2, output done, output [15:0] result);
    // Essential wires
    wire up_cout, down_cout, inp1_msb, inp2_msb, select;
    wire ld_sh1, ld_sh2, en_sh1, en_sh2, sh_type, cnt_en, cnt_type;

    // datapath
    datapath #(.N(16)) dp(clk, rst, select, ld_sh1, ld_sh2, en_sh1, en_sh2, sh_type, cnt_en, cnt_type, inp1, inp2, result, inp1_msb, inp2_msb, up_cout, down_cout);
    // controller
    controller c(clk, rst, start, up_cout, down_cout, inp1_msb, inp2_msb, reset, select, ld_sh1, ld_sh2, en_sh1, en_sh2, sh_type, cnt_en, cnt_type, done);
endmodule