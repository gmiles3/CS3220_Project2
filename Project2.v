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
  
  parameter IMEM_INIT_FILE				 = "Sorter2.mif";
  parameter IMEM_ADDR_BIT_WIDTH 		 = 11;
  parameter IMEM_DATA_BIT_WIDTH 		 = INST_BIT_WIDTH;
  parameter IMEM_PC_BITS_HI     		 = IMEM_ADDR_BIT_WIDTH + 2;
  parameter IMEM_PC_BITS_LO     		 = 2;
  
  parameter DMEMADDRBITS 				 = 13;
  parameter DMEMWORDBITS				 = 2;
  parameter DMEMWORDS					 = 2048;
  
  parameter OP1_ALUR 					 = 4'b0000;
  parameter OP1_ALUI 					 = 4'b1000;
  parameter OP1_CMPR 					 = 4'b0010;
  parameter OP1_CMPI 					 = 4'b1010;
  parameter OP1_BCOND					 = 4'b0110;
  parameter OP1_SW   					 = 4'b0101;
  parameter OP1_LW   					 = 4'b1001;
  parameter OP1_JAL  					 = 4'b1011;
  
  // Add parameters for various secondary opcode values
  
  //PLL, clock genration, and reset generation
  wire clk, lock;
  //Pll pll(.inclk0(CLOCK_50), .c0(clk), .locked(lock));
  PLL	PLL_inst (.inclk0 (CLOCK_50),.c0 (clk),.locked (lock));
  wire reset = ~lock;
  
  // Create PC and its logic
  wire pcWrtEn = 1'b1;
  wire[DBITS - 1: 0] pcIn; // Implement the logic that generates pcIn; you may change pcIn to reg if necessary
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
	wire ctrl_br, ctrl_mem_read, ctrl_mem_reg, ctrl_alu_op, ctrl_mem_write, ctrl_alu_src, ctrl_reg_write;
	
	wire[31:0] reg_write_data, reg_read_data1, reg_read_data2, alu_result, mem_read_data;
	
	assign func = instWord[7:4];
	assign opcode = instWord[3:0];
	assign rd = (opcode == 11) ? (pcOut + 4) : instWord[31:28];
	assign rs1 = ctrl_reg_src ? instWord[31:28] : instWord[27:24];
	assign rs2 = ctrl_reg_src ? instWord[27:24] : instWord[23:19];
	assign imm = ((instWord[23] ? -1 : 0) << 16) + instWord[23:8];
	
	assign pcIn = (opcode == 11) ? (reg_read_data1 + (4 * imm)) : (pcOut + 4 + ((ctrl_br && alu_result) ? (imm * 4) : 0));
	
  // Put the code for getting opcode1, rd, rs, rt, imm, etc. here
  Controller controller(clk, opcode, func, ctrl_alu_op, ctrl_reg_src, ctrl_br, ctrl_mem_read, ctrl_mem_write, ctrl_alu_src, ctrl_reg_write);
  
  // Create the registers
  DPRF dprf(clk, reset, ctrl_reg_write, rd, rs1, rs2, reg_write_data, reg_read_data1, reg_read_data2);
  
  // Create ALU unit
  // alu_source = (ctrl_alu_src) ? (sign extended imm) : reg_read_data2;
  ALU alu(clk, func, reg_read_data1, reg_read_data2, alu_result);
  
  // Put the code for data memory and I/O here
  // KEYS, SWITCHES, HEXS, and LEDS are memeory mapped IO
  DataMemory #(IMEM_INIT_FILE) datamem(clk, ctrl_mem_write, alu_result, reg_read_data2, sw, key, ledr, ledg, hex, mem_read_data);
endmodule

