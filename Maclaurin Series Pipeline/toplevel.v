module toplevel (input clk, rst, start, input[2:0] N, input[7:0] X, output ready, valid, overflow, error, output[31:0] Y);

    wire src, load;

    Datapath dp(clk, rst, src, load, X, N, overflow, error, Y);

    Controller cl(clk, rst, start, overflow, error, N, ready, valid, src, load);

endmodule