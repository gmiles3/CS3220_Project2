module ALU(clk, opsel, A, B, out);
	input clk;
	input[5:0] opsel;
	input[31:0] A, B;
	output reg[31:0] out;
	
	parameter ADD=0, SUB=1, AND=4, OR=5, XOR=6, MVHI=11, NAND=12, NOR=13, XNOR=14;
	parameter F=0, EQ=1, LT=2, LTE=3, EQZ=5, LTZ=6, LTEZ=7, T=8, NE=9, GTE=10, GT=11, NEZ=13, GTEZ=14, GTZ=15;
	
	always @(posedge clk) begin
		if (opsel[4])
			case(opsel[3:0])
				F:
					out <= 0;
				EQ:
					out <= (A == B) ? 1 : 0;
				LT:
					out <= (A < B) ? 1 : 0;
				LTE:
					out <= (A <= B) ? 1 : 0;
				EQZ:
					out <= (A == 0) ? 1 : 0;
				LTZ:
					out <= (A < 0) ? 1 : 0;
				LTEZ:
					out <= (A <= 0) ? 1 : 0;
				T:
					out <= 1;
				NE:
					out <= (A == B) ? 0 : 1;
				GTE:
					out <= (A >= B) ? 1 : 0;
				GT:
					out <= (A > B) ? 1 : 0;
				NEZ:
					out <= (A == 0) ? 1 : 0;
				GTEZ:
					out <= (A >= 0) ? 1 : 0;
				GTZ:
					out <= (A > 0) ? 1 : 0;
			endcase
		else if (opsel[5])
			out <= A + (B*4);
		else
			case(opsel[3:0])
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
					out[31:16] <= B[15:0];
			endcase
	end
endmodule
			
			
	
	
	