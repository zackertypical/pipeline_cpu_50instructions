`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:11:49 11/25/2018 
// Design Name: 
// Module Name:    STALL_SEL 
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
module STALL_SEL(
	input [31:0]IR,
	input Tuse_RS0,Tuse_RS1,Tuse_RT0,Tuse_RT1,Tuse_RT2,
	input [1:0]Tnew_E,Tnew_M,
	input [4:0]A3_E,A3_M,
	input busy,
	input start,
	//在E级和M级的写使能信号
	input W_E,W_M,
	output stall
    );
	 //解析指令的地方都要加入opcode和func
	wire [5:0]OpCode = 	IR[31:26];
	wire [5:0]func   = 	IR[5:0];
	 //RS  A1
	 
	 //读入的是mflo之类的指令
	 
	 wire Stall_xalu = (busy|start)	&	(`mult|`multu|`mfhi|`mflo|`mthi|`mtlo|`div|`divu|`madd);
	 
	 
	wire Stall_RS0_E = Tuse_RS0 & (Tnew_E > 0) & (`A1 == A3_E) & W_E & (A3_E != 0);
	wire Stall_RS0_M = Tuse_RS0 & (Tnew_M > 0) & (`A1 == A3_M) & W_M & (A3_M != 0);
	wire Stall_RS1_E = Tuse_RS1 & (Tnew_E > 1) & (`A1 == A3_E) & W_E & (A3_E != 0);
	wire Stall_RS = Stall_RS0_E | Stall_RS0_M |Stall_RS1_E;


	wire Stall_RT0_E = Tuse_RT0 & (Tnew_E > 0) & (`A2 == A3_E) & W_E & (A3_E != 0);
	wire Stall_RT1_E = Tuse_RT1 & (Tnew_E > 1) & (`A2 == A3_E) & W_E & (A3_E != 0);
	wire Stall_RT0_M = Tuse_RT0 & (Tnew_M > 0) & (`A2 == A3_M) & W_M & (A3_M != 0);
	wire Stall_RT = Stall_RT0_E|Stall_RT1_E|Stall_RT0_M;

	//assign stall = Stall_RS|Stall_RT;
	
	 assign stall = Stall_RS|Stall_RT|Stall_xalu;

endmodule
