/**********************************************************************************
*	File Name: 	reg16_LI.v
*	Project:		CPU EU
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

module reg16_LI(clk, reset, ld, inc, D, Q);

	input clk, reset, ld, inc;
	input [15:0] D;
	
	output reg [15:0] Q;
	
	always @(posedge clk or posedge reset)
	begin
		if (reset == 1'b1)
			Q <= 16'b0;
		else
			case ({ld, inc})
				2'b01   : Q <= Q + 16'b1;
				2'b10   : Q <= D;
				default : Q <= Q;
			endcase
	end

endmodule
