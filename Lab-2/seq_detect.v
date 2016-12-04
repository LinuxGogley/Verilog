/**********************************************************
*	File Name: 	seq_detect.v
*	Project:		010110 Non Overlapping Sequence Detector
*	Designer:	Liam Gogley
*	Email:		liam.gogley@linux.com
*	Rev. Date:	2016-02-16
*
*	Purpose:		Non overlapping sequence detector for the 
*					value 010110, the detector can switch 
*					between a Moore when the M switch is 
*					active low, and Mealy when active high.
*
*	Notes:		A 2 to 1 mux is used to structurally switch
*					between the two FSMs, the X acts as an input
*					of 1 when active high, and 0 when low. 	
*					If the final state is reached for the 
*					sequence, Z is active
***********************************************************/
`timescale 1ns / 1ps

module seq_detect(clk, reset, M, X, Q, Z);

// Moore and Mealy present state
wire [2:0] MooreQ; 
wire [2:0] MealyQ;

// Moore and Mealy present outputs
wire Moore_Z, Mealy_Z;

input clk, reset;

input M;				
// Switch from 0 -- Moore; 1 --active high

input X;				
// Switch from 0 -- active low; 1 -- active high

output [2:0]Q; 	// Present state mapped to 
						// Q for 2 to 1 mux
						
output Z; 			// Output of 1 if sequence 
						//is detected from 2 to 1 mux


	//********************************************
	//* 2-to-1 mux to choose Moore/Mealy Q’s and 
	//* Moore/Mealy Z for global outputs 
	//********************************************
	
	//********************************************
	//* if M==1 then {Q, Z} = {mooreQ, moore_Z} 
	//* else {Q, Z} = {mealyQ, mealy_Z}   
	//********************************************
	assign {Q,Z} = (M==1'b0) ? {MooreQ, Moore_Z} : {MealyQ, Mealy_Z};
	
	
	
	//********************************************
	//*	Moore sequence detector, 
	//*   initializes Moore D's -- next	state,
	//*   Qs -- present state from D flip flops.			
	//********************************************
	
	// assign Moore_D# =	( MooreQ[2] &	MooreQ[1] &  MooreQ[0] &  X)|
		assign Moore_D2 = (~MooreQ[2] &  MooreQ[1] &  MooreQ[0] &  X)|
								( MooreQ[2] & ~MooreQ[1] & ~MooreQ[0] &  X)|
								( MooreQ[2] & ~MooreQ[1] &  MooreQ[0] & ~X);
								
		assign Moore_D1 = (~MooreQ[2] &  MooreQ[1] & ~MooreQ[0] & ~X)|
								(~MooreQ[2] & ~MooreQ[1] &  MooreQ[0] &  X)|
								( MooreQ[2] & ~MooreQ[1] & ~MooreQ[0] & ~X)|
								( MooreQ[2] & ~MooreQ[1] &  MooreQ[0] & ~X);
								
		assign Moore_D0 = ( MooreQ[2] & ~MooreQ[1] & ~MooreQ[0] 	   )|
								(~MooreQ[2] &	 				 MooreQ[0] & ~X)|
								(							      ~MooreQ[0] & ~X);
	
	
	//	D_FF	 Moore_Q#	( clk,	reset,	Moore_D#,	MooreQ[#]),					
		D_FF 	 Moore_Q2	( clk,	reset, 	Moore_D2, 	MooreQ[2]),
				 Moore_Q1	( clk,	reset, 	Moore_D1, 	MooreQ[1]),
				 Moore_Q0	( clk,	reset, 	Moore_D0, 	MooreQ[0]);
				 
	
	// assign Moore_Z which is mapped to Z output from 2-to-1 mux.		 
		assign Moore_Z  = ( MooreQ[2] & MooreQ[1] &	~MooreQ[0] );					


	
	//**************************************************************
	//*	Moore sequence detector, initializes Mealy D's -- next	*
	//*	state, and Qs -- present state from D flip flops.			*
	//**************************************************************
	
	
	//	assign Mealy_D# =	( MealyQ[2] &  MealyQ[1] &  MealyQ[0] &  X )|
		assign Mealy_D2 = (~MealyQ[2] &  MealyQ[1] &  MealyQ[0] &  X )|
								( MealyQ[2] & ~MealyQ[1] & ~MealyQ[0] &  X );
										
		assign Mealy_D1 = (~MealyQ[2] &  MealyQ[1] & ~MealyQ[0] & ~X )|
								( MealyQ[2] & ~MealyQ[1] & ~MealyQ[0] & ~X )|
								(~MealyQ[2] & ~MealyQ[1] &  MealyQ[0] &  X );
								
		assign Mealy_D0 = ( MealyQ[2] & ~MealyQ[1] & ~MealyQ[0]	    )|
								(~MealyQ[2] &   				~MealyQ[0] & ~X )|
								(~MealyQ[2] & 				    MealyQ[0] & ~X );							
	
	//	D_FF	 Mealy_Q#	( clk,  reset,   Mealy_D#,   MealyQ[#]),
		D_FF	 Mealy_Q2	( clk,  reset,   Mealy_D2,   MealyQ[2]),
				 Mealy_Q1	( clk,  reset,   Mealy_D1,   MealyQ[1]),
				 Mealy_Q0	( clk,  reset,   Mealy_D0,   MealyQ[0]);
			

   // assign Mealy_Z which is mapped to Z output from 2-to-1 mux.
		assign Mealy_Z  = ( MealyQ[2] & ~MealyQ[1] &  MealyQ[0] & ~X );		


endmodule
