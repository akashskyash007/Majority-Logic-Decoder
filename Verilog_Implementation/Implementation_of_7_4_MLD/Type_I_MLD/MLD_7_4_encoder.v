module MLD_7_4_encoder(clk, reset, out, information_bit, sel);
	input clk, reset, information_bit, sel;
	output out;
	reg ff1_input, ff2_input, ff3_input, ff4_input;
	wire ff1_output, ff2_output, ff3_output, ff4_output;
	wire gate_input, gate_output;
	wire final_ff_output_after_delay;

	assign gate_input = ff4_output ^ information_bit;	

	d_flip_flop FF1(reset, clk, ff1_input, ff1_output);
	d_flip_flop FF2(reset, clk, ff2_input, ff2_output);
	d_flip_flop FF3(reset, clk, ff3_input, ff3_output);
	d_flip_flop FF4(reset, clk, ff4_input, ff4_output);
	mux_2_1 SWITCH(information_bit, final_ff_output_after_delay, out, sel);
	mux_2_1 GATE(gate_input, 1'b0, gate_output, sel);
	buf #2 G1(final_ff_output_after_delay, ff4_output);

	always @(*) begin
		ff1_input = gate_output;
		ff2_input = ff1_output;
		ff3_input = gate_output ^ ff2_output;
		ff4_input = gate_output ^ ff3_output;
	end
endmodule
