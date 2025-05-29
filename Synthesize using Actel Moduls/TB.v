`timescale 1ps / 1ps
module TB;
    // wires and regs
    reg clk = 0, rst = 0, reset = 0, start = 0;
    reg [15:0] inp1;
    reg [15:0] inp2;
    wire done;
    wire [15:0] out;

    // toplevel module instance
    aprox_multiplier cut(clk, rst, start, reset, inp1, inp2, done, out);

    // clock toggling
    always #5 clk = ~clk; 

    // determining inputs
    initial begin
        reset = 1;
        rst = 1;
        clk = 0;
        start = 0;
        inp1 = 16'b0;
        inp2 = 16'b0;
        
        #20
        reset = 0;

        // first set of inputs
        #10 rst = 0;
        inp1 = 16'h2000; 
        inp2 = 16'h2000; 
        
        #20;
        start = 1;
        #10 start = 0;

        // wait for done signal to toggle
        wait(done);

        // second set of inputs
        #10 rst = 0;
        inp1 = 16'h8000; 
        inp2 = 16'h8000; 
        
        #20;
        start = 1;
        #10 start = 0;

        // wait for done signal to toggle
        wait(done);

        // third set of inputs
        #10 rst = 0;
        inp1 = 16'h0d00; 
        inp2 = 16'h0600; 
        
        #20;
        start = 1;
        #10 start = 0;

        // wait for done signal to toggle
        wait(done);

        // fourth set of inputs
        #40;
        inp1 = 16'h0b00; 
        inp2 = 16'h0070; 
        
        #20;
        start = 1;
        #10 start = 0;

        // wait for the done signal
        wait(done);

        // fifth set of inputs
        #40;
        inp1 = 16'h0030; 
        inp2 = 16'h00a0; 
        
        #20;
        start = 1;
        #10 start = 0;

        // wait for the done signal
        wait(done);
        
        // end of testbench
        #40;
        $stop;
    end
endmodule
