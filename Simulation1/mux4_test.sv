// 4->1 multiplexer test bench template
module mux4_test;

	logic k0, k1, k2, k3, z0;
	logic [1:0] sel;
	

	mux4 uut (.d0(k0), .d1(k1), .d2(k2), .d3(k3), .sel(sel), .z(z0));
	initial begin
		k0 = 0;
		k1 = 0;
		k2 = 0;
		k3 = 0;
		sel[0] = 0;
		sel[1] = 0;

		#30
		k0 = 1;

		#30
		k0 = 0;

		#30
		$stop;
	end
endmodule
