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

module lab8(clk, reset, step_clk, mem_step, dump_mem,
            Neg, Zero,  Carr, status, an, a, b, c, d, e, f, g, dp);
	 
	input clk, reset, step_clk, mem_step, dump_mem;
	
	output Neg, Zero, Carr,
	       a, b, c, d, e, f, g, dp;
	output [7:0] an, status;
	
	wire        clk_500, pulse_500, mw_en;
	wire [15:0] madr, mem_counter, Address, MD_in, MD_out; 
	wire [31:0] hex;
	
	assign madr = (dump_mem == 1'b1) ? mem_counter : Address;
	
	assign hex = {madr, MD_out};
	
	clk_div     CLK_500HZ  (clk, reset, clk_500);
	
	debounce    STEP_CLK   (step_clk, clk_500, reset, pulse_500);
	
	debounce    STEP_MEM   (mem_step, clk_500, reset, mem_pulse);
	 
	RISC        RISC       (pulse_500, reset, mw_en,
                           Address, status, Neg, Zero, Carr, MD_out, MD_in);
	 
	ram1        MEM_256x16 (clk_500, mw_en, madr, MD_in, MD_out);

	addr_seqr   MEM_COUNT  (mem_pulse, reset, mem_counter);
	 
	disp_contr  DISPLAY    (clk,  reset,   an,   hex, 
                           a, b, c, d, e, f, g, dp  );

endmodule
