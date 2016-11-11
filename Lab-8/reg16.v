/************************************************************************
*	File Name:	reg16.v
*	Project: 	Register Files
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date: 	2016-03-09
*
*	Purpose:		Display_Controller top module for led_clk, led_controller, 
*              ad_mux, and hex_to_7_segment modules.
*
*	Notes:		Top module to hold Display Controller modules.
************************************************************************/
`timescale 1ns / 1ps

module reg16(clk, reset, ld, Din, DA, DB, oeA, oeB);
	
	input         clk, reset, ld, oeA, oeB;
	input  [15:0] Din;
	
	output [15:0] DA, DB;
	reg    [15:0] Dout;
	
	// Behavioral section for writing to the register
	always @(posedge clk or posedge reset)
		 if (reset)
			Dout <= 16'b0;
		 else 
			if (ld)
				Dout <= Din;
			else
				Dout <= Dout;
	
	// Conditional continous assignments for reading the register
	assign DA = oeA ? Dout : 16'hz;
	assign DB = oeB ? Dout : 16'hz;

endmodule
