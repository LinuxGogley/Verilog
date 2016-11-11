`timescale 1ns / 1ps
/*************************************************************************************
*	File Name:	clock divider
*	Project: 	4 bit shift register
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date: 	2016-02-05
*
*	Purpose:		Pull the 100MHz clock frequency on the Nexys 4 DDR board
*					to 500Hz for evaluation purposes.
*
*	Notes:
*************************************************************************************/
module clk_div(clk_in, reset, clk_out);

	input		clk_in, reset;
	output	clk_out;
	reg		clk_out;
	
	integer	i;
	
	//*********************************************************************
	// The following verilog code will "divide" an incoming clock
	// by the 32-bit decimal value specified in the "if condition"
	//
	// The value of the counter that counts the incoming clock ticks
	// is equal to [ (Icoming Freq / Outgoing Freq) / 2 ]
	//*********************************************************************

	always @(posedge clk_in or posedge reset) 
	begin
		if (reset == 1'b1) 
		begin
			i = 0;
			clk_out = 0;
		end
		// got a clock, so increment the counter and
		// test to see if half a period has elapsed
		else 
		begin
			i = i + 1;
			if (i >= 100000) 
			begin
				clk_out = ~clk_out;
				i = 0;
			end //if
		end //else
	end //always
	
endmodule