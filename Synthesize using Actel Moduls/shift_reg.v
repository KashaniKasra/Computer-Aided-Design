module shift_reg #(parameter N = 8) (input clk, rst, ld, input [N-1:0] data_in, input ser_in, shift_en, shift_type, output [N-1:0] data_out, output c_out);

    // shift wires
    wire en_out;
    wire [1:0] shift_total_type;

    // assign serial in input to shift values
    wire [N+1:0] shift_vals;
    assign shift_vals[N + 1] = ser_in;
    assign shift_vals[0] = ser_in;
    assign shift_total_type = {ld, shift_type};
    
    // determine total enable
    Or or_en(shift_en, ld, en_out);

    genvar idx;
    // generate one bit registers to the number of the given parameter
    generate
        for (idx = 1; idx < N + 1; idx = idx + 1) begin : gen_shift_reg
            wire mux_out;
            // instanciate the corresponding mux
            Mux4 mux4_inst(shift_vals[idx + 1], shift_vals[idx - 1], data_in[idx - 1], data_in[idx - 1], shift_total_type, mux_out);
            // instanciate the 1 bit register
            reg_unit reg_inst(.clk(clk), .rst(rst), .reg_en(en_out), .reg_in(mux_out), .reg_out(shift_vals[idx]));
        end
    endgenerate

    // assign the outputs
    assign c_out = shift_vals[N];
    assign data_out = shift_vals[N:1];
endmodule
