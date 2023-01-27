module shift_register_7_bit(reset, clk, in, out);
	input clk, reset, in;
	output out;
	wire ff1_in, ff2_in, ff3_in, ff4_in, ff5_in, ff6_in, ff7_in;
	wire ff1_out, ff2_out, ff3_out, ff4_out, ff5_out, ff6_out, ff7_out;
	
	assign ff1_in = in;
	assign ff2_in = ff1_out;
	assign ff3_in = ff2_out;
	assign ff4_in = ff3_out;
	assign ff5_in = ff4_out;
	assign ff6_in = ff5_out;
	assign ff7_in = ff6_out;
	assign out = ff7_out;

	d_flip_flop FF1(reset, clk, ff1_in, ff1_out);
	d_flip_flop FF2(reset, clk, ff2_in, ff2_out);
	d_flip_flop FF3(reset, clk, ff3_in, ff3_out);
	d_flip_flop FF4(reset, clk, ff4_in, ff4_out);
	d_flip_flop FF5(reset, clk, ff5_in, ff5_out);
	d_flip_flop FF6(reset, clk, ff6_in, ff6_out);
	d_flip_flop FF7(reset, clk, ff7_in, ff7_out);
endmodule
