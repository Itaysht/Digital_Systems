// Full Adder/Subtractor template
module fas (
    input logic a,           // Input bit a
    input logic b,           // Input bit b
    input logic cin,         // Carry in
    input logic a_ns,        // A_nS (add/not subtract) control
    output logic s,          // Output S
    output logic cout        // Carry out
);

logic g1g5, g2g5, g5g6, g6g7, g3g4, g4g7, g8g9;

XNOR2 xnor1 (a, a_ns, g1g5);
OR2 or1 (b, cin, g2g5);
NAND2 nand1 (g1g5, g2g5, g5g6);
NAND2 nand2 (g5g6, g5g6, g6g7);
NAND2 nand3 (b, cin, g3g4);
NAND2 nand4 (g3g4, g3g4, g4g7);
OR2 or2 (g6g7, g4g7, cout);
XNOR2 xnor2 (b, cin, g8g9);
XNOR2 xnor3 (a, g8g9, s);
endmodule
