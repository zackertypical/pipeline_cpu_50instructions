`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:58:50 11/24/2018 
// Design Name: 
// Module Name:    IM 
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
module IM(
	input [31:0] IMAddr,
	output[31:0] IMOut
    );
	 
	 reg 	[31:0] 	IMData[4096:0];
	 wire [31:0]	addr;
	 integer	i = 0;
	 initial begin 
		for (i=0;i<=4096;i=i+1) 
			IMData[i]=0;
		$readmemh("code.txt",IMData);
	 end
	 assign addr = (IMAddr-32'h00003000)/4;
	 assign IMOut = IMData[addr];

endmodule
