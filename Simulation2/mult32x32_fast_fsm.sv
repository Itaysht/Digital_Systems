// 32X32 Multiplier FSM
module mult32x32_fast_fsm (
    input logic clk,              // Clock
    input logic reset,            // Reset
    input logic start,            // Start signal
    input logic a_msb_is_0,       // Indicates MSB of operand A is 0
    input logic b_msw_is_0,       // Indicates MSW of operand B is 0
    output logic busy,            // Multiplier busy indication
    output logic [1:0] a_sel,     // Select one byte from A
    output logic b_sel,           // Select one 2-byte word from B
    output logic [2:0] shift_sel, // Select output from shifters
    output logic upd_prod,        // Update the product register
    output logic clr_prod         // Clear the product register
);

typedef enum {A, B, C, D, E, F, G, H, I} state;

state current_state;
state next_state;

always_ff @ (posedge clk, posedge reset) begin
	if (reset == 1'b1) begin
		current_state <= A;
	end
	else begin
		current_state <= next_state;
	end
end

always_comb begin
	next_state = current_state;
	busy = 1'b0;
	a_sel = 2'b00;
	b_sel = 1'b0;
	shift_sel = 3'b000;
	upd_prod = 1'b0;
	clr_prod = 1'b0;

	case (current_state)
	A: begin
		if (start == 1'b1) begin
			next_state = B;
			clr_prod = 1'b1;
			a_sel = 2'b00;
			b_sel = 1'b0;
			shift_sel = 3'b000;
			upd_prod = 1'b0;
			busy = 1'b0;
		end
		else begin
			busy = 1'b0;
		end
	end
	B: begin
		next_state = C;
		busy = 1'b1;
		a_sel = 2'b00;
		b_sel = 1'b0;
		shift_sel = 3'b000;
		upd_prod = 1'b1;
		clr_prod = 1'b0;
	end
	C: begin
		next_state = D;
		busy = 1'b1;
		a_sel = 2'b01;
		b_sel = 1'b0;
		shift_sel = 3'b001;
		upd_prod = 1'b1;
		clr_prod = 1'b0;
	end
	D: begin
		next_state = E;
		busy = 1'b1;
		a_sel = 2'b10;
		b_sel = 1'b0;
		shift_sel = 3'b010;
		upd_prod = 1'b1;
		clr_prod = 1'b0;
	end
	E: begin
		next_state = F;
		busy = 1'b1;
		a_sel = 2'b11;
		b_sel = 1'b0;
		if (a_msb_is_0 == 1'b1) begin
			shift_sel = 3'b111;
		end
		else begin
			shift_sel = 3'b011;
		end
		upd_prod = 1'b1;
		clr_prod = 1'b0;
	end
	F: begin
		if (b_msw_is_0 == 1'b1) begin
			next_state = A;
			shift_sel = 3'b111;
			b_sel = 1'b0;
			busy = 1'b0;
		end
		else begin
			next_state = G;
			busy = 1'b1;
			shift_sel = 3'b010;
			b_sel = 1'b1;
		end
		a_sel = 2'b00;
		upd_prod = 1'b1;
		clr_prod = 1'b0;
	end
	G: begin
		next_state = H;
		busy = 1'b1;
		a_sel = 2'b01;
		b_sel = 1'b1;
		shift_sel = 3'b011;
		upd_prod = 1'b1;
		clr_prod = 1'b0;
	end
	H: begin
		next_state = I;
		busy = 1'b1;
		a_sel = 2'b10;
		b_sel = 1'b1;
		shift_sel = 3'b100;
		upd_prod = 1'b1;
		clr_prod = 1'b0;
	end
	I: begin
		next_state = A;
		busy = 1'b1;
		a_sel = 2'b11;
		b_sel = 1'b1;
		if (a_msb_is_0 == 1'b1) begin
			shift_sel = 3'b111;
		end
		else begin
			shift_sel = 3'b101;
		end
		upd_prod = 1'b1;
		clr_prod = 1'b0;
	end
	endcase
end

endmodule
