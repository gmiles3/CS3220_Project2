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
	reg[3:0] opsel;
	reg[31:0] A, B;
	wire signed[31:0] out;
	parameter ADD=0, SUB=1, AND=2, OR=3, XOR=4, NAND=5, NOR=6, XNOR=7, MVHI=8;
	

	// Instantiate the Unit Under Test
	ALU alu(clk, opsel, A, B, out);
	
	initial begin
		clk = 0;
		opsel = 0;
		A = 0;
		B = 0;
	end

	always
		#5 clk = !clk;
		
	initial begin
		#100;
		A = 20;
		#100;
		B = 17;
		#100;
		opsel = ADD;
		#100;
		$display("Add: 20 + 17 = 37 (%d)\n", out);
		#100;
		opsel = SUB;
		#100;
		$display("Sub: 20 - 17 = 3 (%d)\n", out);
		#100;
		opsel = OR;
		#100;
		$display("Or: 20 | 17 = 21 (%d)\n", out);
		#100;
		opsel = XOR;
		#100;
		$display("Xor: 20 ^ 17 = 5 (%d)\n", out);
		#100;
		opsel = NAND;
		#100;
		$display("Nand: ~(20 & 17) = -17 (%d)\n", out);
		#100;
		opsel = NOR;
		#100;
		$display("Nor: ~(20 | 17) = -22 (%d)\n", out);
		#100;
		opsel = XNOR;
		#100;
		$display("Xnor: ~(20 ^ 17) = -6 (%d)\n", out);
		#100;
		opsel = MVHI;
		#100;
		$display("MVHI: out[31:16] <-- b[15:0] = 1179642 (%d)\n", out);
		#100;	
	end
      
endmodule
