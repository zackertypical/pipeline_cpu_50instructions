`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:12:48 11/25/2018 
// Design Name: 
// Module Name:    T_REG 
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
module T_REG (
	input			[1:0]in,
	output reg	[1:0]out,
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
			begin
				if(in == 0)
					out <= 0;
				else
					out <= in - 1;
			end
			else 
				out <= out;
		end 
	 end
	 
endmodule

