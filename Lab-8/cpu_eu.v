/************************************************************************
*	File Name:	cpu_eu.v
*	Project: 	CPU EU
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date: 	2016-04-29
*
*	Purpose:		Display_Controller top module for led_clk, led_controller, 
*              ad_mux, and hex_to_7_segment modules.
*
*	Notes:		Top module to hold Display Controller modules.
************************************************************************/
`timescale 1ns / 1ps

module cpu_eu(clk,       reset,  we,     
              W_Adr,     R_Adr,  S_Adr, 
				  IR_out,    IR_ld,  
				  PC_sel,    s_sel,  ad_sel,
				  Addr,      PC_inc, PC_ld,  
				  N,         Z,      C,   
				  D_in,      D_out,  ALU_OP);

	input clk, reset, we, s_sel, ad_sel, PC_sel;
	input [2:0] W_Adr, R_Adr, S_Adr;
	input [3:0] ALU_OP;
	input [15:0] D_in;
	input PC_inc, IR_ld, PC_ld;
	
	output N, Z, C;
	output [15:0] Addr, D_out, IR_out;
	
	wire [15:0] PC_in, PC_out, Reg_out, Sign_Ext, ADD_PC;
	wire IR_inc = 1'b0;
		
	assign PC_in = (PC_sel == 1'b1) ? D_out : ADD_PC;

	assign Addr = (ad_sel == 1'b1) ? Reg_out : PC_out;
	
	assign Sign_Ext = {{8{IR_out[7]}}, IR_out[7:0]};
	
	assign ADD_PC = PC_out + Sign_Ext;
		
	Int_Data_Path IDP (clk,  reset, we, W_Adr, R_Adr, S_Adr, 
	                   D_in, s_sel, ALU_OP, N, Z, C, Reg_out, D_out);						 
	
	reg16_LI      PC  (clk, reset, PC_ld, PC_inc, PC_in, PC_out),
	              IR  (clk, reset, IR_ld, IR_inc, D_in, IR_out);

endmodule
