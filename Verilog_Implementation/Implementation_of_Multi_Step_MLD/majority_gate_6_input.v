module majority_gate_6_input(out, in1, in2, in3, in4, in5, in6);
	input in1, in2, in3, in4, in5, in6;
	output out;
	wire S1, S2, S3;
	wire C1, C2, C3;
	wire S1_bar, S2_bar;
	wire C_bar;

	assign out = C_bar;

	full_adder FA1(S1, C1, in1, in2, in3);
	full_adder FA2(S2, C2, in4, in5, in6);
	full_adder FA3(S1_bar, C3, S1, S2, 1'b0);
	full_adder FA4(S2_bar, C_bar, C1, C2, C3);
endmodule
