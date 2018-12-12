`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:41:58 11/24/2018 
// Design Name: 
// Module Name:    DM 
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
module DM(
	input [31:0]DataIn,
	input [31:0]MemAddr,
	input [31:0]pc,
   input [31:0]IR,
	input WrEn,
	input Reset,
	input Clk,
	output [31:0]DataOut
    );
	 wire [5:0]OpCode = IR[31:26];
	 reg [31:0]MemData[4096:0];
	 integer i;
	 //wire [1:0]end = MemAddr[1:0];
	 wire [31:2]ad = MemAddr[31:2];
	 
	 ///////////####
	 initial begin
	 	for(i = 0;i <4096;i = i+1)
			MemData[i] <= 0;
	 end
	 
	 always @(posedge Clk)
	 begin
		if(Reset)
		begin
			for(i = 0;i <4096;i = i+1)
				MemData[i] <= 0;
		end
		else
			if(WrEn)
			begin
				if(`sw)
					begin
						MemData[ad]<= DataIn;
						$display("%d@%h: *%h <= %h",$time, pc,{MemAddr[31:2],2'b00},DataIn);
					end
				else if(`sh)
					begin
						case (MemAddr[1])
						  0:
						  	begin
								MemData[ad][15:0] <= DataIn[15:0];
								$display("%d@%h: *%h <= %h",$time, pc,{MemAddr[31:2],2'b00},{MemData[ad][31:16],DataIn[15:0]});
						  	end
						  1:
						  	begin
								MemData[ad][31:16] <= DataIn[15:0];
								$display("%d@%h: *%h <= %h",$time, pc,{MemAddr[31:2],2'b00},{DataIn[15:0],MemData[ad][15:0]});			
						  	end
						endcase
					end
				else if(`sb)
					begin
						case(MemAddr[1:0])
						 2'b00:
						 begin
						 	MemData[ad][7:0] <= DataIn[7:0];
							$display("%d@%h: *%h <= %h",$time, pc,{MemAddr[31:2],2'b00},{MemData[ad][31:8],DataIn[7:0]});	
						 end
						 2'b01:
						 begin
							MemData[ad][15:8] <= DataIn[7:0];
							$display("%d@%h: *%h <= %h",$time, pc,{MemAddr[31:2],2'b00},{MemData[ad][31:16],DataIn[7:0],MemData[ad][7:0]});
						 end
						 2'b10:
						 begin
						 	MemData[ad][23:16] <= DataIn[7:0];
							$display("%d@%h: *%h <= %h",$time, pc,{MemAddr[31:2],2'b00},{MemData[ad][31:24],DataIn[7:0],MemData[ad][15:0]});
						 end
						 2'b11:
						 begin
							MemData[ad][31:24] <= DataIn[7:0];
							$display("%d@%h: *%h <= %h",$time, pc,{MemAddr[31:2],2'b00},{DataIn[7:0],MemData[ad][23:0]});
						 end
						endcase
					end
			end
	 end
	 assign DataOut = MemData[ad];


endmodule
