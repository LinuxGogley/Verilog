/***********************************************************
*	File Name: 	test_seq_detector.v
*	Project:		010110 Non Overlapping Sequence Detector
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date:	2016-02-16
*
*	Purpose:		This testbench tests two states, a Moore fsm
*				   and a Mealy fsm when M is 0 or 1 respectively.
*					The tests checks if the sequence is detected 
*					from a 48 bit value string, and outputs a Z=1
*					when detected.
*
*	Notes:		Tested with a 10 ps clock using a 48 bit test
*					pattern.
**********************************************************/
`timescale 1ps / 100fs

module test_seq_detector();

		// declared inputs
		reg	clk, reset, X, M;

		// declared outputs
		wire 	Z;
		wire	[2:0] Q;

		// test declarations
		reg	[48:1] sequence_pattern;
		integer	i;

		// instantiates unit under test
		seq_detect uut (
			.clk(clk), .reset(reset),
			.M(M),	.X(X),
			.Q(Q),
			.Z(Z) );
		// creates a 10ps clock
		always
			#5 clk = ~clk;

	// initializes test block of the test pattern
	initial begin
		$timeformat(-12, 1, " ps", 8);
		clk = 0; reset = 0; X = 0; M = 0;
		// initializes a test pattern
		sequence_pattern = 48'b011001101011000110101101011011101001011001011011;
		
		@(negedge clk)// resets at every negative clk
			reset = 1;
		@(negedge clk)
			reset = 0;
			M = 1;	  // Moore implementation when M = 0;
						  // Mealy implementation when M = 1;

		for (i = 48; i > 0; i = i - 1) begin
			// change inputs at negative edge
			@(negedge clk)
				X = sequence_pattern[i];
			// display outputs after positive edge clock
			@(posedge clk)
				#1 $display("Time=%t X=%b Q=%b Z=%b", $time, X, Q, Z);
		end // end for
		$stop;
	end // end initial block

endmodule
