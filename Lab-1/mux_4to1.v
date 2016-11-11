`timescale 1ns / 1ps
/*************************************************************************************
*	File Name: 
*	Project:		Shift Register
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date: 	2016-02-06
*
*	Purpose:
*
*	Notes:
*************************************************************************************/
module mux_4to1(D, C, B, A, M, Q);

input A, B, C, D;
input [1:0] M;

output reg Q;

	always@(M or A or B or C or D)
	begin
		case(M)
			2'b00 : Q = A;
			2'b01 : Q = B;
			2'b10 : Q = C;
			2'b11 : Q = D;
			default : Q = 1'bx;
		endcase
	end
endmodule
