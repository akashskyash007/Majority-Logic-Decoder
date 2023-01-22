module MLD_15_7_decoder(clk, reset, load, received_vector, decoded_vector);
	input clk, reset, load;
	input[0:14] received_vector;
	output[0:14] decoded_vector;
	reg w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14;
	reg parity_check_sum_1, parity_check_sum_2, parity_check_sum_3, parity_check_sum_4;
	wire error_value;

	d_flip_flop FF1(reset, clk, w0, decoded_vector[0]);
	d_flip_flop FF2(reset, clk, w1, decoded_vector[1]);
	d_flip_flop FF3(reset, clk, w2, decoded_vector[2]);
	d_flip_flop FF4(reset, clk, w3, decoded_vector[3]);
	d_flip_flop FF5(reset, clk, w4, decoded_vector[4]);
	d_flip_flop FF6(reset, clk, w5, decoded_vector[5]);
	d_flip_flop FF7(reset, clk, w6, decoded_vector[6]);
	d_flip_flop FF8(reset, clk, w7, decoded_vector[7]);
	d_flip_flop FF9(reset, clk, w8, decoded_vector[8]);
	d_flip_flop FF10(reset, clk, w9, decoded_vector[9]);
	d_flip_flop FF11(reset, clk, w10, decoded_vector[10]);
	d_flip_flop FF12(reset, clk, w11, decoded_vector[11]);
	d_flip_flop FF13(reset, clk, w12, decoded_vector[12]);
	d_flip_flop FF14(reset, clk, w13, decoded_vector[13]);
	d_flip_flop FF15(reset, clk, w14, decoded_vector[14]);
	majority_gate_4_input M(error_value, parity_check_sum_1, parity_check_sum_2, parity_check_sum_3, parity_check_sum_4);

	always @(*) begin
		if (load) begin
			w0 = received_vector[0];
			w1 = received_vector[1];
			w2 = received_vector[2]; 
			w3 = received_vector[3];
			w4 = received_vector[4];
			w5 = received_vector[5];
			w6 = received_vector[6];
                        w7 = received_vector[7];
                        w8 = received_vector[8];
                        w9 = received_vector[9];
			w10 = received_vector[10];
			w11 = received_vector[11];
			w12 = received_vector[12];
			w13 = received_vector[13];
			w14 = received_vector[14];
		end
		else begin
			w0 = decoded_vector[14] ^ error_value;
			w1 = decoded_vector[0];
			w2 = decoded_vector[1];
			w3 = decoded_vector[2];
			w4 = decoded_vector[3];
			w5 = decoded_vector[4];
			w6 = decoded_vector[5];
			w7 = decoded_vector[6];
			w8 = decoded_vector[7];
			w9 = decoded_vector[8];
			w10 = decoded_vector[9];
			w11 = decoded_vector[10];
			w12 = decoded_vector[11];
			w13 = decoded_vector[12];
			w14 = decoded_vector[13];
		end
		parity_check_sum_1 = decoded_vector[3] ^ decoded_vector[11] ^ decoded_vector[12] ^ decoded_vector[14];
		parity_check_sum_2 = decoded_vector[1] ^ decoded_vector[5] ^ decoded_vector[13] ^ decoded_vector[14];
		parity_check_sum_3 = decoded_vector[0] ^ decoded_vector[2] ^ decoded_vector[6] ^ decoded_vector[14];
		parity_check_sum_4 = decoded_vector[7] ^ decoded_vector[8] ^ decoded_vector[10] ^ decoded_vector[14];
	end
endmodule
