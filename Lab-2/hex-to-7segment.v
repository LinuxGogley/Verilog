
`timescale 1ns / 1ps

module hex_to_7segment(bcd, leds);

input [3:0] bcd;
output reg [7:0] leds;

			always @(bcd)
			case (bcd)
				0: leds = 8'b00000011;
				1: leds = 8'b10011111;
				2: leds = 8'b00100101;
				3: leds = 8'b00001101;
				4: leds = 8'b10011001;
				5: leds = 8'b01001001;
				6: leds = 8'b01000001;
				7: leds = 8'b00011111;
				8: leds = 8'b00000001;
				9: leds = 8'b00001001;
				default: leds = 8'bx;
			endcase
endmodule
