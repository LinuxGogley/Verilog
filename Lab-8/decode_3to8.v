/************************************************************************
*	File Name:	decode_3to8.v
*	Project: 	Register Files
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date: 	2016-03-09
*
*	Purpose:		Display_Controller top module for led_clk, led_controller, 
*              ad_mux, and hex_to_7_segment modules.
*
*	Notes:		Top module to hold Display Controller modules.
************************************************************************/
`timescale 1ns / 1ps

module decode_3to8(Din, en, Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0);
	
	input [2:0] Din;
	input       en;

	output reg Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0;
	
	always @( en, Din )
	begin
		case ({en, Din})
			4'b1000 : {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b0000_0001;
			4'b1001 : {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b0000_0010;
			4'b1010 : {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b0000_0100;
			4'b1011 : {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b0000_1000;
			4'b1100 : {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b0001_0000;
			4'b1101 : {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b0010_0000;
			4'b1110 : {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b0100_0000;
			4'b1111 : {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b1000_0000;
			default : {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b0000_0000;
		endcase
	end
	

endmodule