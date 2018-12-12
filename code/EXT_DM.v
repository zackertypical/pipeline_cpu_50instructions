`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:09:00 12/03/2018 
// Design Name: 
// Module Name:    EXT_DM 
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
module EXT_DM(
	input[31:0]IR,
	input[31:0]in,
	input[1:0]A,
	output[31:0]out
    );
	 
	 wire [5:0]OpCode = IR[31:26];
	 
	 
	 assign out = 	(`lw)?	in:
						(`lb)?	(	(A[1:0] == 0)? {{24{in[7]}},	in[7:0]}:
									(A[1:0] == 1)? {{24{in[15]}},in[15:8]}:
									(A[1:0] == 2)? {{24{in[23]}},in[23:16]}:
									(A[1:0] == 3)? {{24{in[31]}},in[31:24]}:0):
						(`lbu)? (	(A[1:0] == 0)? {24'h0,			in[7:0]}:
									(A[1:0] == 1)? {24'h0,			in[15:8]}:
									(A[1:0] == 2)? {24'h0,			in[23:16]}:
									(A[1:0] == 3)? {24'h0,			in[31:24]}:0):
						(`lh)?	(	(A[1] == 0)? {{16{in[15]}},in[15:0]}:
													 {{16{in[31]}},in[31:16]}):
						(`lhu)?	(	(A[1] == 0)? {16'h0,in[15:0]}:
													 {16'h0,in[31:16]}):
						0;
						


endmodule
