`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:54:46 11/25/2018 
// Design Name: 
// Module Name:    mux 
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
module mux2#(parameter WIDTH = 8)(
	input s,
	input [WIDTH-1:0]D0,
	input [WIDTH-1:0]D1,
	output [WIDTH-1:0]out
	);
	assign out = (s == 0)?D0:D1;
endmodule


module mux3#(parameter WIDTH = 8)(
	input [1:0]s,
	input [WIDTH-1:0]D0,
	input [WIDTH-1:0]D1,
	input [WIDTH-1:0]D2,
	output [WIDTH-1:0]out);
	assign out = (s == 0)?D0:
					 (s == 1)?D1:
					 (s == 2)?D2:
					 0;
endmodule

module mux4#(parameter WIDTH = 8)(
	input [1:0]s,
	input [WIDTH-1:0]D0,
	input [WIDTH-1:0]D1,
	input [WIDTH-1:0]D2,
	input [WIDTH-1:0]D3,
	output [WIDTH-1:0]out);
	assign out = (s == 0)?D0:
					 (s == 1)?D1:
					 (s == 2)?D2:
					 (s == 3)?D3:
					 0;
endmodule
module mux5#(parameter WIDTH = 8)(
	input 	[2:0]s,
	input 	[WIDTH-1:0]D0,
	input 	[WIDTH-1:0]D1,
	input 	[WIDTH-1:0]D2,
	input 	[WIDTH-1:0]D3,
	input 	[WIDTH-1:0]D4,
	output 	[WIDTH-1:0]out);
	assign out = 	(s == 0)?D0:
					(s == 1)?D1:
					(s == 2)?D2:
					(s == 3)?D3:
					(s == 4)?D4:
					0;
endmodule

