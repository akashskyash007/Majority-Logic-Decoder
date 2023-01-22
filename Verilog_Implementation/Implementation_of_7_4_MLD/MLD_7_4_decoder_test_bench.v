module MLD_7_4_decoder_test_bench;
	reg clk, reset, load;
	reg[0:6] received_vector;
	wire[0:6] decoded_vector;
	
	MLD_7_4_decoder DUT(clk, reset, load, received_vector, decoded_vector);

	initial clk = 1'b0;
	always #5 clk = ~clk;

	initial begin
		$dumpfile("MLD_7_4_decoder.vcd");
		$dumpvars(0, MLD_7_4_decoder_test_bench);
		$monitor("Decoded Vector: %b %b %b %b %b %b %b", decoded_vector[0], decoded_vector[1], decoded_vector[2], decoded_vector[3], decoded_vector[4], decoded_vector[5], decoded_vector[6]);
		#2 load = 1'b1;
		received_vector = 7'b1101110;
		#10 load = 1'b0;
		#68 $finish;
	end	
endmodule
