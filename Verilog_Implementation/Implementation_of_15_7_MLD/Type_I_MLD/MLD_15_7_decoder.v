module MLD_15_7_decoder(clk, reset, load, received_bit_stream, output_bit_stream, correct_errors);
	input clk, reset, load, correct_errors;
	input received_bit_stream;
	output output_bit_stream;
	wire parity_check_sum_1, parity_check_sum_2, parity_check_sum_3, parity_check_sum_4;
	wire M;
	reg error_value;
	wire s0_input, s1_input, s2_input, s3_input, s4_input, s5_input, s6_input, s7_input;
	wire s0, s1, s2, s3, s4, s5, s6, s7;
	reg buffer_register_input;
	wire buffer_register_output;

	assign parity_check_sum_1 = s3;
	assign parity_check_sum_4 = s7;
	assign s1_input = s0;
	assign s2_input = s1;
	assign s3_input = s2;
	assign s5_input = s4;

	d_flip_flop SYNDROME_FF_0(reset, clk, s0_input, s0);
	d_flip_flop SYNDROME_FF_1(reset, clk, s1_input, s1);
	d_flip_flop SYNDROME_FF_2(reset, clk, s2_input, s2);
	d_flip_flop SYNDROME_FF_3(reset, clk, s3_input, s3);
	d_flip_flop SYNDROME_FF_4(reset, clk, s4_input, s4);
	d_flip_flop SYNDROME_FF_5(reset, clk, s5_input, s5);
	d_flip_flop SYNDROME_FF_6(reset, clk, s6_input, s6);
	d_flip_flop SYNDROME_FF_7(reset, clk, s7_input, s7);

	majority_gate_4_input MAJORITY_LOGIC(M, parity_check_sum_1, parity_check_sum_2, parity_check_sum_3, parity_check_sum_4);

	shift_register_15_bit BUFFER_REGISTER(reset, clk, buffer_register_input, buffer_register_output);

	xor ERROR_CORRECTOR(output_bit_stream, buffer_register_output, error_value);
	xor CHECK_SUM_2_CALCULATOR(parity_check_sum_2, s1, s5);
	xor CHECK_SUM_3_CALCULATOR(parity_check_sum_3, s0, s2, s6);
	xor S0_INPUT_CALCULATOR(s0_input, buffer_register_input, error_value, s7);
	xor S4_INPUT_CALCULATOR(s4_input, s3, s7);
	xor S6_INPUT_CALCULATOR(s6_input, s5, s7);
	xor S7_INPUT_CALCULATOR(s7_input, s6, s7);

	always @(*) begin
		if (load)
			buffer_register_input = received_bit_stream;
		else
			buffer_register_input = 1'b0;
		if (correct_errors)
			error_value = 1'b0;
		else
			error_value = M;
	end
endmodule
