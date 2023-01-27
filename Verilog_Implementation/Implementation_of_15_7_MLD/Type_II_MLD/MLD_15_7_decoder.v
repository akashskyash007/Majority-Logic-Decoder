module MLD_15_7_decoder(clk, reset, load, received_bit_stream, decoded_vector);
	input clk, reset, load;
	input received_bit_stream;
	output[0:14] decoded_vector;
	reg w0;
	reg parity_check_sum_1, parity_check_sum_2, parity_check_sum_3, parity_check_sum_4;
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
	majority_gate_4_input M(error_value, parity_check_sum_1, parity_check_sum_2, parity_check_sum_3, parity_check_sum_4);

	always @(*) begin
		if (load) begin
			w0 = received_bit_stream;
		end
		else begin
			w0 = decoded_vector[14] ^ error_value;
		end
		parity_check_sum_1 = decoded_vector[3] ^ decoded_vector[11] ^ decoded_vector[12] ^ decoded_vector[14];
		parity_check_sum_2 = decoded_vector[1] ^ decoded_vector[5] ^ decoded_vector[13] ^ decoded_vector[14];
		parity_check_sum_3 = decoded_vector[0] ^ decoded_vector[2] ^ decoded_vector[6] ^ decoded_vector[14];
		parity_check_sum_4 = decoded_vector[7] ^ decoded_vector[8] ^ decoded_vector[10] ^ decoded_vector[14];
	end
endmodule
