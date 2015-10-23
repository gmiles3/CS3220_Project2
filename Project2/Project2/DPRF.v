module DPRF(clk, reset, we, regsel_dest, regsel_source0, regsel_source1, datain, dataout0, dataout1);
	input clk, reset, we;
	input[3:0] regsel_dest, regsel_source0, regsel_source1;
	input[31:0] datain;
	output[31:0] dataout0;
	output[31:0] dataout1;
	
	wire[15:0] we_wire;
	wire[31:0] out[0:15];
	
	assign we_wire = we << regsel_dest;
	assign dataout0 = out[regsel_source0];
	assign dataout1 = out[regsel_source1];

	Register reg0(clk, reset, we_wire[0], datain, out[0]);
	Register reg1(clk, reset, we_wire[1], datain, out[1]);
	Register reg2(clk, reset, we_wire[2], datain, out[2]);
	Register reg3(clk, reset, we_wire[3], datain, out[3]);
	Register reg4(clk, reset, we_wire[4], datain, out[4]);
	Register reg5(clk, reset, we_wire[5], datain, out[5]);
	Register reg6(clk, reset, we_wire[6], datain, out[6]);
	Register reg7(clk, reset, we_wire[7], datain, out[7]);
	Register reg8(clk, reset, we_wire[8], datain, out[8]);
	Register reg9(clk, reset, we_wire[9], datain, out[9]);
	Register reg10(clk, reset, we_wire[10], datain, out[10]);
	Register reg11(clk, reset, we_wire[11], datain, out[11]);
	Register reg12(clk, reset, we_wire[12], datain, out[12]);
	Register reg13(clk, reset, we_wire[13], datain, out[13]);
	Register reg14(clk, reset, we_wire[14], datain, out[14]);
	Register reg15(clk, reset, we_wire[15], datain, out[15]);
endmodule