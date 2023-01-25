module MLD_15_7_Encoder_test_bench;
	reg reset, clk, information_bit, sel;
	wire out;

	MLD_15_7_encoder DUT(clk, reset, out, information_bit, sel);

	initial clk = 0;
	always #5 clk = ~clk;

	initial begin
		$dumpfile("Multi_Step_MLD_encoder.vcd");
		$dumpvars(0, MLD_15_7_Encoder_test_bench);
		$monitor($time, ": Bit sent into Channel: %b", out);
		information_bit = 1'b0;
		reset = 1'b1;
		#7 reset = 1'b0;
		information_bit = 1'b1;
		#10 information_bit = 1'b1;
		#10 information_bit = 1'b0;
		#10 information_bit = 1'b1;
		#10 information_bit = 1'b0;
		#10 sel = 1'b1;
		information_bit = 1'b0;
		#100 $finish;
	end
endmodule
