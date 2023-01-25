module Multi_Step_MLD_decoder_test_bench;
	reg clk, reset, load;
	reg received_bit_stream;
	wire[0:14] decoded_vector;
	
	Multi_Step_MLD_decoder DUT(clk, reset, load, received_bit_stream, decoded_vector);

	initial clk = 1'b0;
	always #5 clk = ~clk;

	initial begin
		$dumpfile("Multi_Step_MLD_decoder.vcd");
		$dumpvars(0, Multi_Step_MLD_decoder_test_bench);
		$monitor("Decoded Vector: %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b, Error Value: %b", decoded_vector[0], decoded_vector[1], decoded_vector[2], decoded_vector[3], decoded_vector[4], decoded_vector[5], decoded_vector[6], decoded_vector[7], decoded_vector[8], decoded_vector[9], decoded_vector[10], decoded_vector[11], decoded_vector[12], decoded_vector[13], decoded_vector[14], DUT.error_value);
		#2 load = 1'b1;
		received_bit_stream = 1'b0;
		#10 received_bit_stream = 1'b1;
		#10 received_bit_stream = 1'b1;
		#10 received_bit_stream = 1'b0;
		#10 received_bit_stream = 1'b0;
		#10 received_bit_stream = 1'b1;
		#10 received_bit_stream = 1'b1;
		#10 received_bit_stream = 1'b0;
		#10 received_bit_stream = 1'b1;
		#10 received_bit_stream = 1'b1;
		#10 received_bit_stream = 1'b1;
		#10 received_bit_stream = 1'b0;
		#10 received_bit_stream = 1'b1;
		#10 received_bit_stream = 1'b0;
		#10 received_bit_stream = 1'b1;
		#10 load = 1'b0;
		#148 $finish;
	end	
endmodule
