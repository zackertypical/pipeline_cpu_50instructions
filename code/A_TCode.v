`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:37:58 11/25/2018 
// Design Name: 
// Module Name:    A_TCode 
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

module A_TCode(
	input [31:0]IR,
	output Tuse_RS0,Tuse_RS1,
	output Tuse_RT0,Tuse_RT1,
	output Tuse_RT2,
	output [1:0]Tnew_D
    );
	 
	wire [5:0]OpCode = 	IR[31:26];
	wire [5:0]func   = 	IR[5:0];
	wire Type_ALU = `R_addu|`R_subu|`R_or|`R_and|`R_xor|`R_nor|`sllv|`srlv|`srav|`slt|`sltu;
	wire Type_XALU = `mult|`multu|`mfhi|`mflo|`mthi|`mtlo|`div|`divu|`madd;
	wire Type_BR = `beq|`bne|`bgez|`bgtz|`blez|`bltz;
	wire Type_IMM = `ori|`lui|`addi|`andi|`xori|`slti|`sltiu;
	wire Type_LOAD = `lw|`lb|`lbu|`lh|`lhu;
	wire Type_SAVE = `sw|`sb|`sh;
	wire Type_SHIFT = `sll|`srl|`sra;
	wire Type_J = `R_jr|`R_jalr|`j|`jal;
	
	assign Tuse_RS0 = Type_BR| `R_jr |`R_jalr;
	assign Tuse_RS1 = Type_ALU|Type_LOAD|Type_SAVE|
	`ori|`addi|`andi|`xori|`slti|`sltiu|
	`mthi|`mtlo|`mult|`multu|`div|`divu|`madd;
	 //³ýÁËlui£¬mfhi£¬mflo£¬j_type,br_type
	 
	assign Tuse_RT0 = `beq|`bne;
	assign Tuse_RT1 = Type_ALU|Type_SHIFT|`mult|`multu|`div|`divu|`madd;
	assign Tuse_RT2 = Type_SAVE;
	 
	//
	assign Tnew_D = Type_LOAD?`T_DM:
						(Type_ALU|Type_IMM|Type_SHIFT|`mfhi|`mflo)?`T_ALU:
						 `T_PC;
endmodule

