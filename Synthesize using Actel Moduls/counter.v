module counter (input clk, rst, en, type, output down_out, output up_out, output [4:0] count_out);
    // wires for storing the count values
    wire [4:0] less;
    wire [4:0] next;   
    
    // temp wire
    wire t;
    
    // wires for values of bits
    wire [4:0] vals;            

    genvar idx;
    // constructing registers
    generate
        for (idx = 0; idx < 5; idx = idx + 1'd1) begin : gen_register
            // register for each bit
            reg_unit reg_inst (.clk(clk), .rst(rst), .reg_en(en), .reg_in(next[idx]), .reg_out(vals[idx]));
        end
    endgenerate
    
    // necessary modules
    Mux2 m (5'd1, 5'b11111, type, less); 
    cnt_adder a (.a(vals), .b(less), .cin(1'b0), .s(next), .cout());
    
    // for generating carry
    OR_inp_5 o_inst (vals[0], vals[1], vals[2], vals[3], vals[4], t);
    Not not_or (t, down_out);
    AND_inp_5 and_inst (vals[0], vals[1], vals[2], vals[3], vals[4], up_out);

endmodule