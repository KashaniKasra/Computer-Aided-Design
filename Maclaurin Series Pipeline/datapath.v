module Datapath (input clk, rst, src, load, input[7:0] X, input[2:0] N, output overflow, error, output[31:0] Y);

    wire in_ov1, out_ov1, in_ov2, out_ov2, in_ov3, out_ov3, in_ov4, out_ov4, in_ov_FB;
    wire[2:0] in_addr1, out_addr1, in_addr2, out_addr2, in_addr3, out_addr3, in_addr4, out_addr4, in_addr_FB;
    wire[3:0] in_N1, out_N1, in_N2, out_N2, in_N3, out_N3, in_N4, out_N4, in_N_FB;
    wire[15:0] in_X1, out_X1, in_X2, out_X2, in_X3, out_X3, in_X4, out_X4, in_X_FB, in_Xn1, out_Xn1, in_Xn2, out_Xn2, in_Xn3, out_Xn3, in_Xn4, out_Xn4, in_Xn_FB, c1, c2, c3, c4;
    wire[31:0] in_res1, out_res1, in_res2, out_res2, in_res3, out_res3, in_res4, out_res4, in_res_FB;

    Register_set register_pipe1(clk, rst, load, in_ov1, in_addr1, in_N1, in_X1, in_Xn1, in_res1, out_ov1, out_addr1, out_N1, out_X1, out_Xn1, out_res1);
    Register_set register_pipe2(clk, rst, load, in_ov2, in_addr2, in_N2, in_X2, in_Xn2, in_res2, out_ov2, out_addr2, out_N2, out_X2, out_Xn2, out_res2);
    Register_set register_pipe3(clk, rst, load, in_ov3, in_addr3, in_N3, in_X3, in_Xn3, in_res3, out_ov3, out_addr3, out_N3, out_X3, out_Xn3, out_res3);
    Register_set register_pipe4(clk, rst, load, in_ov4, in_addr4, in_N4, in_X4, in_Xn4, in_res4, out_ov4, out_addr4, out_N4, out_X4, out_Xn4, out_res4);

    Multiplexer #(4) multiplexer_first_N(src, {1'b0, N}, in_N_FB, in_N1);
    Multiplexer #(16) multiplexer_first_X(src, {X, 8'b0}, in_X_FB, in_X1);
    Multiplexer #(16) multiplexer_first_Xn(src, {X, 8'b0}, in_Xn_FB, in_Xn1);
    Multiplexer #(32) multiplexer_first_res(src, 32'b0, in_res_FB, in_res1);
    Multiplexer #(1) multiplexer_first_ov(src, 1'b0, in_ov_FB, in_ov1);
    Multiplexer #(3) multiplexer_first_addr(src, 3'b0, in_addr_FB, in_addr1);

    Pipe pipe1(out_ov1, out_addr1, out_N1, out_X1, out_Xn1, c1, out_res1, in_ov2, in_addr2, in_N2, in_X2, in_Xn2, in_res2);
    Pipe pipe2(out_ov2, out_addr2, out_N2, out_X2, out_Xn2, c2, out_res2, in_ov3, in_addr3, in_N3, in_X3, in_Xn3, in_res3);
    Pipe pipe3(out_ov3, out_addr3, out_N3, out_X3, out_Xn3, c3, out_res3, in_ov4, in_addr4, in_N4, in_X4, in_Xn4, in_res4);
    Pipe pipe4(out_ov4, out_addr4, out_N4, out_X4, out_Xn4, c4, out_res4, in_ov_FB, in_addr_FB, in_N_FB, in_X_FB, in_Xn_FB, in_res_FB);

    Error_detector error_detector(X, error);

    LUT lut(out_addr1, out_addr2, out_addr3, out_addr4, c1, c2, c3, c4);

    assign Y = in_res_FB;
    assign overflow = in_ov_FB;

endmodule