`timescale 1ns / 1ps
module controller_testbench;
	reg clk;
	reg [31:0] pcOut, instWord; 
	wire [31: 0] selRegRead1, selRegRead2, selRegWrite, imm, pcNext;
	wire enBranch, enRegWrite, enMemWrite, aluSrcIsReg, memToReg;

	Controller controller(clk, pcOut, instWord, 
		selRegRead1, selRegRead2, selRegWrite, imm, selALUop, pcNext, 
		enBranch, enRegWrite, enMemWrite, aluSrcIsReg, memToReg);
	
	initial begin
		clk = 0;
		pcOut = 32'h40;
		instWord = 32'hC0F000B8;
	end

	always
		#5 clk = !clk;
		
	initial begin
		#100;
		$monitor("%0t\tpcOut: %d\tinstWord: %d\tselRegRead1: %d\tselRegRead2: %d\tselRegWrite: %d\timm: %d\tpcNext: %d\tenBranch: %d\tenRegWrite: %d\tenMemWrite: %d\taluSrcIsReg: %d\tmemToReg: %d",
			$time, pcOut, instWord, selRegRead1, selRegRead2, selRegWrite, imm, selALUop, pcNext, enBranch, enRegWrite, enMemWrite, aluSrcIsReg, memToReg);
		#100;
		instWord = 0;
		#100;
		instWord = 8;
		#100;
		instWord = 9;
		#100;
		instWord = 5;
		#100;
		instWord = 2;
		#100;
		instWord = 10;
		#100;
		instWord = 6;
		#100;
		instWord = 11;
		#100 $finish;
	end

endmodule