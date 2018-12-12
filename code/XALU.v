`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:37:24 12/03/2018 
// Design Name: 
// Module Name:    XALU 
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
module XALU(
	input signed [31:0] A,
	input signed [31:0] B,
	input [31:0]IR,
	input clk,
	input reset,
	output [31:0]XALU_OUT,
	///////////////////////////modified
	output start,
	output  busy
    );
	 
	 //cal
	reg [31:0] hi;
	reg [31:0] lo;
	//reg
	reg [31:0] HI;
	reg [31:0] LO;
	 
	wire [5:0]OpCode = 	IR[31:26];
	wire [5:0]func   = 	IR[5:0];
	 
	 //wire [63:0] result = A*B;
	 integer cnt;
	 
	 initial begin
		HI <= 0;
		LO <= 0;
		hi <= 0;
		lo <= 0;
		cnt <= 0;
	 end
	 
	 assign busy = (cnt == 0)?0:1;
	 //important
	 assign start = (`mult|`multu|`div|`divu|`madd)?1:0;
	 wire [63:0]md = A*B;
	 
	 always@(posedge clk)begin
		
		if(reset) 				begin hi <= 0;lo <= 0;cnt <= 0;HI <= 0;LO <= 0;end
		else
		begin
				  if(`mult)		begin	cnt <= 5;	{hi,lo} <= A*B;end
			else if(`multu)	begin cnt <= 5;	{hi,lo} <= {1'b0,A}*{1'b0,B};end
			else if(`div)		begin cnt <= 10;	hi <= A%B;	lo <= A/B;end
			else if(`divu)		begin cnt <= 10;	hi <= {1'b0,A}%{1'b0,B};lo <= {1'b0,A}/{1'b0,B};end
			else if(`mthi)		begin cnt <= 0;	hi	<= A; lo <= lo;HI<=A; LO<=LO;end
			else if(`mtlo)		begin cnt <= 0;	hi <= hi;lo <= A;HI<=HI; LO<=A;end
			else if(`madd)		begin cnt <= 5;   {hi,lo}<= {hi,lo}+md; end
			else if(cnt > 0)	begin cnt <= cnt - 1;		hi<=hi;	lo<=lo; if(cnt == 1)begin HI<=hi; LO<=lo; end  end
			else 					begin cnt <= cnt;	hi<=hi;	lo<=lo; end
		end
	 
	 end
	 
	 assign XALU_OUT = (`mfhi)?HI:
						(`mflo)?LO:
								0;
	 
	 
endmodule
