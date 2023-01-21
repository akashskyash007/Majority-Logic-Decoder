module MLD_7_4_encoder(clk, reset, parity_vector, information_bit);
	input clk, reset, information_bit;
	output[3:0] parity_vector;
	reg ff1_input, ff2_input, ff3_input, ff4_input;
	wire ff1_output, ff2_output, ff3_output, ff4_output;

	assign parity_vector[0] = ff1_output;
	assign parity_vector[1] = ff2_output;
	assign parity_vector[2] = ff3_output;
	assign parity_vector[3] = ff4_output;	

	d_flip_flop FF1(reset, clk, ff1_input, ff1_output);
	d_flip_flop FF2(reset, clk, ff2_input, ff2_output);
	d_flip_flop FF3(reset, clk, ff3_input, ff3_output);
	d_flip_flop FF4(reset, clk, ff4_input, ff4_output);

	always @(*) begin
		ff1_input = ff4_output ^ information_bit;
		ff2_input = ff1_output;
		ff3_input = ff1_input ^ ff2_output;
		ff4_input = ff1_input ^ ff3_output;
	end
endmodule
