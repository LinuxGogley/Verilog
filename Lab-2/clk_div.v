/**********************************************************
*	File Name:	clk_div.v
*	Project: 	010110 Non Overlapping Sequence Detector
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date: 	2016-02-11
*
*	Purpose:		Pull the 100MHz clock frequency on the
*					FPGA board to 500Hz for our evaluation.
*
*	Notes:		Used to create a working 500Hz clock pulse.
**********************************************************/
`timescale 1ns / 1ps

module clk_div(clk_in, reset, clk_out);

	input		clk_in, reset;
	output	clk_out;
	reg		clk_out;
	
	integer	i;
	
	//******************************************************
	// The following verilog code will "divide" an 
	// incoming clock by the 32-bit decimal value 
	// specified in the "if condition"
	//
	// The value of the counter that counts the incoming 
	//	clock ticks is equal to:
	// [ (Icoming Freq / Outgoing Freq) / 2 ]
	//******************************************************

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
			
			// since clk is 100MHz, 
			// and desired frequency is 500Hz
			// (100MHz/500Hz)/2 = 100000
		if (i >= 100000) 
			begin
				clk_out = ~clk_out; 
				// if clk pulse is 0, reset integer
				i = 0;
			end //if
		end //else
	end //always
	
endmodule
