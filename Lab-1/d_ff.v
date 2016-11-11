`timescale 1ns / 1ps
/*************************************************************************************
*	File Name: 
*	Project:		Shift Register
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date:	2016-02-06
*
*	Purpose:
*
*	Notes:
*************************************************************************************/
module d_ff( clk, reset, D, Q );
	input D, clk, reset;
	output reg Q;
	
	always@(posedge clk or posedge reset)
	begin
		if (reset == 1'b1)
				Q <= 1'b0;
		else
				Q <= D;
	end
endmodule
