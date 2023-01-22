module d_flip_flop_test_bench;
	reg clk, D, reset;
	wire Q;
	d_flip_flop DUT(reset, clk, D, Q);
	
	initial clk = 1'b0;
	always #5 clk = ~clk;

	initial begin
		$dumpfile("d_flip_flop.vcd");
		$dumpvars(0, d_flip_flop_test_bench);
		$monitor($time, " reset = %b, D = %b, Q = %b", reset, D, Q);
		#2 reset = 1'b1; D = 1'b0;
		#5 reset = 1'b0;
		#10 D = 1'b1;
		#10 D = 1'b0;
		#10 D = 1'b1;
		#10 D = 1'b0;
		#10 D = 1'b0;
		#10 D = 1'b0;
		#10 D = 1'b1;
		#10 D = 1'b1;
		#10 D = 1'b1;
		#10 D = 1'b0;
		#10 $finish;
	end
endmodule
