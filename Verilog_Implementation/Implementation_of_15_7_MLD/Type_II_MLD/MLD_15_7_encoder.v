module MLD_15_7_encoder(clk, reset, out, information_bit, sel);
	input clk, reset, information_bit, sel;
	output out;
	reg ff1_input, ff2_input, ff3_input, ff4_input, ff5_input, ff6_input, ff7_input, ff8_input;
	wire ff1_output, ff2_output, ff3_output, ff4_output, ff5_output, ff6_output, ff7_output, ff8_output;
	wire gate_input, gate_output;
	wire final_flip_flop_output_after_delay;

	assign gate_input = ff8_output ^ information_bit;	

	d_flip_flop FF1(reset, clk, ff1_input, ff1_output);
	d_flip_flop FF2(reset, clk, ff2_input, ff2_output);
	d_flip_flop FF3(reset, clk, ff3_input, ff3_output);
	d_flip_flop FF4(reset, clk, ff4_input, ff4_output);
	d_flip_flop FF5(reset, clk, ff5_input, ff5_output);
	d_flip_flop FF6(reset, clk, ff6_input, ff6_output);
	d_flip_flop FF7(reset, clk, ff7_input, ff7_output);
	d_flip_flop FF8(reset, clk, ff8_input, ff8_output);
	mux_2_1 SWITCH(information_bit, final_flip_flop_output_after_delay, out, sel);
	mux_2_1 GATE(gate_input, 1'b0, gate_output, sel);
	buf #2 G1(final_flip_flop_output_after_delay, ff8_output);

	always @(*) begin
		ff1_input = gate_output;
		ff2_input = ff1_output;
		ff3_input = ff2_output;
		ff4_input = ff3_output;
		ff5_input = ff4_output ^ gate_output;
		ff6_input = ff5_output;
		ff7_input = ff6_output ^ gate_output;
		ff8_input = ff7_output ^ gate_output;
	end
endmodule
