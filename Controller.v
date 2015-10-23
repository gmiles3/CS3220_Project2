module Controller(clk, instWord, opcode, func, rs2, rs1, rd, ctrl_br, ctrl_mem_read, ctrl_mem_reg, ctrl_alu_op, ctrl_mem_write, ctrl_alu_src, ctrl_reg_write);
	parameter ALUR=0, ALUI=8, LW=9, SW=5, CMPR=2, CMPI=10, BRANCH=6, JAL=11
	
	input clk;
	input[31:0] instWord;
	output reg[15:0] imm;
	output reg[3:0] opcode, func, rs2, rs1, rd;
	output reg ctrl_br, ctrl_mem_read, ctrl_mem_reg, ctrl_alu_op, ctrl_mem_write, ctrl_alu_src, ctrl_reg_write;
	
	wire[3:0] a, b, c;
	wire[6:0] ctrl_out;
	
	assign a = instWord[31:28];
	assign b = instWord[27:24];
	assign c = instWord[23:19];
	assign func = instWord[7:4];
	assign opcode = instWord[3:0];
	assign imm = instWord[23:8];
	
	assign ctrl_br = ctrl_out[6];
	assign ctrl_mem_read = ctrl_out[5];
	assign ctrl_mem_reg = ctrl_out[4];
	assign ctrl_alu_op = ctrl_out[3];
	assign ctrl_mem_write = ctrl_out[2];
	assign ctrl_alu_src = ctrl_out[1];
	assign ctrl_reg_write = ctrl_out[0];
	
	always @(posedge clk) begin
	end
endmodule