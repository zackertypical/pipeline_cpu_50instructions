`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:26:45 11/24/2018 
// Design Name: 
// Module Name:    head 
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
//ALU
`define ALU_addu 	4'd0
`define ALU_subu 	4'd1
`define ALU_and 	4'd2
`define ALU_or 	4'd3
`define ALU_sll16 4'd4
`define ALU_jal 	4'd5
`define ALU_xor 	4'd6
`define ALU_nor 	4'd7
`define ALU_sll 	4'd8
`define ALU_srl 	4'd9
`define ALU_sra 	4'd10
`define ALU_slt 	4'd11
`define ALU_sltu 	4'd12

`define ALU_n		1'b0
`define ALU_x		1'b1

//ALU SOURCEA
`define ALUA_rs   	2'd0
`define ALUA_rt   	2'd1

//ALU SOURCEB
`define ALUB_rt 	3'd0
`define ALUB_imm 	3'd1
`define ALUB_pc8 	3'd2

//SLL from IR[10:6]
`define ALUB_shift  3'd3
`define ALUB_rs 	3'd4

//IFU
`define NPC_add4 	2'b00
`define NPC_br 	    2'b01
`define NPC_j 		2'b10
`define NPC_jr 	    2'b11

//`define RD_RD	  	2'b00
//`define RD_RT	  	2'b01
//`define RD_31 		2'b10

`define RegS_ALU    0
`define RegS_DM  	1


//EXT
`define EXT_sign	1
`define EXT_unsign 	0


//TNEW

`define T_DM 	2'd3
`define T_ALU 	2'd2
`define T_PC 	2'd0


//CMP
`define CMP_beq     3'd1
`define CMP_bne     3'd2
`define CMP_blez    3'd3
`define CMP_bgtz    3'd4
`define CMP_bltz    3'd5
`define CMP_bgez    3'd6


//A1,A2,A3
`define A1 IR[25:21]
`define A2 IR[20:16]
`define A3 IR[15:11]


//Type_ALU
`define R_addu	(OpCode == 6'b000000 && (func == 6'b100001 || func == 6'b100000))
`define R_subu	(OpCode == 6'b000000 && (func == 6'b100011 || func == 6'b100010))
//new
`define R_and   (OpCode == 6'b000000 && func == 6'b100100)
`define R_or    (OpCode == 6'b000000 && func == 6'b100101)
`define R_nor   (OpCode == 6'b000000 && func == 6'b100111)
`define R_xor   (OpCode == 6'b000000 && func == 6'b100110)
`define slt 	(OpCode == 6'b000000 && func == 6'b101010)
`define sltu 	(OpCode == 6'b000000 && func == 6'b101011)
//shift
`define srlv 	(OpCode == 6'b000000 && func == 6'b000110)
`define srav 	(OpCode == 6'b000000 && func == 6'b000111)
`define sllv	(OpCode == 6'b000000 && func == 6'b000100)


//Type_IMM
`define ori		(OpCode == 6'b001101)
`define lui		(OpCode == 6'b001111)
//new
`define addi    (OpCode == 6'b001000 || OpCode == 6'b001001)
`define andi    (OpCode == 6'b001100)
`define xori    (OpCode == 6'b001110)
`define slti 	(OpCode == 6'b001010)
`define sltiu 	(OpCode == 6'b001011)

//Type_LOAD
`define lw		(OpCode == 6'b100011)
`define lb		(OpCode == 6'b100000)
`define lbu		(OpCode == 6'b100100)
`define lh		(OpCode == 6'b100001)
`define lhu		(OpCode == 6'b100101)

//Type_SAVE
`define sw		(OpCode == 6'b101011)
`define sb		(OpCode == 6'b101000)
`define sh		(OpCode == 6'b101001)

//Type_BR
`define beq		(OpCode == 6'b000100)
`define bne		(OpCode == 6'b000101)
`define bgez	(OpCode == 6'b000001 && IR[20:16] == 5'b00001)
`define bgtz	(OpCode == 6'b000111)
`define blez	(OpCode == 6'b000110)
`define bltz	(OpCode == 6'b000001 && IR[20:16] == 5'b00000)



//Type_J
`define j		(OpCode == 6'b000010)
`define jal		(OpCode == 6'b000011)
`define R_jr 	(OpCode == 6'b000000 && func == 6'b001000)
`define R_jalr  (OpCode == 6'b000000 && func == 6'b001001)

//Type_SHIFT
`define sll		(OpCode == 6'b000000 && func == 6'b000000)
`define srl 	(OpCode == 6'b000000 && func == 6'b000010)
`define sra 	(OpCode == 6'b000000 && func == 6'b000011)


//Type_XALU
`define mult	(OpCode == 6'b000000 && func == 6'b011000)
`define multu	(OpCode == 6'b000000 && func == 6'b011001)
`define mfhi	(OpCode == 6'b000000 && func == 6'b010000)
`define mflo	(OpCode == 6'b000000 && func == 6'b010010)
`define mthi	(OpCode == 6'b000000 && func == 6'b010001)
`define mtlo	(OpCode == 6'b000000 && func == 6'b010011)
`define div		(OpCode == 6'b000000 && func == 6'b011010)
`define divu	(OpCode == 6'b000000 && func == 6'b011011)
`define madd	(OpCode == 6'b011100)

