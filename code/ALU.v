`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:20 11/24/2018 
// Design Name: 
// Module Name:    ALU 
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

module ALU(
	input signed [31:0]A,
	input signed [31:0]B,
	input [3:0]ALUCtr,
	output signed[31:0]Result
    );
   assign Result = 
		(ALUCtr == `ALU_addu)?	(A+B):
		(ALUCtr == `ALU_subu)?	(A-B):
		(ALUCtr == `ALU_and)?	(A&B):
		(ALUCtr == `ALU_or)?	(A|B):
		(ALUCtr == `ALU_sll16)?	(B<<16):
		(ALUCtr == `ALU_jal)?	B:
		(ALUCtr == `ALU_xor)?	A^B:
		(ALUCtr == `ALU_nor)?	~(A|B):
		(ALUCtr == `ALU_sll)?	A<<B[4:0]:
		(ALUCtr == `ALU_srl)?	A>>B[4:0]:
		(ALUCtr == `ALU_sra)?	$signed($signed(A)>>>B[4:0]):
		(ALUCtr == `ALU_slt)?	((A<B)?32'd1:32'd0):
		(ALUCtr == `ALU_sltu)?	(({0,A[30:0]}<{0,B[30:0]})?32'd1:32'd0):
		0;
		//jal直接将B输出

endmodule
