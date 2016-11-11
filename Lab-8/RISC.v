/************************************************************************
*	File Name:	RISC.v
*	Project: 	16-bit RISC Processor
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date: 	2016-03-18
*
*	Purpose:		IDP holding a 2 to 1 mux for controlling inputs from the  
*              register file to the arithmetic logic unit. The reg file
*              is used to hold to store 16 bit values across 8 registers,
*              and the alu uses the data from those registers to compute
*              arithmetic and logic operations.
*
*	Notes:		Holds the register file and alu modules.
************************************************************************/
`timescale 1ns / 1ps

module RISC(clk, reset, mw_en, Addr, status, N, Z, C, D_in, D_out);
				  
	input         clk, reset;
	input  [15:0] D_in;
	
	output        N, Z, C, mw_en;
	output [7:0]  status;
	output [15:0] Addr, D_out;
	
	wire          rw_en, ad_sel, s_sel, PC_sel, PC_inc, PC_ld;
	wire   [2:0]  W_Adr, R_Adr, S_Adr;
	wire   [3:0]  alu_op;
	wire   [15:0] MD_in, MD_out, IR_out;
	

	
	cpu_eu      CPU_EU     (clk,       reset,  rw_en,     
                           W_Adr,     R_Adr,  S_Adr, 
									IR_out,    IR_ld,
									PC_sel,    s_sel,  ad_sel,
									Addr,      PC_inc, PC_ld,  
				               N,         Z,      C,   
									D_in,      D_out,  alu_op);
		
	cu          CONTR_UNIT (clk,     reset,  IR_out, 
	                        N,       Z,      C, 
                           W_Adr,   R_Adr,  S_Adr, 
			                  ad_sel,  s_sel,
			                  PC_ld,   PC_inc, PC_sel, 
									IR_ld,   mw_en,  rw_en,  
									alu_op,  status  );	

endmodule
