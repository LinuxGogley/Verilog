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
module debounce(D_in, clk_in, reset, D_out);
	// The following template provides a one-shot pulse
	// from a non-clock input (D_in)

	input D_in, clk_in, reset;
	output D_out;
	wire D_out;
	
	reg q9, q8, q7, q6, q5, q4, q3, q2, q1, q0;
	
	always @ (posedge clk_in or posedge reset)
		if (reset == 1'b1)
		{q9,q8,q7,q6,q5,q4,q3,q2,q1,q0} <= 10'b0;
		
		else 
			begin
				// shift in the new sample that's on the D_in input
				q9 <= q8; q8 <= q7; q7 <= q6; q6 <= q5; q5 <= q4;
				q4 <= q3; q3 <= q2; q2 <= q1; q1 <= q0; q0 <= D_in;
			end
		
		// create the debounced, one-shot output pulse
		assign D_out = !q9 & q8 & q7 & q6 & q5 & q4 & q3 & q2 & q1 & q0;


endmodule
