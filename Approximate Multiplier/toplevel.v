module Toplevel (input clk, rst, start, output done);

    wire clrL, shL, loadL, serIn, clr1, load1, clr2, load2, clr3, cnt3, clr4, cnt4, clr5, cnt5, we, serOut, x15, co3, co4, co5;
    wire[3:0] num4, num5;

    Datapath DP (clk, rst, clrL, shL, loadL, serIn, clr1, load1, clr2, load2, clr3, cnt3, clr4, cnt4, clr5, cnt5, we, serOut, x15, co3, co4, co5, num4, num5);

    Controller CR (clk, rst, start, serOut, x15, co3, co4, co5, num4, num5, clrL, shL, loadL, serIn, clr1, load1, clr2, load2, clr3, cnt3, clr4, cnt4, clr5, cnt5, we, done);

endmodule