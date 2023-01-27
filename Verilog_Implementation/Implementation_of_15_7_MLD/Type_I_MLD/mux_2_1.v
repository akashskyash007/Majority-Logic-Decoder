module mux_2_1(in0, in1, out, sel);
	input in0, in1, sel;
	output reg out;

	always @(*) begin
		if (sel)
			out = in1;
		else
			out = in0;
	end
endmodule
