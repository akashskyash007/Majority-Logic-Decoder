module majority_gate_3_input(M, A, B, C);
	input A, B, C;
	output M;
	wire t0, t1, t2;

	and G1(t0, A, B);
	and G2(t1, B, C);
	and G3(t2, A, C);
	or G4(M, t0, t1, t2);
endmodule
