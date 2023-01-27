module MLD_15_7_decoder_test_bench;
	reg clk, reset, load, correct_errors;
	reg received_bit_stream;
	wire decoded_bit_stream;
	
	MLD_15_7_decoder DUT(clk, reset, load, received_bit_stream, decoded_bit_stream, correct_errors);

	initial clk = 1'b0;
	always #5 clk = ~clk;

	initial begin
		$dumpfile("MLD_15_7_decoder.vcd");
		$dumpvars(0, MLD_15_7_decoder_test_bench);
		$monitor($time, ": Output Bit: %b", decoded_bit_stream);
		#2 reset = 1'b1;
		#10 reset = 1'b0; load = 1'b1; correct_errors = 1'b1;
		received_bit_stream = 1'b1;
		#10 received_bit_stream = 1'b0;
		#10 received_bit_stream = 1'b0;
		#10 received_bit_stream = 1'b0;
		#10 received_bit_stream = 1'b1;
		#10 received_bit_stream = 1'b0;
		#10 received_bit_stream = 1'b0;
		#10 received_bit_stream = 1'b1;
		#10 received_bit_stream = 1'b1;
		#10 received_bit_stream = 1'b1;
		#10 received_bit_stream = 1'b0;
		#10 received_bit_stream = 1'b1;
		#10 received_bit_stream = 1'b0;
		#10 received_bit_stream = 1'b1;
		#10 received_bit_stream = 1'b0;
		#3 correct_errors = 1'b0;
		#7 load = 1'b0;
		#148 $finish;
	end	
endmodule
