`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:01:30 11/25/2018 
// Design Name: 
// Module Name:    MainCTR 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "head.v"
module MainCTR(
	input [31:0]D_IR,
	input clk,
	input reset,
	input E_BUSY,
	input E_START,
	//
	output [1:0]D_NPC_OP,
	output [3:0]E_ALU_OP,
	output [2:0]D_CMP_OP,
	output D_EXT_OP,
	output D_IFU_OP,
	output [1:0]E_ALU_SRCA,
	output [2:0]E_ALU_SRCB,
	output E_ALU_OUT_SEL,
	output M_MEM_WR,
	output M_GRF_WD,//********************
	//output [1:0]W_GRF_RW,
	output W_GRF_WE,
	output [4:0]W_A3,
	
	//mux forward
	output [1:0]D_SEL_MF_RS,
	output [1:0]D_SEL_MF_RT,
	output [1:0]E_SEL_MF_RS,
	output [1:0]E_SEL_MF_RT,
	//output [2:0]E_SEL_MF_RD,
	output M_SEL_MF_RT,
	//STALL
	output PC_en,
	output E_clr,
	output D_en
	
    );
	 wire [5:0]OpCode = D_IR[31:26];
	 wire [5:0]func = D_IR[5:0];
	 wire [31:0]	E_IR,M_IR,W_IR;
	 wire [4:0]		D_A1,E_A1,M_A1;
	 wire [4:0]		D_A2,E_A2,M_A2;
	 wire [4:0]		D_A3,E_A3,M_A3; 
	 wire 			E_GRF_WE,M_GRF_WE;
	 wire 			en,stall;
	 wire [1:0]		Tnew_D,Tnew_E,Tnew_M,Tnew_W;
	 wire Tuse_RS0,Tuse_RS1,Tuse_RT0,Tuse_RT1,Tuse_RT2;
	 assign D_A1 = D_IR[25:21];
	 assign D_A2 = D_IR[20:16];
	 //!!very important
	 assign D_A3 = (`jal)?5'd31:
				 (`ori|`lw|`lb|`lbu|`lh|`lhu|`lui|`addi|`andi|`xori|`slti|`sltiu)?D_IR[20:16]:
				 (`R_addu|`R_subu|`R_or|`R_and|`R_xor|`R_nor|`R_jalr|`sll|`sllv|`srl|`srlv|`srav|`sra|`slt|`sltu|`mfhi|`mflo)?D_IR[15:11]://写入rd[15:11]
				 0;
				 
	 assign en = 1;
	  
//A_TCODE
	A_TCode AT_code(
	D_IR,
	Tuse_RS0,Tuse_RS1,
	Tuse_RT0,Tuse_RT1,
	Tuse_RT2,
	Tnew_D
	//D_A3
    );
	 
	 
//Tnew REG
	T_REG E_TNEW(Tnew_D,Tnew_E,clk,(reset|E_clr),en);
	T_REG M_TNEW(Tnew_E,Tnew_M,clk,reset,en);
	T_REG W_TNEW(Tnew_M,Tnew_W,clk,reset,en);
//A1 REG
	 REG #(5)A1_E(D_A1,E_A1,clk,(reset|E_clr),en);
	 REG #(5)A1_M(E_A1,M_A1,clk,reset,en);
	 //REG #(5)A1_W(M_A1,W_A1,clk,reset,en);

//A2 REG
	 REG #(5)A2_E(D_A2,E_A2,clk,(reset|E_clr),en);
	 REG #(5)A2_M(E_A2,M_A2,clk,reset,en);
	 //REG #(5)A2_W(M_A2,W_A2,clk,reset,en);

//A3 REG
	 REG #(5)A3_E(D_A3,E_A3,clk,(reset|E_clr),en);
	 REG #(5)A3_M(E_A3,M_A3,clk,reset,en);
	 REG #(5)A3_W(M_A3,W_A3,clk,reset,en);
	 
//IR REG 
	 REG #(32)IR_E(D_IR,E_IR,clk,(reset|E_clr),en);
	 REG #(32)IR_M(E_IR,M_IR,clk,reset,en);
	 REG #(32)IR_W(M_IR,W_IR,clk,reset,en);

//MuxFORWARD SEL
	assign D_SEL_MF_RS = ((D_A1 == M_A3) & (Tnew_M==0) & M_GRF_WE & (D_A1!=0))?2:
								((D_A1 == W_A3) & (Tnew_W==0) & W_GRF_WE & (D_A1!=0))?1:
																						 0;
																						
	assign D_SEL_MF_RT = ((D_A2 == M_A3) & (Tnew_M==0) & M_GRF_WE & (D_A2!=0)) ? 2:
								((D_A2 == W_A3) & (Tnew_W==0) & W_GRF_WE & (D_A2!=0)) ? 1:
																						   0;
																							
	assign E_SEL_MF_RS = ((E_A1 == M_A3) & (Tnew_M==0) & M_GRF_WE & (E_A1!=0)) ? 2:
								((E_A1 == W_A3) & (Tnew_W==0) & W_GRF_WE & (E_A1!=0)) ? 1:
																							0;
	
	assign E_SEL_MF_RT = ((E_A2 == M_A3) & (Tnew_M==0) & M_GRF_WE & (E_A2!=0)) ? 2:
								((E_A2 == W_A3) & (Tnew_W==0) & W_GRF_WE & (E_A2!=0)) ? 1:
																							0;
																							
	assign M_SEL_MF_RT = ((M_A2 == W_A3) & (Tnew_W==0) & W_GRF_WE & (M_A2!=0)) ? 1:
																							0;	
																							

//CONTROLLER OF EVERY LEVEL
	Controller CTR_D(
	.IR(D_IR),
	.NPC_OP(D_NPC_OP),
	.CMP_OP(D_CMP_OP),
	.EXT_OP(D_EXT_OP),
	.IFU_OP(D_IFU_OP)
    );
	 
	Controller CTR_E(
	.IR(E_IR),
	.ALU_OP(E_ALU_OP),
	.ALU_SRCA(E_ALU_SRCA),
	.ALU_SRCB(E_ALU_SRCB),
	.ALU_OUT_SEL(E_ALU_OUT_SEL),
	.GRF_WE(E_GRF_WE)
    );
	 
	Controller CTR_M(
	.IR(M_IR),
	.MEM_WR(M_MEM_WR),
	.GRF_WE(M_GRF_WE),
	.GRF_WD(M_GRF_WD)
    );
	 
	Controller CTR_W(
	.IR(W_IR),
	//.GRF_RW(W_GRF_RW),
	.GRF_WE(W_GRF_WE)
    );

	 
	STALL_SEL stall_sel(
	D_IR,
	Tuse_RS0,Tuse_RS1,Tuse_RT0,Tuse_RT1,Tuse_RT2,
	Tnew_E,Tnew_M,
	E_A3,M_A3,
	E_BUSY,
	E_START,
	//
	E_GRF_WE,M_GRF_WE,
	stall
    ); 	

	STALLCTR stall_ctr(
	stall,
	PC_en,E_clr,D_en
    );	
	 	 
 

endmodule
