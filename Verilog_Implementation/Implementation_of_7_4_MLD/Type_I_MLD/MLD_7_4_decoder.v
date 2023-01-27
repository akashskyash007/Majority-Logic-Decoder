module MLD_7_4_decoder(clk, reset, load, received_bit_stream, output_bit_stream, correct_errors);
	input clk, reset, load, correct_errors;
	input received_bit_stream;
	output output_bit_stream;
	wire parity_check_sum_1, parity_check_sum_2, parity_check_sum_3;
	wire M;
	reg error_value;
	wire s0_input, s1_input, s2_input, s3_input;
	wire s0, s1, s2, s3;
	reg buffer_register_input;
	wire buffer_register_output;

	assign parity_check_sum_1 = s3;
	assign parity_check_sum_2 = s1;
	assign s1_input = s0;

	d_flip_flop SYNDROME_FF_0(reset, clk, s0_input, s0);
	d_flip_flop SYNDROME_FF_1(reset, clk, s1_input, s1);
	d_flip_flop SYNDROME_FF_2(reset, clk, s2_input, s2);
	d_flip_flop SYNDROME_FF_3(reset, clk, s3_input, s3);
	majority_gate_3_input MAJORITY_LOGIC(M, parity_check_sum_1, parity_check_sum_2, parity_check_sum_3);
	shift_register_7_bit BUFFER_REGISTER(reset, clk, buffer_register_input, buffer_register_output);
	xor ERROR_CORRECTOR(output_bit_stream, buffer_register_output, error_value);
	xor CHECK_SUM_3_CALCULATOR(parity_check_sum_3, s0, s2);
	xor S0_INPUT_CALCULATOR(s0_input, buffer_register_input, error_value, s3);
	xor S2_INPUT_CALCULATOR(s2_input, s3, s1);
	xor S3_INPUT_CALCULATOR(s3_input, s3, s2);
	
	always @(*) begin
		if (load) begin
			buffer_register_input = received_bit_stream;
		end
		else begin
			buffer_register_input = 1'b0;
		end
		if (correct_errors)
			error_value = 1'b0;
		else
			error_value = M;
	end
endmodule
