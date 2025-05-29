module cnt_adder #(parameter N = 8) (input [N-1:0] a, b, input cin, output [N-1:0] s, output cout);
    
    // wires for carry outs
    wire [N-1:0] co;

    genvar idx;
    // instanciate full adders
    generate
    for (idx = 0; idx < N; idx = idx + 1) begin
        // check if in the first iteration
        if (idx == 0)
            FA f_inst(.a(a[0]), .b(b[0]), .c_in(cin), .sum(s[0]), .cout(co[0]));
        else
            FA f_inst(.a(a[idx]), .b(b[idx]), .c_in(co[idx - 1]), .sum(s[idx]), .cout(co[idx]));
    end
    assign cout = co[N - 1];
    endgenerate
endmodule