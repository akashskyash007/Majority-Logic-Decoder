module d_flip_flop(reset, clk, D, Q);
	input reset, clk, D;
	output reg Q;

	always @(posedge clk) begin
		if (reset)
			Q <= 0;
		else
			Q <= D;
	end
endmodule
