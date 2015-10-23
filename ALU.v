module ALU(clk, opsel, A, B, out);
	input clk;
	input[5:0] opsel;
	input[31:0] A, B;
	output reg[31:0] out;
	
	parameter BF=0, BEQ=1, BLT=2, BLTE=3, BEQZ=5, BLTZ=6, BLTEZ=7, BT=8, BNE=9, BGTE=10, BGT=11, BNEZ=13, BGTEZ=14, BGTZ=15, ADD=16, SUB=17, AND=20, OR=21, XOR=22, MVHI=27, NAND=28, NOR=29, XNOR=30, JALR=32;
	
	always @(posedge clk) begin
		case (opsel)
			BF:
				out <= 0;
			BEQ:
				if (A == B) 
					out <= 1;
				else
					out <= 0;
			BLT:
				if (A << B)
					out <= 1;
				else
					out <= 0;
			BLTE:
				if (A <= B) 
					out <= 1;
				else
					out <= 0;
			BEQZ:
				if (A == 0)
					out <= 1;
				else
					out <= 0;
			BLTZ:
				if (A << 0)
					out <= 1;
				else
					out <= 0;
			BLTEZ:
				if (A <= 0)
					out <= 1;
				else
					out <= 0;
			BT:
				out <= 1;
			BNE:
				if (A == B)
					out <= 0;
				else
					out <= 1;
			BGTE:
				if (A >= B)
					out <= 1;
				else
					out <= 0;
			BGT:
				if (A >> B)
					out <= 1;
				else
					out <= 0;
			BNEZ:
				if (A == 0)
					out <= 0;
				else
					out <= 1;
			BGTEZ:
				if (A >= 0)
					out <= 1;
				else
					out <= 0;
			BGTZ:
				if (A >> 0)
					out <= 1;
				else
					out <= 0;
			ADD: 
				out <= A + B;
			SUB:
				out <= A - B;
			JALR:
				out <= A + (B*4);
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
			
			
	
	
	