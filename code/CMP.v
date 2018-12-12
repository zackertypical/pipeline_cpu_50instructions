`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:34 11/24/2018 
// Design Name: 
// Module Name:    CMP 
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
module CMP(
	input [2:0]CMPOp,
	input signed [31:0]CMPA,
	input signed [31:0]CMPB,
	output CMPOut
    );
	 
	assign CMPOut = (CMPOp == `CMP_beq)?	(CMPA == CMPB):
	 				(CMPOp == `CMP_bne)?	(CMPA != CMPB):
					(CMPOp == `CMP_blez)?	(CMPA <= 0):
					(CMPOp == `CMP_bgtz)?	(CMPA >  0):
					(CMPOp == `CMP_bltz)?	(CMPA <  0):
					(CMPOp == `CMP_bgez)?	(CMPA >= 0):
					0;
	
endmodule
