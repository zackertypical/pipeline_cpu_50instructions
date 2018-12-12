`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:33:16 11/24/2018 
// Design Name: 
// Module Name:    REG 
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
module REG #(parameter width = 8)(
	input		[width-1:0]in,
	output reg[width-1:0]out,
	input clk,
	input reset,
	input en
	
    );
	 
	 initial begin
		out <= 0;
	 end
	 
	 always @(posedge clk)
	 begin
		if (reset)
			out <= 0;
		else 
		begin 
			if(en)
				out <= in;
			else 
				out <= out;
		end 
	 end
	 
endmodule

