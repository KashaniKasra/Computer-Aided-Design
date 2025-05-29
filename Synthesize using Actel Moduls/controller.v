module controller (input clk, rst, start, up_cout, down_cout, inp1_msb, inp2_msb, reset, output select, ld_sh1, ld_sh2, en_sh1, en_sh2, sh_type, cnt_en, cnt_type, done);

        // wires
        wire [9:0] temps, states;
        wire idle_wire, start_rise, start_fall;
        wire first_val, sec_val, third_val, mult_res;
        wire not_start, not_inp1_msb, not_inp2_msb, not_up_cout, not_down_cout;
        
        // not values
        Not not_start_inst(start, not_start);
        Not not_input_inst(inp1_msb, not_inp1_msb);
        Not not_sec_input_inst(inp2_msb, not_inp2_msb);
        Not not_up_co_inst(up_cout, not_up_cout);
        Not not_down_co_inst(down_cout, not_down_cout);

        // The following are the logics of the states in a row:
        // STATE: IDLE
        reg_unit idle_reg_inst(clk, reset, 1'b1, states[0], temps[0]);
        And and_idle_inst(not_start, temps[0], idle_wire);
        OR_inp_3 or_idle_inst(temps[9], rst, idle_wire, states[0]);
        
        // STATE: INIT
        And and_start_rise_inst(temps[0], start, start_rise);
        And and_start_fall_inst(temps[1], start, start_fall);
        Or or_start_inst(start_rise, start_fall, states[1]);
        reg_unit start_state_inst(clk, rst, 1'b1, states[1], temps[1]);

        // STATE: INP1
        And and_first_inst(temps[1], not_start, first_val);
        Or or_first_inst(first_val, temps[3], states[2]);
        reg_unit num_first_reg_inst(clk, rst, 1'b1, states[2], temps[2]);

        // STATE: SHIFT1
        AND_inp_3 and_shift_inp_first_inst(temps[2], not_inp1_msb, not_up_cout, states[3]);
        reg_unit shift_first_input_inst(clk, rst, 1'b1, states[3], temps[3]);

        // STATE: INP2
        And and_num_sec_inst(temps[2], sec_val, third_val);
        Or or_num_sec_inst(inp1_msb, up_cout, sec_val);
        Or or_num_sec_result_inst(third_val, temps[5], states[4]);
        reg_unit num_sec_shift_inst(clk, rst, 1'b1, states[4], temps[4]);

        // STATE: SHIFT2
        AND_inp_3 and_shift_of_sec_inst(temps[4], not_inp2_msb, not_up_cout, states[5]);
        reg_unit shift_sec_reg_inst(clk, rst, 1'b1, states[5], temps[5]);

        // STATE: CALC
        Or or_calc(inp2_msb, up_cout, mult_res);
        And and_calc(temps[4], mult_res, states[6]);
        reg_unit calc_inst(clk, rst, 1'b1, states[6], temps[6]);

        // STATE: SHIFT RESULT
        Or or_shift_res_inst(temps[6], temps[8], states[7]);
        reg_unit reg_shift_res_inst(clk, rst, 1'b1, states[7], temps[7]);

        // STATE: WAIT
        And and_wait_res_inst(temps[7], not_down_cout, states[8]);
        reg_unit reg_wait_res_inst(clk, rst, 1'b1, states[8], temps[8]);

        // STATE: VALID
        And and_valid_inst(temps[7], down_cout, states[9]);
        reg_unit done_reg_inst(clk, rst, 1'b1, states[9], temps[9]);

        // Logic for the outputs of the first register
        Or ld_sh_first_or_inst(temps[6], temps[1], ld_sh1);
        Or en_sh_first_or_inst(temps[3], temps[8], en_sh1);
        OR_inp_3 cnt_en_or(temps[3], temps[5], temps[8], cnt_en);

        // The following are the outputs of the second register assigned
        assign select = temps[6];
        assign ld_sh2 = temps[1];
        assign en_sh2 = temps[5];
        assign sh_type = temps[3];
        assign cnt_type = temps[8];

        // assign the done signal
        assign done = temps[9];
endmodule