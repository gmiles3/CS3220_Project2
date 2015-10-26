module Controller(clk, pcCurrent,instWord,r1,r2,rd,immSign,alufunc,pcNext,isBranch,toReg,toMem,useImm,fromMem);
	
	parameter ALUR=4'h0, ALUI=4'h8, LW=4'h9, SW=4'h5, CMPR=4'h2, CMPI=4'hA, BRANCH=4'h6, JAL=4'hB;
	
	input clk;
	input[31:0] pcCurrent, instWord;
	output reg[31:0] pcNext, immSign;
	output reg[3:0] r1, r2, rd;
	output reg[5:0] alufunc;
	output reg isBranch,toReg,toMem,useImm,fromMem;
	
	wire[3:0] ra, rb, rc, func, op;
	wire[31:0] imm;
	
	assign ra = instWord[31:28];
	assign rb = instWord[27:24];
	assign rc = instWord[23:20];
	assign func = instWord[7:4];
	assign op = instWord[3:0];
	
	SignExtension #(.IN_BIT_WIDTH(16), .OUT_BIT_WIDTH(32)) imm_sinex(instWord[23:8], imm);
	
	always @(posedge clk) begin
		rd <= ra;
		r1 <= rb;
		r2 <= rc;
		immSign <= imm;
		alufunc <= {2'b00, func};
		pcNext <= pcCurrent + 4;
		
		isBranch <= 1'b0;
		toReg <= 1'b1;
		toMem <= 1'b0;
		useImm <= 1'b1;
		fromMem <= 1'b0;
		
		case (op)
			ALUR:
				useImm <= 1'b0;
			LW:
				fromMem <= 1'b1;
			SW:
				begin
					r1 <= ra;
					r2 <= rb;
					toReg <= 1'b0;
					toMem <= 1'b1;
				end
			CMPR:
				begin
					useImm <= 1'b0;
					alufunc <= {2'b01, func};
				end
			CMPI:
				alufunc <= {2'b01, func};
			BRANCH:
				begin
					r1 <= ra;
					r2 <= rb;
					alufunc <= {2'b01, func};
					isBranch <= 1'b1;
					toReg <= 1'b0;
				end
			JAL:
				alufunc <= {2'b10, func};
		endcase
	end
endmodule