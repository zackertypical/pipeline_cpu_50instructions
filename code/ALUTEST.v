`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:52:48 12/01/2018
// Design Name:   ALU
// Module Name:   C:/hdl/p6/ALUTEST.v
// Project Name:  p5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALUTEST;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg [3:0] ALUCtr;

	// Outputs
	wire [31:0] Result;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.A(A), 
		.B(B), 
		.ALUCtr(ALUCtr), 
		.Result(Result)
	);

	initial begin
		// Initialize Inputs
		A = 5'b10001;
		B = 32'd123;
		ALUCtr = 8;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

