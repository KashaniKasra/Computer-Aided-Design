module C2 #(parameter N = 1) (input[N-1:0] D00, D01, D10, D11,input  A1, B1, A0, B0, output[N-1:0]out);
	initial begin 
      $system("c2.exe ");
    end
	wire S1, S0;
	assign S1 = A1 | B1;
	assign S0 = A0 & B0;
	assign out = ({S1, S0} == 2'b00) ? D00 :
			({S1, S0} == 2'b01) ? D01 :
			({S1, S0} == 2'b10) ? D10 :
			({S1, S0} == 2'b11) ? D11 : 2'bxx;
endmodule