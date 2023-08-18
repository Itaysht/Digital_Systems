// Full Adder/Subtractor test bench template
module fas_test;

logic a, b, cin, a_ns, s, cout;

fas uut (.a(a), .b(b), .cin(cin), .a_ns(a_ns), .s(s), .cout(cout));
initial begin

a = 0;
b = 0;
cin = 0;
a_ns = 0;

#20
b = 1;

#20
b = 0;

#20
$stop;
end

endmodule
