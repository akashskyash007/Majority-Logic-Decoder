module MLD_7_4_decoder(clk, reset, load, received_vector, decoded_vector);
	input clk, reset, load;
	input[0:6] received_vector;
	output[0:6] decoded_vector;
	reg w0, w1, w2, w3, w4, w5, w6;
	reg parity_check_sum_1, parity_check_sum_2, parity_check_sum_3;
	wire error_value;

	d_flip_flop FF1(reset, clk, w0, decoded_vector[0]);
	d_flip_flop FF2(reset, clk, w1, decoded_vector[1]);
	d_flip_flop FF3(reset, clk, w2, decoded_vector[2]);
	d_flip_flop FF4(reset, clk, w3, decoded_vector[3]);
	d_flip_flop FF5(reset, clk, w4, decoded_vector[4]);
	d_flip_flop FF6(reset, clk, w5, decoded_vector[5]);
	d_flip_flop FF7(reset, clk, w6, decoded_vector[6]);
	majority_gate_3_input M(error_value, parity_check_sum_1, parity_check_sum_2, parity_check_sum_3);

	always @(*) begin
		if (load) begin
			w0 = received_vector[0];
			w1 = received_vector[1];
			w2 = received_vector[2]; 
			w3 = received_vector[3];
			w4 = received_vector[4];
			w5 = received_vector[5];
			w6 = received_vector[6];
		end
		else begin
			w0 = decoded_vector[6] ^ error_value;
			w1 = decoded_vector[0];
			w2 = decoded_vector[1];
			w3 = decoded_vector[2];
			w4 = decoded_vector[3];
			w5 = decoded_vector[4];
			w6 = decoded_vector[5];
		end
		parity_check_sum_1 = decoded_vector[3] ^ decoded_vector[4] ^ decoded_vector[6];
		parity_check_sum_2 = decoded_vector[1] ^ decoded_vector[5] ^ decoded_vector[6];
		parity_check_sum_3 = decoded_vector[0] ^ decoded_vector[2] ^ decoded_vector[6];
	end
endmodule
