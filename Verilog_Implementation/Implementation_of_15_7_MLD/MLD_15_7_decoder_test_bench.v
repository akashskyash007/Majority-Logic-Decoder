module MLD_15_7_decoder_test_bench;
	reg clk, reset, load;
	reg[0:14] received_vector;
	wire[0:14] decoded_vector;
	
	MLD_15_7_decoder DUT(clk, reset, load, received_vector, decoded_vector);

	initial clk = 1'b0;
	always #5 clk = ~clk;

	initial begin
		$dumpfile("MLD_15_7_decoder.vcd");
		$dumpvars(0, MLD_15_7_decoder_test_bench);
		$monitor("Decoded Vector: %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b", decoded_vector[0], decoded_vector[1], decoded_vector[2], decoded_vector[3], decoded_vector[4], decoded_vector[5], decoded_vector[6], decoded_vector[7], decoded_vector[8], decoded_vector[9], decoded_vector[10], decoded_vector[11], decoded_vector[12], decoded_vector[13], decoded_vector[14]);
		#2 load = 1'b1;
		received_vector = 15'b000001110010111;
		#10 load = 1'b0;
		#148 $finish;
	end	
endmodule
