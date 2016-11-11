/**********************************************************************************
*	File Name: 	ram1.v
*	Project:		Memory & Display Controllers
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date:	2016-03-06
*
*	Purpose:		Ram built with IP Coregen 16 bit write width by 256 bit write depth.
*					Using this module, the user can assert 16 bits of data into the ram
*					controller and view the values entered on the seven segment display.
*
*	Notes:		ram_256x16 from IP Coregen is device under test by the ram1 module.
**********************************************************************************/
`timescale 1ns / 1ps

module ram1(clk, we, addr, din, dout);

	input  clk,   we;   // clk and write enable step inputs
	input  [7:0]  addr; // 8 bits of address values an address sequencer
	input  [15:0] din;  // 16 bits of input data
	
	output [15:0] dout; // 16 bit output for 00 to FF addresses
	
	
	//***************************************************************
	// IP Coregen instantiated 256x16 ram controller, with values of
	// the memory addresses to execute operations.
	//***************************************************************
	ram_256x16 dut ( .clka (clk), 
						  .wea  (we), 
						  .addra(addr), 
						  .dina (din), 
						  .douta(dout) );

endmodule
