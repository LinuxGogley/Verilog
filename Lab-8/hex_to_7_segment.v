/**********************************************************************************
*	File Name: 	hex_to_7_segment.v
*	Project:		Memory & Display Controllers
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date:	2016-02-29
*
*	Purpose:		Overlapping sequence detector for the value 010110, 
*					the detector can switch	between a Moore when the M switch is 
*					active low, and Mealy when active high.
*
*	Notes:		A 2 to 1 mux is used to structurally switch between the two FSMs, 
*					the X acts as an input of 1 when active high, and 0 when low. 	
*					If the final state is reached for the sequence, Z is active.
**********************************************************************************/

`timescale 1ns / 1ps

module hex_to_7_segment(Q, dp, g, f, e, d, c, b, a);

input [3:0] Q;
output reg a,b,c,d,e,f,g,dp;

			always @(Q)
			case (Q)
			 //4'bXXXX: {a,b,c,d,e,f,g,dp} = 8'bABC_DEFG_dp;
				4'b0000: {a,b,c,d,e,f,g,dp} = 8'b000_0001_1;
				4'b0001: {a,b,c,d,e,f,g,dp} = 8'b100_1111_1;
				4'b0010: {a,b,c,d,e,f,g,dp} = 8'b001_0010_1;
				4'b0011: {a,b,c,d,e,f,g,dp} = 8'b000_0110_1;
				4'b0100: {a,b,c,d,e,f,g,dp} = 8'b100_1100_1;
				4'b0101: {a,b,c,d,e,f,g,dp} = 8'b010_0100_1;
				4'b0110: {a,b,c,d,e,f,g,dp} = 8'b010_0000_1;
				4'b0111: {a,b,c,d,e,f,g,dp} = 8'b000_1111_1;
				4'b1000: {a,b,c,d,e,f,g,dp} = 8'b000_0000_1;
				4'b1001: {a,b,c,d,e,f,g,dp} = 8'b000_0100_1;
				4'b1010: {a,b,c,d,e,f,g,dp} = 8'b000_1000_1;
				4'b1011: {a,b,c,d,e,f,g,dp} = 8'b110_0000_1;
				4'b1100: {a,b,c,d,e,f,g,dp} = 8'b011_0001_1;
				4'b1101: {a,b,c,d,e,f,g,dp} = 8'b100_0010_1;
				4'b1110: {a,b,c,d,e,f,g,dp} = 8'b011_0000_1;
				4'b1111: {a,b,c,d,e,f,g,dp} = 8'b011_1000_1;
				default: {a,b,c,d,e,f,g,dp} = 8'b000_0000_0;
			endcase
			
endmodule

