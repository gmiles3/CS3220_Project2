module ALU(opsel, A, B, isCMP, isJAL, out);
	input[5:0] opsel;
	input isCMP, isJAL;
	input signed[31:0] A, B;
	output reg[31:0] out;
	
	parameter TRUE=32'b1, FALSE=32'b0;
	parameter ADD=4'h0, SUB=4'h1, AND=4'h4, OR=4'h5, XOR=4'h6, NAND=4'hC, NOR=4'hD, XNOR=4'hE, MVHI=4'hB;
	parameter F=4'h0, EQ=4'h1, LT=4'h2, LTE=4'h3, EQZ=4'h5, LTZ=4'h6, LTEZ=4'h7, T=4'h8, NE=4'h9, GTE=4'hA, GT=4'hB, NEZ=4'hD, GTEZ=4'hE, GTZ=4'hF;
	
	always @(*) begin
		out <= 0;
		if (isCMP)
			case(opsel)
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
					out <= (A != B) ? TRUE : FALSE;
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
			endcase
		else if (isJAL)
			out <= A + (B*4);
		else
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
			endcase
	end
endmodule
			
			
	
	
	