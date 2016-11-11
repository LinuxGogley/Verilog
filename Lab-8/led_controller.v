/************************************************************************
*	File Name:	led_controller.v
*	Project: 	Memory & Display Controllers
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date: 	2016-03-01
*
*	Purpose:		Pull from a 480Hz frequency on the FPGA board to control
*              each pixel that is active high using a behavioral Moore
*              finite state machine.  At every positive edge clk or 
*              reset, the register is moved to the next state; from there
*              8 bits for the 8 anodes and 3 bits from the segment select
*              are concatenated to 11 bits to assert active low and high
*              states for their output values to the address mux.
*
*	Notes:		Uses two registers that fire using a four bit D flip flop.
************************************************************************/
`timescale 1ns / 1ps

module led_controller(clk, reset, seg_sel, an);
	
	input clk, reset;         // clk from led_clk, and universal reset
	
//*************************************************
// present and next state registers used for Moore
// FSM runs without user input at 480Hz
//*************************************************
	reg [2:0] present;        
	reg [2:0] next;           
	
	
	output reg [2:0] seg_sel; // output to ad_mux for pixel active
	output reg [7:0] an;      // 8 bits for 8 anodes to 7 seg display
	
	
//*************************************************
// Moore FSM moving the present to the next state
//*************************************************
	always @( present, next )
	   case ( present )
			3'b000  : next = 3'b001;
		   3'b001  : next = 3'b010;
		   3'b010  : next = 3'b011;
		   3'b011  : next = 3'b100;
		   3'b100  : next = 3'b101;
		   3'b101  : next = 3'b110;
		   3'b110  : next = 3'b111;
		   3'b111  : next = 3'b000;
		   default : next = 3'b000;
		endcase
			
//*************************************************
// 4 bit DFF to load each present state to the next
// state from the behavioral Moore FSM above
//*************************************************
   always @( posedge clk or posedge reset )
	   begin
		   if ( reset == 1'b1 )
		      present <= 3'b000;
		   else
            present <= next;
		end
		
//**************************************************
// Behavioral statement concatenating 11 bits of the 
// 8 anodes, and 3 bits of segment sel to the ad_mux
//**************************************************
	always @( present )
	   case ( present )
		   3'b000  : {an, seg_sel} = 11'b1111_1110_000;
		   3'b001  : {an, seg_sel} = 11'b1111_1101_001;
		   3'b010  : {an, seg_sel} = 11'b1111_1011_010;
		   3'b011  : {an, seg_sel} = 11'b1111_0111_011;
		   3'b100  : {an, seg_sel} = 11'b1110_1111_100;
		   3'b101  : {an, seg_sel} = 11'b1101_1111_101;
		   3'b110  : {an, seg_sel} = 11'b1011_1111_110;
		   3'b111  : {an, seg_sel} = 11'b0111_1111_111;
		   default : {an, seg_sel} = 11'b1111_1110_000;
	   endcase

endmodule
