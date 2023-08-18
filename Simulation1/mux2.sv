// 2->1 multiplexer template
module mux2 (
    input logic d0,          // Data input 0
    input logic d1,          // Data input 1
    input logic sel,         // Select input
    output logic z           // Output
);

logic g1g3, g3g5, g5g6, g2g4, g4g6;
NAND2 nand1 (d0, d0, g1g3);
NAND2 nand2 (sel, d1, g2g4);
OR2 or1 (sel, g1g3, g3g5);
NAND2 nand3 (g2g4, g2g4, g4g6);
NAND2 nand4 (g3g5, g3g5, g5g6);
OR2 or2 (g4g6, g5g6, z);

endmodule
