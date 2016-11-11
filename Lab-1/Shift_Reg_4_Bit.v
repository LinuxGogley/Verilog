`timescale 1ns / 1ps
/*************************************************************************************
*	File Name: 
*	Project:		Shift Register
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date:	2016-02-07
*
*	Purpose:
*
*	Notes:
*************************************************************************************/
module Shift_Reg_4_Bit(clk, reset, SI, D, M, Q);
	
	input wire		SI, reset, clk;
	input wire		[3:0] D;
	input	wire		[1:0] M;
	output wire		[3:0] Q;
	
	wire		w0,  w1,  w2,  w3;
	
	//			m#	( I3,		I2,	 	I1,   	I0,   	Sel, 	wire);
	mux_4to1 m0 ( Q[1],  Q[3], 	D[0],   	Q[0],		M, 	w0 ),
				m1 ( Q[2], 	Q[0], 	D[1], 	Q[1], 	M, 	w1 ),
				m2 ( Q[3],	Q[1], 	D[2], 	Q[2], 	M, 	w2 ),
				m3 ( SI, 	Q[2], 	D[3], 	Q[3], 	M, 	w3 );
				
	//			d# ( clk,	reset,	wire,		Q);
	d_ff		d0 ( clk, 	reset,	w0, 		Q[0] ),
				d1 ( clk,	reset,	w1, 		Q[1] ),
				d2 ( clk,	reset,	w2, 		Q[2] ),
				d3 ( clk,	reset,	w3, 		Q[3] );

endmodule