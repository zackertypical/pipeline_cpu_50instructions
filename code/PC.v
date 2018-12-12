`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:50:24 11/24/2018 
// Design Name: 
// Module Name:    PC
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
module PC(
	input [31:0] npc,
	output reg [31:0]pc,
	input en,
	input clk,
	input reset
    );
	 
	 initial begin
		pc <= 32'h00003000;
	 end
	 
	 always@(posedge clk)
	 begin
		if(reset)
			pc <= 32'h00003000;
		else 
		begin
			if(en)
				pc <= npc;
			else 
				pc <= pc;
		end
	 
	 end
endmodule
