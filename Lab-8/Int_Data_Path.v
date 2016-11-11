/************************************************************************
*	File Name:	Int_Data_Path.v
*	Project: 	Integer Data Path
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

module Int_Data_Path(clk, reset, we,     W_Adr,   R_Adr,   S_Adr, 
                     DS,  s_sel, ALU_OP, N, Z, C, Reg_Out, Alu_Out);

	 input clk, reset, we, s_sel;
	 input [15:0] DS;
	 input [2:0]  W_Adr, R_Adr, S_Adr;
	 input [3:0]  ALU_OP;
	 
	 wire [15:0] S_Out;
	 wire [15:0] S_In;
	 output [15:0] Reg_Out;
	 output [15:0] Alu_Out;
	 output N, Z, C;

	 assign S_Out = (s_sel == 1'b0) ? S_In : DS;

	 reg_file       Register_File      (clk, reset, we, W_Adr, R_Adr, S_Adr, Alu_Out, Reg_Out, S_In);
	 
	 alu            ALU                (Reg_Out, S_Out, ALU_OP, Alu_Out, N, Z, C);

endmodule