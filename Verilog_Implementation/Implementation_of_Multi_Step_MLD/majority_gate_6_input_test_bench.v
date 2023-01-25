module majority_gate_6_input_test_bench;
	reg in1, in2, in3, in4, in5, in6;
	wire out;

	majority_gate_6_input DUT(out, in1, in2, in3, in4, in5, in6);

	initial begin
		$dumpfile("majority_gate_6_input.vcd");
		$dumpvars(0, majority_gate_6_input_test_bench);
		$monitor("in1 = %b, in2 = %b, in3 = %b, in4 = %b, in5 = %b, in6 = %b, out = %b", in1, in2, in3, in4, in5, in6, out);

		in1 = 1'b0; in2 = 1'b0; in3 = 1'b0; in4 = 1'b0; in5 = 1'b0; in6 = 1'b0;
		#10 in1 = 1'b1;
		#10 in2 = 1'b1;
		#10 in3 = 1'b1;
		#10 in5 = 1'b1;
		#10 in6 = 1'b1;
		#10 in4 = 1'b0;
		#10 in3 = 1'b0; 
		#10 in2 = 1'b0; 
		#10 in1 = 1'b0;
	end
endmodule
