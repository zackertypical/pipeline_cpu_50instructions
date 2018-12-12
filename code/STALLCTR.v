`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:01:08 11/25/2018 
// Design Name: 
// Module Name:    STALLCTR 
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
module STALLCTR(
	input stall,
	output PC_en,E_clr,D_en
    );
	 
	 assign PC_en = !stall;
	 assign E_clr = stall;
	 assign D_en = !stall;


endmodule
