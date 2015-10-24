module PC(clk, pc_in, imm, enable_branch, take_branch, pc_out);
	input clk, enable_branch, take_branch;
	input[31:0] pc_in;
	input[15:0] imm;
	output reg[31:0] pc_out;
	
	always @(clk posedge) begin
		if (enable_branch && take_branch)
			pc_out <= pc_in + 4 + (imm * 4);
		else
			pc_out <= pc_in + 4;
	end
	
endmodule;