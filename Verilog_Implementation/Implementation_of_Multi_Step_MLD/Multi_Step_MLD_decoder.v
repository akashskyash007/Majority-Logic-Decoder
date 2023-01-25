module Multi_Step_MLD_decoder(clk, reset, load, received_bit_stream, decoded_vector);
	input clk, reset, load;
	input received_bit_stream;
	output[0:14] decoded_vector;
	reg w0;
	reg A11, A12, A13, A14, A15, A16;
	reg A21, A22, A23, A24, A25, A26;
	reg A31, A32, A33, A34, A35, A36;
	reg A41, A42, A43, A44, A45, A46;
	reg A51, A52, A53, A54, A55, A56;
	reg A61, A62, A63, A64, A65, A66;
	wire M1, M2, M3, M4, M5, M6;
	wire error_value;

	d_flip_flop FF1(reset, clk, w0, decoded_vector[0]);
	d_flip_flop FF2(reset, clk, decoded_vector[0], decoded_vector[1]);
	d_flip_flop FF3(reset, clk, decoded_vector[1], decoded_vector[2]);
	d_flip_flop FF4(reset, clk, decoded_vector[2], decoded_vector[3]);
	d_flip_flop FF5(reset, clk, decoded_vector[3], decoded_vector[4]);
	d_flip_flop FF6(reset, clk, decoded_vector[4], decoded_vector[5]);
	d_flip_flop FF7(reset, clk, decoded_vector[5], decoded_vector[6]);
	d_flip_flop FF8(reset, clk, decoded_vector[6], decoded_vector[7]);
	d_flip_flop FF9(reset, clk, decoded_vector[7], decoded_vector[8]);
	d_flip_flop FF10(reset, clk, decoded_vector[8], decoded_vector[9]);
	d_flip_flop FF11(reset, clk, decoded_vector[9], decoded_vector[10]);
	d_flip_flop FF12(reset, clk, decoded_vector[10], decoded_vector[11]);
	d_flip_flop FF13(reset, clk, decoded_vector[11], decoded_vector[12]);
	d_flip_flop FF14(reset, clk, decoded_vector[12], decoded_vector[13]);
	d_flip_flop FF15(reset, clk, decoded_vector[13], decoded_vector[14]);
	majority_gate_6_input MG1(M1, A11, A12, A13, A14, A15, A16);
	majority_gate_6_input MG2(M2, A21, A22, A23, A24, A25, A26);
	majority_gate_6_input MG3(M3, A31, A32, A33, A34, A35, A36);
	majority_gate_6_input MG4(M4, A41, A42, A43, A44, A45, A46);
	majority_gate_6_input MG5(M5, A51, A52, A53, A54, A55, A56);
	majority_gate_6_input MG6(M6, A61, A62, A63, A64, A65, A66);
	majority_gate_6_input MG7(error_value, M1, M2, M3, M4, M5, M6);

	always @(*) begin
		if (load) begin
			w0 = received_bit_stream;
		end
		else begin
			w0 = decoded_vector[14] ^ error_value;
		end

		A11 = decoded_vector[4] ^ decoded_vector[10] ^ decoded_vector[13] ^ decoded_vector[14];
		A12 = decoded_vector[7] ^ decoded_vector[12] ^ decoded_vector[13] ^ decoded_vector[14];
		A13 = decoded_vector[9] ^ decoded_vector[11] ^ decoded_vector[13] ^ decoded_vector[14];
		A14 = decoded_vector[0] ^ decoded_vector[8] ^ decoded_vector[13] ^ decoded_vector[14];
		A15 = decoded_vector[1] ^ decoded_vector[5] ^ decoded_vector[13] ^ decoded_vector[14];
		A16 = decoded_vector[3] ^ decoded_vector[6] ^ decoded_vector[13] ^ decoded_vector[14];

                A21 = decoded_vector[0] ^ decoded_vector[10] ^ decoded_vector[12] ^ decoded_vector[14];
                A22 = decoded_vector[3] ^ decoded_vector[11] ^ decoded_vector[12] ^ decoded_vector[14];
                A23 = decoded_vector[7] ^ decoded_vector[13] ^ decoded_vector[12] ^ decoded_vector[14];
                A24 = decoded_vector[1] ^ decoded_vector[2] ^ decoded_vector[12] ^ decoded_vector[14];
                A25 = decoded_vector[4] ^ decoded_vector[8] ^ decoded_vector[12] ^ decoded_vector[14];
                A26 = decoded_vector[6] ^ decoded_vector[9] ^ decoded_vector[12] ^ decoded_vector[14];

                A31 = decoded_vector[3] ^ decoded_vector[12] ^ decoded_vector[11] ^ decoded_vector[14];
                A32 = decoded_vector[9] ^ decoded_vector[13] ^ decoded_vector[11] ^ decoded_vector[14];
                A33 = decoded_vector[0] ^ decoded_vector[5] ^ decoded_vector[11] ^ decoded_vector[14];
                A34 = decoded_vector[1] ^ decoded_vector[8] ^ decoded_vector[11] ^ decoded_vector[14];
                A35 = decoded_vector[2] ^ decoded_vector[4] ^ decoded_vector[11] ^ decoded_vector[14];
                A36 = decoded_vector[6] ^ decoded_vector[7] ^ decoded_vector[11] ^ decoded_vector[14];

                A41 = decoded_vector[0] ^ decoded_vector[12] ^ decoded_vector[10] ^ decoded_vector[14];
                A42 = decoded_vector[4] ^ decoded_vector[13] ^ decoded_vector[10] ^ decoded_vector[14];
                A43 = decoded_vector[1] ^ decoded_vector[6] ^ decoded_vector[10] ^ decoded_vector[14];
                A44 = decoded_vector[3] ^ decoded_vector[5] ^ decoded_vector[10] ^ decoded_vector[14];
                A45 = decoded_vector[7] ^ decoded_vector[8] ^ decoded_vector[10] ^ decoded_vector[14];
                A46 = decoded_vector[2] ^ decoded_vector[9] ^ decoded_vector[10] ^ decoded_vector[14];

                A51 = decoded_vector[0] ^ decoded_vector[11] ^ decoded_vector[5] ^ decoded_vector[14];
                A52 = decoded_vector[1] ^ decoded_vector[13] ^ decoded_vector[5] ^ decoded_vector[14];
                A53 = decoded_vector[3] ^ decoded_vector[10] ^ decoded_vector[5] ^ decoded_vector[14];
                A54 = decoded_vector[4] ^ decoded_vector[6] ^ decoded_vector[5] ^ decoded_vector[14];
                A55 = decoded_vector[2] ^ decoded_vector[7] ^ decoded_vector[5] ^ decoded_vector[14];
                A56 = decoded_vector[8] ^ decoded_vector[9] ^ decoded_vector[5] ^ decoded_vector[14];

                A61 = decoded_vector[1] ^ decoded_vector[12] ^ decoded_vector[2] ^ decoded_vector[14];
                A62 = decoded_vector[4] ^ decoded_vector[11] ^ decoded_vector[2] ^ decoded_vector[14];
                A63 = decoded_vector[0] ^ decoded_vector[6] ^ decoded_vector[2] ^ decoded_vector[14];
                A64 = decoded_vector[3] ^ decoded_vector[8] ^ decoded_vector[2] ^ decoded_vector[14];
                A65 = decoded_vector[5] ^ decoded_vector[7] ^ decoded_vector[2] ^ decoded_vector[14];
                A66 = decoded_vector[9] ^ decoded_vector[10] ^ decoded_vector[2] ^ decoded_vector[14];

	end
endmodule
