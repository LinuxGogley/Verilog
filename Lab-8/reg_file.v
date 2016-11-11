/************************************************************************
*	File Name:	Register_File.v
*	Project: 	Integer Data Path
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date: 	2016-03-10
*
*	Purpose:		Display_Controller top module for led_clk, led_controller, 
*              ad_mux, and hex_to_7_segment modules.
*
*	Notes:		Top module to hold Display Controller modules.
************************************************************************/
`timescale 1ns / 1ps

module reg_file(clk, reset, we, W_Adr, R_Adr, S_Adr, W, R, S);
	 
	input  clk, reset, we;
	input  [2:0] W_Adr, R_Adr, S_Adr;

	input  [15:0] W; 
	
	output [15:0] R, S;					
	
	wire  L7, L6, L5, L4, L3, L2, L1, L0,
	      A7, A6, A5, A4, A3, A2, A1, A0,
			B7, B6, B5, B4, B3, B2, B1, B0;
	
	wire   en;
	assign en = 1'b1;
	 
	decode_3to8 W_Decode (W_Adr, we, L7, L6, L5, L4, L3, L2, L1, L0),
					R_Decode (R_Adr, en, A7, A6, A5, A4, A3, A2, A1, A0),
					S_Decode (S_Adr, en, B7, B6, B5, B4, B3, B2, B1, B0);
	
// reg16    	Reg#     (clk, reset, LD, W,  DA, DB, A#, B#),
	reg16  	   Reg0     (clk, reset, L0, W,  R,  S,  A0, B0),
			   	Reg1     (clk, reset, L1, W,  R,  S,  A1, B1),
				   Reg2     (clk, reset, L2, W,  R,  S,  A2, B2),
				   Reg3     (clk, reset, L3, W,  R,  S,  A3, B3),
				   Reg4     (clk, reset, L4, W,  R,  S,  A4, B4),
				   Reg5     (clk, reset, L5, W,  R,  S,  A5, B5),
				   Reg6     (clk, reset, L6, W,  R,  S,  A6, B6),
				   Reg7     (clk, reset, L7, W,  R,  S,  A7, B7);
	
endmodule