/************************************************************************
*	File Name:	ad_mux.v
*	Project: 	Memory & Display Controllers
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date: 	2016-02-29
*
*	Purpose:		8 to 1 mux, with two outputs asserted as permanent 4'b0000 
*              while the [23:0] I comes from the 16 onboard switches for 
*              the four 4 bit hex values on the seven segment display, 
*              and 8 bit values from the current address location value.
*
*	Notes:		8 to 1 mux with 6 active states.
************************************************************************/
`timescale 1ns / 1ps

module ad_mux(I, seg_sel, Q);

	input [31:0] I;        // 32 bit input from switches and address loc
	input [2:0]  seg_sel;  // segment select from led_controller FSM

	output reg [3:0] Q;    // 4 bit output to assign controlled pixel


//*****************************************
// Behavioral model to assert Q output from
// 3 bit seg_sel value of ad_mux module
//*****************************************
	always @(seg_sel or I)
	begin
		case(seg_sel)
			3'b000  : Q = I[3:0];
			3'b001  : Q = I[7:4];
			3'b010  : Q = I[11:8];
			3'b011  : Q = I[15:12];
			3'b100  : Q = I[19:16];
			3'b101  : Q = I[23:20];
			3'b110  : Q = I[27:24];
			3'b111  : Q = I[31:28];
			default : Q = 4'b0000;
		endcase
	end
endmodule
