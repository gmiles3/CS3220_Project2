module ALU(opsel, A, B, out);
	input[5:0] opsel;
	input signed[31:0] A, B;
	output reg[31:0] out;
	
	parameter TRUE=32'b1, FALSE=32'b0;
	parameter ADD=6'h00, SUB=6'h01, AND=6'h04, OR=6'h05, XOR=6'h06, NAND=6'h0C, NOR=6'h0D, XNOR=6'h0E, MVHI=6'h0B;
	parameter F=6'h10, EQ=6'h11, LT=6'h12, LTE=6'h13, EQZ=6'h15, LTZ=6'h16, LTEZ=6'h17, T=6'h18, NE=6'h19, GTE=6'h1A, GT=6'h1B, NEZ=6'h1D, GTEZ=6'h1E, GTZ=6'h1F;
	parameter JAL=6'h20;
	
	always @(*) begin
		out <= 0;
		case(opsel)
			ADD: 
				out <= A + B;
			SUB:
				out <= A - B;
			AND:
				out <= A & B;
			OR:
				out <= A | B;
			XOR:
				out <= A ^ B;
			NAND:
				out <= ~(A & B);
			NOR:
				out <= ~(A | B);
			XNOR:
				out <= ~(A ^ B);
			MVHI:
				out <= {B[15:0], 16'b0};
			F:
				out <= FALSE;
			EQ:
				out <= (A == B) ? TRUE : FALSE;
			LT:
				out <= (A < B) ? TRUE : FALSE;
			LTE:
				out <= (A <= B) ? TRUE : FALSE;
			EQZ:
				out <= (A == 0) ? TRUE : FALSE;
			LTZ:
				out <= (A < 0) ? TRUE : FALSE;
			LTEZ:
				out <= (A <= 0) ? TRUE : FALSE;
			T:
				out <= TRUE;
			NE:
				out <= (A == B) ? FALSE : TRUE;
			GTE:
				out <= (A >= B) ? TRUE : FALSE;
			GT:
				out <= (A > B) ? TRUE : FALSE;
			NEZ:
				out <= (A == 0) ? TRUE : FALSE;
			GTEZ:
				out <= (A >= 0) ? TRUE : FALSE;
			GTZ:
				out <= (A > 0) ? TRUE : FALSE;
			JAL:
				out <= A + (B*4);
		endcase
	end
endmodule
			
			
	
	
	