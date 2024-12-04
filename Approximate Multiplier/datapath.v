module Datapath (input clk, rst, clrL, shL, loadL, serIn, clr1, load1, clr2, load2, clr3, cnt3, clr4, cnt4, clr5, cnt5, we,
                 output serOut, x15, co3, co4, co5, output[3:0] num4, num5);

    wire[3:0] CNTtoRAM, SHIFTERtoRAM;
    wire[4:0] CNTtoSUB, SUBtoCAT;
    wire[7:0] REG1toMULT, REG2toMULT;
    wire[15:0] RAMtoREG, REGtoREG, MULTtoCAT;
    wire[31:0] CATtoRAM;

    inputRAM inRAM (CNTtoRAM, RAMtoREG);
    outputRAM outRAM (clk, rst, we, SHIFTERtoRAM[2:0], CATtoRAM);
    ShiftRegister ShR (clk, rst, clrL, shL, loadL, 1'b0, RAMtoREG, serOut, REGtoREG);
    Concatenator cat (CNTtoSUB, MULTtoCAT, SUBtoCAT, CATtoRAM);
    Register reg1 (clk, rst, clr1, load1, REGtoREG[15:8], REG1toMULT);
    Register reg2 (clk, rst, clr2, load2, REGtoREG[15:8], REG2toMULT);
    Multiplier mult (REG1toMULT, REG2toMULT, MULTtoCAT);
    Counter #(4) cntr4bit1 (clk, rst, clr5, cnt5, co5, CNTtoRAM);
    Counter #(4) cntr4bit2 (clk, rst, clr4, cnt4, co4, num4);
    Counter #(5) cntr5bit (clk, rst, clr3, cnt3, co3, CNTtoSUB);
    Subtractor sub (CNTtoSUB, SUBtoCAT);
    RightShifter shifter (CNTtoRAM, SHIFTERtoRAM);

    assign num5 = CNTtoRAM;
    assign x15 = REGtoREG[15];

endmodule