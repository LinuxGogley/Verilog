/***************************************************************************
*	File Name: 	debounce.v
*	Project:		010110 Non Overlapping Sequence Detector
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date:	2016-02-15
*
*	Purpose:		The debounce allows the select button to be fired, 
*					and send a steady signal as a an input.
*
*	Notes:		A one-shot is a method to prevent a constant signal produced 
*					by holding the select button. This is possible by allowing
*              10 registers, with 2ms per register, a total of 20ms passes
*              creating a debounced switch. At the end, the last register is 
*					accounted for with negative logic to prevent the user from 
*					carrying the output by holding the step.
***************************************************************************/
`timescale 1ns / 1ps

module debounce(D_in, clk_in, reset, D_out);
	// The following template provides a one-shot pulse
	// from a non-clock input (D_in)

	input D_in, clk_in, reset;
	output D_out;
	wire D_out;
	
	// 10 registers since 2ms per register, 
	// and 20ms needed for 500Hz to debounce
	reg q9, q8, q7, q6, q5, q4, q3, q2, q1, q0;
	
	always @ (posedge clk_in or posedge reset)
		if (reset == 1'b1)
		{q9,q8,q7,q6,q5,q4,q3,q2,q1,q0} <= 10'b0;
		
		else 
			begin
				// Shift in the D_in input signal to all ten registers
				q9 <=   q8;      q8 <=   q7; 
				q7 <=   q6;      q6 <=   q5; 
				q5 <=   q4;      q4 <=   q3; 
				q3 <=   q2;      q2 <=   q1; 
				q1 <=   q0;      q0 <= D_in;
			end
		
		//************************************************************
		// Creates the debounced, one-shot output pulse	by	asserting 
		//	negative logic on the last register to prevent a 
		//	longer signal than needed.	 	
		//************************************************************
		assign D_out = !q9 & q8 & q7 & q6 & q5 & q4 & q3 & q2 & q1 & q0;


endmodule
