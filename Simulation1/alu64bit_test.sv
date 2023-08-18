// 64-bit ALU test bench template
module alu64bit_test;

logic [63:0] a;
logic [63:0] b;
logic [63:0] s;
logic [1:0] op;
logic cin, cout;

alu64bit uut (.a(a), .b(b), .cin(cin), .op(op), .s(s), .cout(cout));
initial begin
	cin = 1;
	op[0] = 0;
	op[1] = 1;
	a = {64{1'b1}};
	b = {64{1'b0}};
	
	#800
	a[0] = 0;

	#800
	$stop;
end

endmodule
