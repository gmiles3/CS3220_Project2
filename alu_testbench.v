// This is a testbench used for simulation
// This will help verify your design does what you think it does
// Basically, you make a module with no inputs or outputs
// You then declare inputs you will manually control with the reg keyword
// Outputs you want to read are declared as wires
// You than instantiate the unit you want to test
// Then you manually control the values of the inputs at a given time


// Before attempting simulation:
// 1. Under "Tools" -> "Options...". select the "EDA Tools Options" category.
//		and under Modelsim-Altera, enter the path to the modelsim altera directory
//		For me this is C:\altera\13.0sp1\modelsim_ase\win32aloem
// 2. Under "Assignments" -> "Settings", select the "EDA Tool Settings - Simulation" category.
//		a. Under "Tool Name" select Modelsim-Altera
//		b. Under "Format for output netlist", select "Verilog HDL"
//		c. Under "Native Link Settings", enable "Compile Testbench" and add a new testbench
//			with the verilog file containing the testbench and name
//			corresponding to the testbench module
//			(in this case xor_testbench.v and xor_testbench respectively)
// 3. Select "Tools" -> "Run Simulation Tool" -> "RTL Simulation" to start modelsim
//		a. Respond No when asked "Are you sure you want to finish?"
//		b. Press the blue magnifying glass to view your waveform in full


`timescale 1ns / 1ps
module alu_testbench;

	reg clk;
	reg[5:0] opsel;
	reg[31:0] A, B;
	reg signed[31:0] Expected;
	wire signed[31:0] out;
	parameter ADD=6'h00, SUB=6'h01, AND=6'h04, OR=6'h05, XOR=6'h06, NAND=6'h0C, NOR=6'h0D, XNOR=6'h0E, MVHI=6'h0B;
	parameter F=6'h10, EQ=6'h11, LT=6'h12, LTE=6'h13, EQZ=6'h15, LTZ=6'h16, LTEZ=6'h17, T=6'h18, NE=6'h19, GTE=6'h1A, GT=6'h1B, NEZ=6'h1D, GTEZ=6'h1E, GTZ=6'h1F;
	parameter H=10, NEG=-1, L=5, Z=0;

	// Instantiate the Unit Under Test
	ALU alu(clk, opsel, A, B, out);
	
	initial begin
		clk = 0;
		opsel = 0;
		A = Z;
		B = Z;
	end

	always
		#100 clk = !clk;
		
	initial begin
		#200;
		$monitor("%0t\tOpsel: %h\tA: %h\tB: %h\tOut: %h", $time, opsel, A, B, out);
		opsel=ADD;
		#200;
		A=L;
		#200;
		B=L;
		#200;
		A=NEG;
		#200;
		B=NEG;
		#200
		A=L;
		#200
		A = Z;
		B = Z;
		opsel=SUB;
		#200;
		A=L;
		#200;
		B=L;
		#200;
		A=NEG;
		#200;
		B=NEG;
		#200
		A=L;
		#200
		A = Z;
		B = Z;
		opsel=AND;
		#200;
		A=L;
		#200;
		B=L;
		#200;
		A=NEG;
		#200;
		B=NEG;
		#200
		A=L;
		#200
		A = Z;
		B = Z;
		opsel=OR;
		#200;
		A=L;
		#200;
		B=L;
		#200;
		A=NEG;
		#200;
		B=NEG;
		#200
		A=L;
		#200
		A = Z;
		B = Z;
		opsel=XOR;
		#200;
		A=L;
		#200;
		B=L;
		#200;
		A=NEG;
		#200;
		B=NEG;
		#200
		A=L;
		#200
		A = Z;
		B = Z;
		opsel=NAND;
		#200;
		A=L;
		#200;
		B=L;
		#200;
		A=NEG;
		#200;
		B=NEG;
		#200
		A=L;
		#200
		A = Z;
		B = Z;
		opsel=NOR;
		#200;
		A=L;
		#200;
		B=L;
		#200;
		A=NEG;
		#200;
		B=NEG;
		#200
		A=L;
		#200
		A = Z;
		B = Z;
		opsel=XNOR;
		#200;
		A=L;
		#200;
		B=L;
		#200;
		A=NEG;
		#200;
		B=NEG;
		#200
		A=L;
		#200
		A = Z;
		B = Z;
		opsel=MVHI;
		#200;
		A=L;
		#200;
		B=L;
		#200;
		A=NEG;
		#200;
		B=NEG;
		#200
		A=L;
		#200
		A = Z;
		B = Z;
		opsel=F;
		#200;
		A=L;
		#200;
		B=L;
		#200;
		A=NEG;
		#200;
		B=NEG;
		#200
		A=L;
		#200
		A = Z;
		B = Z;
		opsel=EQ;
		#200;
		A=L;
		#200;
		B=L;
		#200;
		A=NEG;
		#200;
		B=NEG;
		#200
		A=L;
		#200
		A = Z;
		B = Z;
		opsel=LT;
		#200;
		A=L;
		#200;
		B=L;
		#200;
		A=NEG;
		#200;
		B=NEG;
		#200
		A=L;
		#200
		A = Z;
		B = Z;
		opsel=LTE;
		#200;
		A=L;
		#200;
		B=L;
		#200;
		A=NEG;
		#200;
		B=NEG;
		#200
		A=L;
		#200
		
		#200 $finish;
	end
      
endmodule
