// 1 bit register module
module reg_unit (input clk, rst, reg_en, input reg_in, output wire reg_out);
    S2 #1 S2_inst (.D01(reg_in), .D10(), .D11(), .D00(reg_out), .A1(1'b0), .B1(1'b0), .A0(reg_en), .B0(1'b1), .CLR(rst), .CLK(clk), .out(reg_out));
endmodule