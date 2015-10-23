module Controller(clk, opcode, func, ctrl_alu_op, ctrl_reg_src, ctrl_br, ctrl_mem_read, ctrl_mem_write, ctrl_alu_src, ctrl_reg_write);
	parameter ALUR=0, ALUI=8, LW=9, SW=5, CMPR=2, CMPI=10, BRANCH=6, JAL=11;
	
	input clk;
	input[3:0] opcode, func;
	output reg[5:0] ctrl_alu_op;
	output ctrl_reg_src, ctrl_br, ctrl_mem_read, ctrl_mem_write, ctrl_alu_src, ctrl_reg_write;
	
	reg[6:0] ctrl_out;
	
	assign ctrl_reg_src = ctrl_out[5];
	assign ctrl_br = ctrl_out[4];
	assign ctrl_mem_read = ctrl_out[3];
	assign ctrl_mem_write = ctrl_out[2];
	assign ctrl_alu_src = ctrl_out[1];
	assign ctrl_reg_write = ctrl_out[0];
		
	always @(posedge clk) begin
		ctrl_alu_op <= func;
		case(opcode)
			ALUR:
				ctrl_out <= 7'b0001001;
			ALUI:
				ctrl_out <= 7'b0001011;
			LW:
				ctrl_out <= 7'b0011011;
			SW:
				ctrl_out <= 7'b1001110;
			CMPR:
				begin
					ctrl_out <= 7'b0000001;
					ctrl_alu_op <= (16 + func);
				end
			CMPI:
				begin
					ctrl_out <= 7'b0000011;
					ctrl_alu_op <= (16 + func);
				end
			BRANCH:
				begin
					ctrl_out <= 7'b1100000;
					ctrl_alu_op <= (16 + func);
				end
			JAL:
				begin
					ctrl_out <= 7'b0000011;
					ctrl_alu_op <= 32;
				end
		endcase
	end
endmodule