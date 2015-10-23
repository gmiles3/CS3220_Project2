module Project2(SW,KEY,LEDR,LEDG,HEX0,HEX1,HEX2,HEX3,CLOCK_50);
  input  [9:0] SW;
  input  [3:0] KEY;
  input  CLOCK_50;
  output [9:0] LEDR;
  output [7:0] LEDG;
  output [6:0] HEX0,HEX1,HEX2,HEX3;
 
  parameter DBITS    =32;
  parameter INSTSIZE =32'd4;
  parameter INSTBITS =32;
  parameter STARTPC  =32'h40;
  parameter REGNOBITS=4;
  parameter ADDRKEY  =32'hF0000010;
  parameter ADDRSW   =32'hF0000014;
  parameter ADDRHEX  =32'hF0000000;
  parameter ADDRLEDR =32'hF0000004;
  parameter ADDRLEDG =32'hF0000008;
  parameter IMEMINITFILE="Sorter2.mif";
  parameter IMEMADDRBITS=13;
  parameter IMEMWORDBITS=2;
  parameter IMEMWORDS=2048;
  parameter DMEMADDRBITS=13;
  parameter DMEMWORDBITS=2;
  parameter DMEMWORDS=2048;
  
  parameter OP1_ALUR =4'b0000;
  parameter OP1_ALUI =4'b1000;
  parameter OP1_CMPR =4'b0010;
  parameter OP1_CMPI =4'b1010;
  parameter OP1_BCOND=4'b0110;
  parameter OP1_SW   =4'b0101;
  parameter OP1_LW   =4'b1001;
  parameter OP1_JAL  =4'b1011;
  
  // Add parameters for various secondary opcode values
  
  wire clk,lock;
  Pll pll(.inclk0(CLOCK_50),.c0 (clk),.locked(lock));
  wire reset=!lock;
  
  // Create the processor's bus
  tri [(DBITS-1):0] thebus;
  parameter BUSZ={DBITS{1'bZ}};  
  // Create PC and connect it to the bus
  reg [(DBITS-1):0] PC;
  reg LdPC, DrPC, IncPC;
  always @(posedge clk) begin
    if(reset)
	   PC<=STARTPC;
	 else if(LdPC)
      PC<=thebus;
    else if(IncPC)
      PC<=PC+INSTSIZE;
  end
  assign thebus=DrPC?PC:BUSZ;
  // Create the instruction memory
  (* ram_init_file = IMEMINITFILE *)
  reg [(DBITS-1):0] imem[(IMEMWORDS-1):0];
  wire [(DBITS-1):0] iMemOut=imem[PC[(IMEMADDRBITS-1):IMEMWORDBITS]];

  // Create the IR (feeds directly from memory, not from bus)
  reg [(INSTBITS-1):0] IR;
  reg LdIR;
  always @(posedge clk or posedge reset)
    if(reset)
	   IR<=32'b0;
	 else if(LdIR)
      IR <= iMemOut;
  // Put the code for getting opcode1, rd, rs, rt, imm, etc. here 
  
  // Put the code for data memory and I/O here
    
  // Create the registers and connect them to the bus
  reg [(DBITS-1):0] regs[31:0];
  reg [(REGNOBITS-1):0] regno;
  reg WrReg,DrReg;
  always @(posedge clk)
    if(WrReg&&lock)
      regs[regno]<=thebus;
  wire [(DBITS-1):0] regout=WrReg?{DBITS{1'bX}}:regs[regno];
  assign thebus=DrReg?regout:BUSZ;
  
  // Create ALU unit and connect to the bus
  reg signed [(DBITS-1):0] A,B;
  reg LdA,LdB,DrALU;
  // Connect A and B registers to the bus
  always @(posedge clk or posedge reset)
    if(reset)
	   {A,B}<=32'hDEADDEAD;
	 else begin
      if(LdA)
        A <= thebus;
      if(LdB)
        B <= thebus;
    end
  // Put the code for the actual ALU here
  
  parameter S_BITS=5;
  parameter [(S_BITS-1):0]
    S_ZERO  ={(S_BITS){1'b0}},
    S_ONE   ={{(S_BITS-1){1'b0}},1'b1},
    S_FETCH1=S_ZERO,				// 00
    S_FETCH2=S_FETCH1+S_ONE,  // 01
    S_ALUR1 =S_FETCH2+S_ONE,	// 02
    S_ALUR2 =S_ALUR1 +S_ONE,	// 03
    S_ALUI1 =S_ALUR2 +S_ONE,	// 04
    S_ALUI2 =S_ALUI1 +S_ONE,	// 05
    S_CMPR1 =S_ALUI2 +S_ONE,	// 06
    S_CMPR2 =S_CMPR1 +S_ONE,	// 07
    S_CMPI1 =S_CMPR2 +S_ONE,	// 08
    S_CMPI2 =S_CMPI1 +S_ONE,	// 09
	 S_BCOND1=S_CMPI2 +S_ONE,  // 0A
	 S_BCOND2=S_BCOND1+S_ONE,  // 0B
	 S_BCOND3=S_BCOND2+S_ONE,  // 0C
	 S_BCOND4=S_BCOND3+S_ONE,  // 0D
    S_LW1   =S_BCOND4+S_ONE,	//	0E
    S_LW2   =S_LW1   +S_ONE,	//	0F
    S_LW3   =S_LW2   +S_ONE,	//	10
    S_SW1   =S_LW3   +S_ONE,	//	11
    S_SW2   =S_SW1   +S_ONE,	//	12
    S_SW3   =S_SW2   +S_ONE,	//	13
    S_JAL1  =S_SW3   +S_ONE,	//	14
    S_JAL2  =S_JAL1  +S_ONE,	//	15
    S_JAL3  =S_JAL2  +S_ONE,	//	16
    S_ERROR =S_JAL3  +S_ONE;	//	17
	 
  reg [(S_BITS-1):0] state,next_state;
  always @(state or opcode1 or rd or rs or rt or op2_i or op2_d or op2_t or ALUout[0]) begin
    // ALUfunc=OP2_ADD;
    {LdPC,DrPC,IncPC,LdMAR,WrMem,DrMem,LdIR,DrOff,ShOff, LdA, LdB,ALUfunc,DrALU,regno,DrReg,WrReg,next_state}=
    {1'b0,1'b0, 1'b0, 1'b0, 1'b0, 1'b0,1'b0, 1'b0, 1'b0,1'b0,1'b0,   5'bX,1'b0,  4'b0, 1'b0, 1'b0,state+S_ONE};
    case(state)
    S_FETCH1: {LdIR,IncPC}={1'b1,1'b1};
    S_FETCH2: begin
	             case(opcode1)
					 OP1_ALUR: begin
					   case(op2_i)
					   OP2_ALU_ADD,OP2_ALU_SUB,
						OP2_ALU_AND,OP2_ALU_OR,OP2_ALU_XOR,
						OP2_ALU_NAND,OP2_ALU_NOR,OP2_ALU_NXOR:
						         next_state=S_ALUR1;
						default: next_state=S_ERROR;
						endcase
					 end
					 OP1_ALUI: begin
					   case(op2_t)
					   OP2_ALU_ADD,OP2_ALU_SUB,
						OP2_ALU_AND,OP2_ALU_OR,OP2_ALU_XOR,
						OP2_ALU_NAND,OP2_ALU_NOR,OP2_ALU_NXOR,
						OP2_ALU_MVHI:
						         next_state=S_ALUI1;
						default: next_state=S_ERROR;
						endcase
					 end
					 OP1_CMPR: begin
					   case(op2_i)
						OP2_CMP_F,OP2_CMP_EQ,OP2_CMP_LT,OP2_CMP_LTE,
						OP2_CMP_EQZ,OP2_CMP_LTZ,OP2_CMP_LTEZ,
						OP2_CMP_T,OP2_CMP_NE,OP2_CMP_GTE,OP2_CMP_GT,
						OP2_CMP_NEZ,OP2_CMP_GTEZ,OP2_CMP_GTZ:
						         next_state=S_CMPR1;
						default: next_state=S_ERROR;
						endcase
					 end
					 OP1_CMPI: begin
					   case(op2_t)
						OP2_CMP_F,OP2_CMP_EQ,OP2_CMP_LT,OP2_CMP_LTE,
						OP2_CMP_EQZ,OP2_CMP_LTZ,OP2_CMP_LTEZ,
						OP2_CMP_T,OP2_CMP_NE,OP2_CMP_GTE,OP2_CMP_GT,
						OP2_CMP_NEZ,OP2_CMP_GTEZ,OP2_CMP_GTZ:
						         next_state=S_CMPI1;
						default: next_state=S_ERROR;
						endcase
					 end
					 OP1_BCOND: begin
					   case(op2_d)
						OP2_CMP_F,OP2_CMP_EQ,OP2_CMP_LT,OP2_CMP_LTE,
						OP2_CMP_EQZ,OP2_CMP_LTZ,OP2_CMP_LTEZ,
						OP2_CMP_T,OP2_CMP_NE,OP2_CMP_GTE,OP2_CMP_GT,
						OP2_CMP_NEZ,OP2_CMP_GTEZ,OP2_CMP_GTZ:
						         next_state=S_BCOND1;
						default: next_state=S_ERROR;
						endcase
					 end
					 OP1_LW: begin
						case(op2_t)
						4'b0000: next_state=S_LW1;
						default: next_state=S_ERROR;
						endcase
					 end
					 OP1_SW: begin
						case(op2_d)
						4'b0000: next_state=S_SW1;
						default: next_state=S_ERROR;
						endcase
					 end
					 OP1_JAL: begin
						case(op2_t)
						4'b0000: next_state=S_JAL1;
						default: next_state=S_ERROR;
						endcase
					 end
					 default:  next_state=S_ERROR;
                endcase
                {regno,DrReg,LdA,LdB}={rs,1'b1,1'b1,1'b1};
              end
    S_ALUR1:  {regno,DrReg,LdB}={rt,1'b1,1'b1};
    S_ALUR2:  {ALUfunc,DrALU,regno,WrReg,next_state}={1'b0,op2_i,1'b1,rd,1'b1,S_FETCH1};
	 
	 // Put the rest of the microcode here
    default:  next_state=S_ERROR;
    endcase
  end
  always @(posedge clk or posedge reset)
	if(reset)
	  state<=S_FETCH1;
	else
	  state<=next_state;
endmodule

// Sign extender
module SXT(IN,OUT);
  parameter IBITS;
  parameter OBITS;
  input  [(IBITS-1):0] IN;
  output [(OBITS-1):0] OUT;
  assign OUT={{(OBITS-IBITS){IN[IBITS-1]}},IN};
endmodule
