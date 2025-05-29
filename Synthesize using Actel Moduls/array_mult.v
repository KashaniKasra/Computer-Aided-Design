module array_mult #(parameter N = 8) (input [N-1:0] A, B, output [2 * N-1:0] P);
    // wire instances
    wire out_C [N:0][N:0];
    wire out_P [N:0][N:0];
    wire out_X [N:0][N:0];
    wire out_Y [N:0][N:0];

    genvar i,j;
    // assign wires
    generate
        for (i = 0; i < N; i = i + 1) begin : outs
            // X and Y
            assign out_X[i][0] = A[i]; 
            assign out_Y[0][i] = B[i]; 
            // cout values
            assign out_C[i][0] = 1'b0; 
            // product values
            assign out_P[0][i + 1] = 1'b0; 
            assign out_P[i + 1][N] = out_C[i][N];
            assign P[i] = out_P[i + 1][0]; 
            assign P[i + N] = out_P[N][i + 1];
        end
    endgenerate

    // two for loops for instanciating mult units
    generate
        for (i = 0; i < N; i = i + 1) begin : rows
            for (j = 0; j < N; j = j + 1) begin : cols
                mult_unit m_inst(.p_inp(out_P[i][j + 1]), .c_inp(out_C[i][j]), .x_inp(out_X[i][j]), .y_inp(out_Y[i][j]),
                            .c_out(out_C[i][j + 1]), .x_out(out_X[i][j + 1]), .y_out(out_Y[i + 1][j]), .p_out(out_P[i + 1][j]));
            end
        end
    endgenerate
endmodule