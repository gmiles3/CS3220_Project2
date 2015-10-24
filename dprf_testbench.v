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
module dprf_testbench;

	reg clk, reset, we;
	reg[3:0] regsel_dest, regsel_source0, regsel_source1;
	reg[31:0] datain;
	wire[31:0] dataout0, dataout1;
	

	// Instantiate the Unit Under Test
	DPRF dprf(clk, reset, we, regsel_dest, regsel_source0, regsel_source1, datain, dataout0, dataout1);
	
	initial begin
		clk = 0;
		reset = 0;
		we = 0;
		regsel_dest = 0;
		regsel_source0 = 0;
		regsel_source1 = 0;
		datain = 0;
	end

	always
		#5 clk = !clk;
		
	initial begin
		#100;
		$monitor("%0t\twe: %d\treg_dst: %d\treg_a: %d\treg_b: %d\tdata_in: %d\tout_a: %d\tout_b: %d", 
			$time, we, regsel_dest, regsel_source0, regsel_source1, datain, dataout0, dataout1);

		datain = 30;
		regsel_dest = 3;
		we = 1;
		#100;
		we = 0;
		#100;
		regsel_dest = 10;
		datain = 100;
		#100;
		regsel_source0 = 3;
		#100;
		regsel_source1 = 10;
		#100 
		$finish;
	end
      
endmodule