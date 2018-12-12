`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:31:12 11/24/2018 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
	input [31:0]PC4,
	input [31:0]PC_B,
	input [31:0]PC_J,
	input [31:0]PC_JR,
	input [1:0] NPCOp,
	input able,
	output [31:0]NPCOut
	//output isAdd
    );
	 
	 assign NPCOut = //(NPCOp == `NPC_add4)?PC4:
						  (NPCOp == `NPC_br)?((able == 1)?{PC_B[29:0],2'd0}+PC4:PC4+4):
						  (NPCOp == `NPC_j)?{PC4[31:28],PC_J[25:0],2'd0}:
						  (NPCOp == `NPC_jr)?PC_JR:
						  PC4+4;////BUG
	 //assign isAdd = (NPCOp == `NPC_add4)?1:0;
	 
endmodule
