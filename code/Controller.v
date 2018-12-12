`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:43:18 11/24/2018 
// Design Name: 
// Module Name:    Controller 
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
module Controller(
	input	[31:0]IR,
	output [1:0]NPC_OP,
	output [3:0]ALU_OP,
	output [2:0]CMP_OP,
	output EXT_OP,
	output IFU_OP,
	output [1:0]ALU_SRCA,
	output [2:0]ALU_SRCB,
	output ALU_OUT_SEL,
	output MEM_WR,
	output GRF_WD,
	//output [1:0]GRF_RW,
	output GRF_WE
    );

	wire [5:0]OpCode = 	IR[31:26];
	wire [5:0]func 	 = 	IR[5:0];
	wire Type_ALU = `R_addu|`R_subu|`R_or|`R_and|`R_xor|`R_nor|`sllv|`srlv|`srav|`slt|`sltu;
	wire Type_XALU = `mult|`multu|`mfhi|`mflo|`mthi|`mtlo|`div|`divu|`madd;
	wire Type_BR = `beq|`bne|`bgez|`bgtz|`blez|`bltz;
	wire Type_IMM = `ori|`lui|`addi|`andi|`xori|`slti|`sltiu;
	wire Type_LOAD = `lw|`lb|`lbu|`lh|`lhu;
	wire Type_SAVE = `sw|`sb|`sh;
	wire Type_SHIFT = `sll|`srl|`sra;
	wire Type_J = `R_jr|`R_jalr|`j|`jal;
	
	assign ALU_OUT_SEL = Type_XALU?`ALU_x:`ALU_n;
	
	assign ALU_OP= `R_subu?				`ALU_subu:
					(`ori|`R_or)?		`ALU_or:
					(`R_and|`andi)?		`ALU_and:
					`R_nor?				`ALU_nor:
					(`R_xor|`xori)?		`ALU_xor:
					`lui?				`ALU_sll16:
					(`R_jalr|`jal)?		`ALU_jal:
					(`sll|`sllv)?		`ALU_sll:
					(`srl|`srlv)?		`ALU_srl:	
					(`sra|`srav)?		`ALU_sra:
					(`slt|`slti)?		`ALU_slt:
					(`sltu|`sltiu)?		`ALU_sltu:
										`ALU_addu;//load save add 
						  
	assign NPC_OP = Type_BR?`NPC_br:
					 (`j|`jal)?			`NPC_j:
					 (`R_jalr|`R_jr)?	`NPC_jr:
										`NPC_add4;
						  
	 
	assign EXT_OP = Type_BR|Type_LOAD|Type_SAVE|`slti|`sltiu|`addi;
	assign IFU_OP = Type_BR|Type_J;
	 
	assign CMP_OP = `beq?	`CMP_beq:
					`bne?	`CMP_bne:
					`bgez?	`CMP_bgez:
					`bgtz?	`CMP_bgtz:
					`blez?	`CMP_blez:
					`bltz?	`CMP_bltz:
					3'd0;

	assign ALU_SRCB = 	(Type_IMM|Type_SAVE|Type_LOAD)?	`ALUB_imm:
						(`jal|`R_jalr)?			`ALUB_pc8:
						(Type_SHIFT)?		`ALUB_shift:
						(`sllv|`srlv|`srav)?	`ALUB_rs:
												`ALUB_rt;				

	
	assign ALU_SRCA = (Type_SHIFT|`sllv|`srav|`srlv)?	`ALUA_rt:`ALUA_rs;
	 
	 assign MEM_WR = Type_SAVE;
	 
	 assign GRF_WE = Type_ALU|Type_LOAD|Type_IMM|Type_SHIFT|`R_jalr|`jal|`mfhi|`mflo;
	
	 assign GRF_WD = Type_LOAD?`RegS_DM:`RegS_ALU;
	 

endmodule
