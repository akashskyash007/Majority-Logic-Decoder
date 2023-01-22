module MLD_7_4_Encoder_test_bench;
	reg reset, clk, information_bit;
	wire[3:0] parity_vector;

	MLD_7_4_encoder DUT(clk, reset, parity_vector, information_bit);

	initial clk = 0;
	always #5 clk = ~clk;

	initial begin
		$dumpfile("MLD_7_4_encoder.vcd");
		$dumpvars(0, MLD_7_4_Encoder_test_bench);
		$monitor("Parity Bits Generated: %b, %b, %b, %b", parity_vector[0], parity_vector[1], parity_vector[2], parity_vector[3]);
		information_bit = 1'b0;
		reset = 1'b1;
		#7 reset = 1'b0;
		information_bit = 1'b1;
		#10 information_bit = 1'b0;
		#10 information_bit = 1'b1;
		#10 $finish;
	end
endmodule
