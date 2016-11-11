/************************************************************************
*	File Name:	Display_Controller.v
*	Project: 	Memory & Display Controllers
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date: 	2016-03-01
*
*	Purpose:		Display_Controller top module for led_clk, led_controller, 
*              ad_mux, and hex_to_7_segment modules.
*
*	Notes:		Top module to hold Display Controller modules.
************************************************************************/
`timescale 1ns / 1ps

module disp_contr(clk, reset, anodes, seg, 
                    a, b, c, d, e, f, g, dp);
	
	input  clk, reset;    // Board clock, and universal reset
	
	input  [31:0] seg;    // 24 bit value to ad_mux to control pixel
	
	output a, b, c, d,    // Asserts the 7 segments and decimal point
	       e, f, g, dp;   
			 
	output [7:0] anodes;  // Asserts 8 anodes of 8 sev seg displays

	wire   clk_out;       // 480Hz clk freq to led_controller
	
	wire   [2:0] seg_sel; // Carries 3 bit segment select value to the mux
	wire   [3:0] hex;     // 4 bit value assigned to assert hex value
		
	led_clk    (clk, reset, clk_out);
	// Divides 100MHz clk to 480Hz, and sends freq to led_controller.
	

	led_controller  (clk_out, reset, seg_sel, anodes );
	// Carries led_clk freq from clk_out wire, and asserts anodes and
	// segments using behavioral Moore FSMs, and a DFF.
	
	
	ad_mux      (seg, seg_sel, hex);
	// Uses seg_sel value to assert the anode under control, and assigns
	// the segments according their binary inputs.
	
	
	hex_to_7_segment (hex, dp, g, f, e, d, c, b, a);
	// Carries binary value from wire hex, and asserts segments a-dp.


endmodule
