module Project2(SW,KEY,LEDR,LEDG,HEX0,HEX1,HEX2,HEX3,CLOCK_50);
  input  [9:0] SW;
  input  [3:0] KEY;
  input  CLOCK_50;
  output [9:0] LEDR;
  output [7:0] LEDG;
  output [6:0] HEX0,HEX1,HEX2,HEX3;
 
  parameter DBITS         				 = 32;
  parameter INST_SIZE      			 = 32'd4;
  parameter INST_BIT_WIDTH				 = 32;
  parameter START_PC       			 = 32'h40;
  parameter REG_INDEX_BIT_WIDTH 		 = 4;
  parameter ADDR_KEY  					 = 32'hF0000010;
  parameter ADDR_SW   					 = 32'hF0000014;
  parameter ADDR_HEX  					 = 32'hF0000000;
  parameter ADDR_LEDR 					 = 32'hF0000004;
  parameter ADDR_LEDG 					 = 32'hF0000008;
  
  parameter IMEM_INIT_FILE				 = "LightTest.mif";
  parameter IMEM_ADDR_BIT_WIDTH 		 = 11;
  parameter IMEM_DATA_BIT_WIDTH 		 = INST_BIT_WIDTH;
  parameter IMEM_PC_BITS_HI     		 = IMEM_ADDR_BIT_WIDTH + 2;
  parameter IMEM_PC_BITS_LO     		 = 2;
  
  parameter DMEMADDRBITS 				 = 13;
  parameter DMEMWORDBITS				 = 2;
  parameter DMEMWORDS					 = 2048;
  
  // Add parameters for various secondary opcode values
  
  //PLL, clock genration, and reset generation
  wire clk, lock;
  //Pll pll(.inclk0(CLOCK_50), .c0(clk), .locked(lock));
  PLL	PLL_inst (.inclk0 (CLOCK_50),.c0 (clk),.locked (lock));
  wire reset = ~lock;
  
  // Create PC and its logic
  wire pcWrtEn = 1'b1;
  reg[DBITS - 1: 0] pcIn; // Implement the logic that generates pcIn; you may change pcIn to reg if necessary
  wire[DBITS - 1: 0] pcOut;
  
  // This PC instantiation is your starting point
  Register #(.BIT_WIDTH(DBITS), .RESET_VALUE(START_PC)) pc (clk, reset, pcWrtEn, pcIn, pcOut);

  // Creat instruction memeory
  wire[IMEM_DATA_BIT_WIDTH - 1: 0] instWord;
  InstMemory #(IMEM_INIT_FILE, IMEM_ADDR_BIT_WIDTH, IMEM_DATA_BIT_WIDTH) instMem (pcOut[IMEM_PC_BITS_HI - 1: IMEM_PC_BITS_LO], instWord);
	  
	wire[3:0] func, opcode, rd, rs1, rs2, key;
	wire[7:0] ledg;
	wire[9:0] sw, ledr;
	wire[15:0] imm, hex;
	wire[5:0] ctrl_alu_op;
	wire ctrl_reg_src, ctrl_br, ctrl_mem_read, ctrl_mem_write, ctrl_alu_src, ctrl_reg_write;
	
	wire[31:0] reg_write_data, reg_read_data1, reg_read_data2, alu_source, alu_result, mem_read_data;
	
	assign func = instWord[7:4];
	assign opcode = instWord[3:0];
	assign rd = (opcode == 4'd11) ? (pcOut + INST_SIZE) : instWord[31:28];
	assign rs1 = ctrl_reg_src ? instWord[31:28] : instWord[27:24];
	assign rs2 = ctrl_reg_src ? instWord[27:24] : instWord[23:19];
	assign imm = ((instWord[23] ? -1 : 0) << 16) + instWord[23:8];
	assign reg_write_data = (ctrl_mem_read) ? mem_read_data : alu_result;
	assign alu_source = ctrl_alu_src ? imm : reg_read_data2;
	
	always @(posedge clk) begin
		if (opcode == 4'd11)
			pcIn <= reg_read_data1 + (imm * 4);
		else if (ctrl_br && alu_result)
			pcIn <= pcOut + INST_SIZE + (imm * 4);
		else
			pcIn <= pcOut + INST_SIZE;
	end
	
	SevenSeg hex0(hex[3:0], HEX0);
	SevenSeg hex1(hex[7:4], HEX1);
	SevenSeg hex2(hex[11:8], HEX2);
	SevenSeg hex3(hex[15:12], HEX3);
	
  // Put the code for getting opcode1, rd, rs, rt, imm, etc. here
  Controller controller(clk, opcode, func, ctrl_alu_op, ctrl_reg_src, ctrl_br, ctrl_mem_read, ctrl_mem_write, ctrl_alu_src, ctrl_reg_write);
  
  // Create the registers
  DPRF dprf(clk, reset, ctrl_reg_write, rd, rs1, rs2, reg_write_data, reg_read_data1, reg_read_data2);
  
  // Create ALU unit
  ALU alu(clk, ctrl_alu_op, reg_read_data1, alu_source, alu_result);
  
  // Put the code for data memory and I/O here
  // KEYS, SWITCHES, HEXS, and LEDS are memeory mapped IO
  DataMemory #(IMEM_INIT_FILE) datamem(clk, ctrl_mem_write, alu_result, reg_read_data2, SW, KEY, LEDR, LEDG, hex, mem_read_data);
endmodule

