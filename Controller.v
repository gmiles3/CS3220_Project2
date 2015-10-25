module Controller(
	clk, 
	pcCurrent,
	instWord,
	
	selRegRead1,
	selRegRead2,
	selRegWrite,
	immSign,
	selALUop,
	pcNext,
	
	enableBranch,
	enableRegWrite,
	enableMemWrite,
	aluSrcIsReg,
	memToReg);
	
	parameter ALUR=4'h0, ALUI=4'h8, LW=4'h9, SW=4'h5, CMPR=4'h2, CMPI=4'hA, BRANCH=4'h6, JAL=4'hB;
	
	input clk;
	input[31:0] pcCurrent, instWord;
	output reg[31:0] selRegRead1, selRegRead2, selRegWrite, pcNext;
	output reg[15:0] immSign;
	output reg[5:0] selALUop;
	output reg enableBranch, enableRegWrite, enableMemWrite, aluSrcIsReg, memToReg;
	
	wire[3:0] ra, rb, rc, func, op;
	wire[15:0] imm;
	
	assign ra = instWord[31:28];
	assign rb = instWord[27:24];
	assign rc = instWord[23:19];
	assign func = instWord[7:4];
	assign op = instWord[3:0];
	
	SignExtension #(.IN_BIT_WIDTH(16), .OUT_BIT_WIDTH(32)) imm_sinex(instWord[23:8], imm);
	
	always @(posedge clk) begin
		selRegWrite <= ra;
		selRegRead1 <= rb;
		selRegRead2 <= rc;
		immSign <= imm;
		selALUop <= {2'b00, func};
		pcNext <= pcCurrent + 4;
		
		enableBranch <= 1'b0;
		enableRegWrite <= 1'b1;
		enableMemWrite <= 1'b0;
		aluSrcIsReg <= 1'b0;
		memToReg <= 1'b0;
		
		case (op)
			ALUR:
				aluSrcIsReg <= 1'b1;
			LW:
				memToReg <= 1'b1;
			SW:
				begin
					selRegRead1 <= ra;
					selRegRead2 <= rb;
					enableRegWrite <= 1'b0;
					enableMemWrite <= 1'b1;
				end
			CMPR:
				begin
					aluSrcIsReg <= 1'b1;
					selALUop <= {2'b01, func};
				end
			CMPI:
				selALUop <= {2'b01, func};
			BRANCH:
				begin
					selRegRead1 <= ra;
					selRegRead2 <= rb;
					selALUop <= {2'b01, func};
					enableBranch <= 1'b1;
					enableRegWrite <= 1'b0;
				end
			JAL:
				selALUop <= {2'b10, func};
		endcase
	end
endmodule