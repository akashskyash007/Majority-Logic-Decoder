module full_adder(sum, carry, in1, in2, in3);
	input in1, in2, in3;
	output sum, carry;
	wire t0, t1, t2;

	xor G1(sum, in1, in2, in3);
	and G2(t0, in1, in2);
	and G3(t1, in2, in3);
	and G4(t2, in1, in3);
	or G5(carry, t0, t1, t2);
endmodule
