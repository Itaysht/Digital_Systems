// 1-bit ALU template
module alu1bit (
    input logic a,           // Input bit a
    input logic b,           // Input bit b
    input logic cin,         // Carry in
    input logic [1:0] op,    // Operation
    output logic s,          // Output S
    output logic cout        // Carry out
);

logic g1g3, g2g4, g3d0, g4d1, g5ans, fasd2;

OR2 or1 (a, b, g1g3);
XNOR2 xnor1 (a, b, g2g4);
NAND2 nand1 (g1g3, g1g3, g3d0);
NAND2 nand2 (g2g4, g2g4, g4d1);
NAND2 nand3 (op[0], op[0], g5ans);
fas fas1 (.a(a), .b(b), .cin(cin), .a_ns(g5ans), .s(fasd2), .cout(cout));
mux4 mux1 (.d0(g3d0), .d1(g4d1), .d2(fasd2), .d3(fasd2), .sel(op), .z(s));

endmodule
