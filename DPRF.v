module DPRF(clk, reset, enWrite, selRegWrite, selRegRead1, selRegRead2, writeData, dataout1, dataout2);
	input clk, reset, enWrite;
	input[3:0] selRegWrite, selRegRead1, selRegRead2;
	input[31:0] writeData;
	output[31:0] dataout1, dataout2;
	
	wire[15:0] enWrites;
	wire[31:0] out[0:15];
	
	assign enWrites = enWrite << selRegWrite;
	assign dataout1 = out[selRegRead1];
	assign dataout2 = out[selRegRead2];

	Register reg0(clk, reset, enWrites[0], writeData, out[0]);
	Register reg1(clk, reset, enWrites[1], writeData, out[1]);
	Register reg2(clk, reset, enWrites[2], writeData, out[2]);
	Register reg3(clk, reset, enWrites[3], writeData, out[3]);
	Register reg4(clk, reset, enWrites[4], writeData, out[4]);
	Register reg5(clk, reset, enWrites[5], writeData, out[5]);
	Register reg6(clk, reset, enWrites[6], writeData, out[6]);
	Register reg7(clk, reset, enWrites[7], writeData, out[7]);
	Register reg8(clk, reset, enWrites[8], writeData, out[8]);
	Register reg9(clk, reset, enWrites[9], writeData, out[9]);
	Register reg10(clk, reset, enWrites[10], writeData, out[10]);
	Register reg11(clk, reset, enWrites[11], writeData, out[11]);
	Register reg12(clk, reset, enWrites[12], writeData, out[12]);
	Register reg13(clk, reset, enWrites[13], writeData, out[13]);
	Register reg14(clk, reset, enWrites[14], writeData, out[14]);
	Register reg15(clk, reset, enWrites[15], writeData, out[15]);
endmodule