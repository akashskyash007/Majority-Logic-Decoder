module MLD_15_7_encoder(clk, reset, parity_vector, information_bit);
	input clk, reset, information_bit;
	output[7:0] parity_vector;
	reg ff1_input, ff2_input, ff3_input, ff4_input, ff5_input, ff6_input, ff7_input, ff8_input;
	wire ff1_output, ff2_output, ff3_output, ff4_output, ff5_output, ff6_output, ff7_output, ff8_output;

	assign parity_vector[0] = ff1_output;
	assign parity_vector[1] = ff2_output;
	assign parity_vector[2] = ff3_output;
	assign parity_vector[3] = ff4_output;
	assign parity_vector[4] = ff5_output;
	assign parity_vector[5] = ff6_output;
	assign parity_vector[6] = ff7_output;
	assign parity_vector[7] = ff8_output;	

	d_flip_flop FF1(reset, clk, ff1_input, ff1_output);
	d_flip_flop FF2(reset, clk, ff2_input, ff2_output);
	d_flip_flop FF3(reset, clk, ff3_input, ff3_output);
	d_flip_flop FF4(reset, clk, ff4_input, ff4_output);
	d_flip_flop FF5(reset, clk, ff5_input, ff5_output);
	d_flip_flop FF6(reset, clk, ff6_input, ff6_output);
	d_flip_flop FF7(reset, clk, ff7_input, ff7_output);
	d_flip_flop FF8(reset, clk, ff8_input, ff8_output);

	always @(*) begin
		ff1_input = ff8_output ^ information_bit;
		ff2_input = ff1_output;
		ff3_input = ff2_output;
		ff4_input = ff3_output;
		ff5_input = ff4_output ^ ff1_input;
		ff6_input = ff5_output;
		ff7_input = ff6_output ^ ff1_input;
		ff8_input = ff7_output ^ ff1_input;
	end
endmodule
