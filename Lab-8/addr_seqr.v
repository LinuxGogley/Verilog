/**********************************************************************************
*	File Name: 	addr_seqr.v
*	Project:		Memory & Display Controllers
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date:	2016-03-06
*
*	Purpose:		Simple flip flop to increment each address by 1 bit until the limit
*					is reached and the address returns to the first address line.
*
*	Notes:		8 bit address incrementer from addr_step button. 
**********************************************************************************/
`timescale 1ns / 1ps

module addr_seqr(clk, reset, addr);
	
	input clk, reset;      // clk from board_clk 500Hz and universal reset
	
	output reg [7:0] addr; // Address location value.
	
	
	//*********************************************************************
	// Flip flop to increment value at each addr_step pulse from gated clk
	//*********************************************************************
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			addr <= 1'b0;
		else
			addr <= addr + 1'b1;
	end

endmodule
