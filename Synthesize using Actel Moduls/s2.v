module S2 #(parameter N = 5) (input[N-1:0] D00, D01, D10, D11, input A1, B1, A0, B0, CLR, CLK, output reg[N-1:0] out);
	initial begin 
      $system("s2-s1.exe ");
    end
	wire S1, S0;
	wire[N-1:0] DFFin;
	assign S1 = A1 | B1;
	assign S0 = A0 & B0;
	assign DFFin = ({S1, S0} == 2'b00) ? D00 :
			({S1, S0} == 2'b01) ? D01 :
			({S1, S0} == 2'b10) ? D10 :
			({S1, S0} == 2'b11) ? D11 : 2'bxx;
	always@(posedge CLK, posedge CLR)
	begin
		if(CLR)
			out <= 0;
		else
			out <= DFFin;
	end
endmodule