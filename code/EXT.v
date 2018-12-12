`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:16:59 11/24/2018 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
	input 	[15:0]imm16,
	input 	EXTOp,
	output 	[31:0]EXTOut
    );
	 
	 assign EXTOut = (EXTOp == `EXT_sign)?{{16{imm16[15]}},imm16}:
							{{16{1'b0}},imm16};
							


endmodule
