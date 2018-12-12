`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:07:46 11/24/2018 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
	input [4:0]RA,
	input [4:0]RB,
	input [4:0]RW,
	input [31:0]WD,
	input Clk,
	input Reset,
	input WE,
	input [31:0]WPC,
	output [31:0] busA,
	output [31:0] busB
    );
	 
	 reg [31:0]Register[31:0];
	 integer i = 0;
	 initial begin
		for(i =0 ;i < 32;i = i+1)
			Register[i]<= 0;
	 end
	 
	 always@(posedge Clk)
	 begin
		if(Reset)
			for(i = 0;i < 32;i = i+1)
				Register[i] <= 0;
		else
		begin
			if(WE&(RW!=0))
			begin
				Register[RW] <= WD;
				$display("%d@%h: $%d <= %h",$time, WPC,RW,WD);
				//
			end
		
		end
	 end
	 
	 assign busA = (RA==0)?0:Register[RA];
	 assign busB = (RB==0)?0:Register[RB];
	 


endmodule
