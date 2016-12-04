/********************************************************
*	File Name:	D_FF.v
*	Project:		010110 Non Overlapping Sequence Detector
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date:	2016-02-11
*
*	Purpose:		The D Flip flop asserts two states, 
*					allowing for a single bit, either a 
*					0 or a 1 to be carried to the output Q,
*					if	reset set Q to a one bit 0.
*
*	Notes:		Four of these DFFs, allow for the data 
*					outputs of Q to be pushed back or 
*					carried through depending on their 	
*					conditions.
********************************************************/
`timescale 1ns / 1ps

module D_FF( clk, reset, D, Q );

	input clk, reset; 
	// Input data 'D'
	input D;
	// Output data 'Q'
	output reg Q;
	
	/* Positive edge triggered by clock or reset */
	always@(posedge clk or posedge reset)
	begin
	// If reset is active high, then assert Q as 0
		if ( reset == 1'b1 )
				Q <= 1'b0;
	// Else, assert blocking code to allow Q to equal 
	// input of D.
		else
				Q <= D;
	end
endmodule