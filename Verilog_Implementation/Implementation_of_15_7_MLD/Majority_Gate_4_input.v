module majority_gate_4_input(out, A, B, C, D);
	input A, B, C, D;
	output out;
	wire w0, w1, w2, w3;
	
	and G1(w0, A, B, C);
	and G2(w1, A, C, D);
	and G3(w2, A, B, D);
	and G4(w3, B, C, D);
	or G5(out, w0, w1, w2, w3);
endmodule
