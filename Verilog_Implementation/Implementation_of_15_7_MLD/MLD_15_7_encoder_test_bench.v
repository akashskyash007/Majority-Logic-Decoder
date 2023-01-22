module MLD_15_7_Encoder_test_bench;
	reg reset, clk, information_bit;
	wire[7:0] parity_vector;

	MLD_15_7_encoder DUT(clk, reset, parity_vector, information_bit);

	initial clk = 0;
	always #5 clk = ~clk;

	initial begin
		$dumpfile("MLD_15_7_encoder.vcd");
		$dumpvars(0, MLD_15_7_Encoder_test_bench);
		$monitor("Parity Bits Generated: %b, %b, %b, %b, %b, %b, %b, %b", parity_vector[0], parity_vector[1], parity_vector[2], parity_vector[3], parity_vector[4], parity_vector[5], parity_vector[6], parity_vector[7]);
		information_bit = 1'b0;
		reset = 1'b1;
		#7 reset = 1'b0;
		information_bit = 1'b0;
		#10 information_bit = 1'b1;
		#10 information_bit = 1'b1;
		#10 information_bit = 1'b0;
		#10 information_bit = 1'b0;
		#10 information_bit = 1'b0;
		#10 information_bit = 1'b0;
		#10 $finish;
	end
endmodule
