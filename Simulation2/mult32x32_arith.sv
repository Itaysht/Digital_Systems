// 32X32 Multiplier arithmetic unit template
module mult32x32_arith (
    input logic clk,             // Clock
    input logic reset,           // Reset
    input logic [31:0] a,        // Input a
    input logic [31:0] b,        // Input b
    input logic [1:0] a_sel,     // Select one byte from A
    input logic b_sel,           // Select one 2-byte word from B
    input logic [2:0] shift_sel, // Select output from shifters
    input logic upd_prod,        // Update the product register
    input logic clr_prod,        // Clear the product register
    output logic [63:0] product  // Miltiplication product
);

logic [63:0] in_pro;
logic [63:0] adder;
logic [7:0] a_mux_41;
logic [15:0] b_mux_41;
logic [23:0] ab_mul;
logic [63:0] adding;

always_comb begin
	adder = product;
	if (a_sel == 2'b00) begin
		a_mux_41 = a[7:0];
	end
	else if (a_sel == 2'b01) begin
		a_mux_41 = a[15:8];
	end
	else if (a_sel == 2'b10) begin
		a_mux_41 = a[23:16];
	end
	else begin
		a_mux_41 = a[31:24];
	end
	if (b_sel == 1'b0) begin
		b_mux_41 = b[15:0];
	end
	else begin
		b_mux_41 = b[31:16];
	end

	ab_mul = a_mux_41 * b_mux_41;

	if (shift_sel == 3'b000) begin
		adding = ab_mul;
	end
	else if (shift_sel == 3'b001) begin
		adding = ab_mul << 8;
	end
	else if (shift_sel == 3'b010) begin
		adding = ab_mul << 16;
	end
	else if (shift_sel == 3'b011) begin
		adding = ab_mul << 24;
	end
	else if (shift_sel == 3'b100) begin
		adding = ab_mul << 32;
	end
	else if (shift_sel == 3'b101) begin
		adding = ab_mul << 40;
	end
	else begin
		adding = 64'd0;
	end
	in_pro = adding + adder;
end

always_ff @ (posedge clk, posedge reset) begin
	if (reset == 1'b1) begin
		product <= 64'd0;
	end

	if (clr_prod == 1'b1) begin
		product <= 64'd0;	
	end
	else if (upd_prod == 1'b1) begin
		product <= in_pro;
	end
end

endmodule
